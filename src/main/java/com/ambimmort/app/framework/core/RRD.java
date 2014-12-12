/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ambimmort.app.framework.core;

import org.apache.log4j.Logger;
import org.rrd4j.ConsolFun;
import org.rrd4j.DsType;
import org.rrd4j.core.RrdDb;
import org.rrd4j.core.RrdDef;
import org.rrd4j.core.Sample;

import java.io.File;
import java.io.IOException;

/**
 * @author hedingwei
 */
public class RRD {

    private static Logger logger = Logger.getLogger(RRD.class);

    private static RRD instance = null;

    private RrdDef rrdDef = null;

    private RrdDb db = null;

    private Sample sample = null;

    private RRD() {
        System.out.println("RRD Object Creation: Thread:"+Thread.currentThread().getId());
        String dataFile = null;
        if (Application.getInstance().isRunWithExecPlugin()) {
            dataFile = "_data.rrd";
        } else if (Application.getInstance().isRunWithJSW()) {
            dataFile = "data/_data.rrd";
        }
        if (dataFile == null) {
            logger.error("RRD Can not sltart. Application exit now");
            System.exit(-1);
        }

        long start = System.currentTimeMillis() / 1000;
        int step = 10;
        File file = new File(dataFile);
        System.out.println("rrd file : " + file.getAbsolutePath());
        if ((!file.exists()) && (this.db == null)) {

            rrdDef = new RrdDef(file.getAbsolutePath());
            rrdDef.setStartTime(start);
            rrdDef.setVersion(2);
            rrdDef.setStep(step);
            rrdDef.addDatasource("memory", DsType.GAUGE, step * 2, 0, Double.NaN);
            rrdDef.addDatasource("memory-percent",DsType.GAUGE,step*2,0,Double.NaN);
            rrdDef.addDatasource("memory-heap",DsType.GAUGE,step*2,0,Double.NaN);
            rrdDef.addDatasource("memory-nonheap",DsType.GAUGE,step*2,0,Double.NaN);
            rrdDef.addDatasource("cpu", DsType.GAUGE, step*2, 0, Double.NaN);
            rrdDef.addDatasource("threads", DsType.GAUGE, step*2, 0, Double.NaN);
            /**
             * 每分钟一个存档, 两年共计 2*365*24*60
             */
            rrdDef.addArchive(ConsolFun.AVERAGE, 0.5, 1, 6* 30);

            System.out.println("created 5 add Archinve:" + rrdDef.getArcCount());
            // Create and check the database
            System.out.println((rrdDef.dump()));

            System.out.println("okkkkkkk");

            System.out.println("Estimated file size: " + rrdDef.getEstimatedSize() / 1024.0 / 1024);
            try {
                db = new RrdDb(rrdDef);

                db.close();

            } catch (Exception e) {
                e.printStackTrace();
            }

            System.out.println("database created. ");

        } else {
            rrdDef = new RrdDef(file.getAbsolutePath());
            rrdDef.setStartTime(start);
            rrdDef.setVersion(2);
            rrdDef.setStep(step);
            rrdDef.addDatasource("memory", DsType.GAUGE, step * 2, 0, Double.NaN);
            rrdDef.addDatasource("memory-percent", DsType.GAUGE, step * 2, 0, Double.NaN);
            rrdDef.addDatasource("memory-heap", DsType.GAUGE, step * 2, 0, Double.NaN);
            rrdDef.addDatasource("memory-nonheap", DsType.GAUGE, step * 2, 0, Double.NaN);
            rrdDef.addDatasource("cpu", DsType.GAUGE, step*2, 0, Double.NaN);
            rrdDef.addDatasource("threads", DsType.GAUGE, step*2, 0, Double.NaN);

            rrdDef.addArchive(ConsolFun.AVERAGE, 0.5, 1, 6* 30);
        }

        try {
            assert rrdDef != null;
            db = new RrdDb(rrdDef);

            System.out.println(db);
        } catch (IOException ex) {
            ex.printStackTrace();
            logger.error(ex);
        }
    }

    public static RRD getInstance() {
        if (instance == null) {
            instance = new RRD();
        }
        return instance;
    }


    public Sample getSample() {
        if(sample==null){
            try {
                sample = getDb().createSample();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return sample;
    }

    public RrdDef getRrdDef() {
        return rrdDef;
    }

    public RrdDb getDb() {
        return db;
    }

    public void start() {

    }

    public void close() {
        try {
            db.close();
        } catch (IOException ex) {
            logger.error(ex);
        }
    }

}
