/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ambimmort.app.framework.core;

import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.health.HealthCheckRegistry;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;
import org.apache.maven.model.Model;
import org.apache.maven.model.io.xpp3.MavenXpp3Reader;
import org.hyperic.sigar.Sigar;
import org.hyperic.sigar.SigarException;

import java.io.*;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author hedingwei
 */
public class Application {

    private static Logger logger = Logger.getLogger(Application.class);

    private static Application instance = null;

    private MetricRegistry metricRegistry = new MetricRegistry();

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private String version = null;

    private String groupId = null;

    private String artifactId = null;

    private String buildTime = null;

    private Sigar sigar = new Sigar();

    private Model pomModel = null;

    private Map env = null;

    private Application() {

        loadBasicInfo();
        try {
            env = getSigar().getProcEnv(getPid());
        } catch (SigarException ex) {

            logger.error(ex);
        }

        Timer timer = new Timer();
        timer.schedule(new TimerTask() {
            @Override
            public void run() {
                try {
                    getMetricRegistry().meter("rate-mem").mark(getSigar().getProcMem(getSigar().getPid()).getResident());
                    metricRegistry.histogram("mem").update(getSigar().getProcMem(getSigar().getPid()).getResident());
                } catch (SigarException ex) {
                    logger.error(ex);
                }
            }
        }, 1000, 1000);
    }

    public static Application getInstance() {
        if (instance == null) {
            instance = new Application();
        }
        return instance;
    }

    public Sigar getSigar() {
        return sigar;
    }

    public MetricRegistry getMetricRegistry() {
        return metricRegistry;
    }

    public Model getPomModel() {
        return pomModel;
    }

    public String format(Date date) {
        return sdf.format(date);
    }

    public Date time(String time) throws ParseException {
        return sdf.parse(time);
    }

    public double getCpuPercent() {
        try {
            return sigar.getProcCpu(getPid()).getPercent();
        } catch (SigarException ex) {
            return 0;
        }
    }

    public File getEtcDir() {
        return new File("etc");
    }

    public File getLibDir() {
        return new File("lib");
    }

    public File getLogsDir() {
        return new File("logs");
    }

    public String getJaveHome() {
        String s = System.getenv("JAVA_HOME");
        if (s == null) {
            s = System.getProperty("java.home");
            if (s == null) {
                return null;
            } else {
                return s;
            }
        } else {
            return s;
        }
    }

    public String getJDKVersion() {
        return System.getProperty("java.version");
    }

    public String[] getArgs() {
        try {
            return sigar.getProcArgs(getPid());
        } catch (SigarException ex) {
            logger.error(ex);
            return new String[]{};
        }
    }

    public String getWorkingDir() {
        try {
            return getSigar().getProcExe(getPid()).getCwd();
        } catch (SigarException ex) {
            logger.error(ex);
            return "";
        }
    }

    public String getApplicaltionName() {
        if (isRunWithExecPlugin()) {
            try {
                String p = sigar.getProcExe(sigar.getPid()).getCwd();
                return p.substring(p.lastIndexOf(File.separator) + File.separator.length());
            } catch (SigarException ex) {
                logger.error(ex);
                return "";
            }
        } else if (isRunWithJSW()) {
            return new File("logs").list(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    return name.endsWith(".pid");
                }
            })[0].replace(".pid", "");
        } else {
            System.exit(-1);
            return null;
        }
    }

    public long getPid() {
        return sigar.getPid();
    }

    public String getVersion() {
        return version;
    }

    public String getGroupId() {
        return groupId;
    }

    public String getArtifactId() {
        return artifactId;
    }

    public String getBuildTime() {
        return buildTime;
    }

    public boolean isRunWithExecPlugin() {
        try {
            String[] args = sigar.getProcArgs(getPid());
            return args[args.length - 1].equals("tomcat7:run");
        } catch (SigarException ex) {
            logger.error(ex);
            return false;
        }
    }

    public boolean isRunWithJSW() {
        String[] args = null;
        try {
            args = sigar.getProcArgs(getPid());
        } catch (SigarException ex) {
            logger.error(ex);
            return false;
        }
        if (args[args.length - 3].equals("org.apache.tomcat.maven.runner.Tomcat7RunnerCli")) {
            return true;
        } else {
            return false;
        }
    }

    public Date getStartTime() {
        try {
            return new Date(sigar.getProcTime(getPid()).getStartTime());
        } catch (SigarException ex) {
            logger.error(ex);
            return new Date(System.currentTimeMillis());
        }
    }

    private void loadBasicInfo() {
        if (isRunWithExecPlugin()) {
            MavenXpp3Reader reader = new MavenXpp3Reader();
            try {
                Model model = reader.read(new FileReader(getWorkingDir() + File.separator + "pom.xml"));
                this.groupId = model.getGroupId();
                this.artifactId = model.getArtifactId();
                this.version = model.getModelVersion();
                buildTime = format(getStartTime());
                pomModel = model;
            } catch (Exception ex) {
                logger.error(ex);
            }
        } else if (isRunWithJSW()) try {
            MavenXpp3Reader reader = new MavenXpp3Reader();
            Properties p = new Properties();
            InputStream is = new FileInputStream("etc/build.properties");

            p.load(is);
            version = p.getProperty("version", "");
            groupId = p.getProperty("groupId", "");
            artifactId = p.getProperty("artifactId", "");
            buildTime = format(new Date(new File("lib/" + artifactId + "-" + version + ".war").lastModified()));
            is.close();
            File ppom = new File(".extract/webapps/ROOT/" + "/META-INF/maven/" + groupId + "/" + artifactId + "/pom.xml");
            pomModel = reader.read(new FileInputStream(ppom));

        } catch (Exception e) {
            // ignore
            e.printStackTrace();
        }
        else {
            try {
                System.out.println(JSONArray.fromObject(sigar.getProcArgs(getPid())));
                System.out.println("here exit");
                System.exit(-1);
            } catch (SigarException ex) {
                logger.error(ex);
            }
        }

    }

    public Date now() {
        return new Date(System.currentTimeMillis());
    }

    public long getMemoryResident() {
        try {
            return sigar.getProcMem(sigar.getPid()).getResident();
        } catch (SigarException ex) {
            logger.error(ex);
            return 0;
        }
    }

    public long getMemorySize() {
        try {
            return sigar.getProcMem(sigar.getPid()).getSize();
        } catch (SigarException ex) {
            logger.error(ex);
            return 0;
        }
    }

    public long getMemoryShare() {
        try {
            return sigar.getProcMem(sigar.getPid()).getShare();
        } catch (SigarException ex) {
            logger.error(ex);
            return 0;
        }
    }

    public long getMemoryActualFree() {
        try {
            return sigar.getMem().getActualFree();
        } catch (SigarException ex) {
            logger.error(ex);
            return 0;
        }
    }

    public long getMemoryActualTotal() {
        try {
            return sigar.getMem().getTotal();
        } catch (SigarException ex) {
            logger.error(ex);
            return 0;
        }
    }

    public MemoryUsage getMemoryHeap() {
        MemoryMXBean memBean = ManagementFactory.getMemoryMXBean();
        MemoryUsage heap = memBean.getHeapMemoryUsage();
        return heap;
    }

    public MemoryUsage getMemoryNonHeap() {
        MemoryMXBean memBean = ManagementFactory.getMemoryMXBean();
        MemoryUsage nonHeap = memBean.getNonHeapMemoryUsage();
        return nonHeap;
    }

    public int getObjectPendingFinalizationCount() {
        MemoryMXBean memBean = ManagementFactory.getMemoryMXBean();
        return memBean.getObjectPendingFinalizationCount();
    }

    public int getCurrentRunningThreads(){
        return ManagementFactory.getThreadMXBean().getThreadCount();
    }

}
