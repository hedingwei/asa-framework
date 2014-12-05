/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ambimmort.app.framework.controller.logic;

import com.ambimmort.app.framework.core.Application;
import java.util.HashMap;
import java.util.Map;
import net.sf.json.JSONObject;
import org.hyperic.sigar.DirUsage;
import org.hyperic.sigar.ProcMem;
import org.hyperic.sigar.Sigar;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/system")
public class SystemController {

    private Sigar sigar = new Sigar();

    @RequestMapping(value = "/dashboard.do", method = RequestMethod.GET)
    public String viewDashboard(ModelMap model) {
        try {
            model.addAttribute("pid", sigar.getPid());
            model.addAttribute("args", sigar.getProcArgs(sigar.getPid()));
            model.addAttribute("exe", JSONObject.fromObject(sigar.getProcExe(sigar.getPid()).toMap()).toString(4));
            model.addAttribute("env", JSONObject.fromObject(sigar.getProcEnv(sigar.getPid())).toString(4));
            model.addAttribute("mem", JSONObject.fromObject(sigar.getProcMem(sigar.getPid()).toMap()).toString(4));
            model.addAttribute("state", JSONObject.fromObject(sigar.getProcState(sigar.getPid()).toMap()).toString(4));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "dashboard";
    }

    @RequestMapping(value = "/general.do", method = RequestMethod.GET)
    public String viewGeneral(ModelMap model) {

        try {
            if (Application.getInstance().isRunWithExecPlugin()) {
                model.addAttribute("model", "开发模式：run by tomcat7:run");
            } else if (Application.getInstance().isRunWithJSW()) {
                model.addAttribute("model", "生产模式：run by jsw");
            }

            Map<String, String> map = new HashMap<String, String>();
            for (String key : System.getProperties().stringPropertyNames()) {
                map.put(key, System.getProperties().getProperty(key));
            }
            model.addAttribute("syspros", map);

            model.addAttribute("groupId", Application.getInstance().getGroupId());
            model.addAttribute("artifactId", Application.getInstance().getArtifactId());
            model.addAttribute("version", Application.getInstance().getVersion());
            model.addAttribute("buildtime", Application.getInstance().getBuildTime());
            model.addAttribute("pid", sigar.getPid());
            model.addAttribute("jdk", Application.getInstance().getJDKVersion());
            model.addAttribute("jdk_home", Application.getInstance().getJaveHome());
            model.addAttribute("cwd", Application.getInstance().getWorkingDir());
            try {
                model.addAttribute("logs_dir_usage", sigar.getDirUsage(Application.getInstance().getLogsDir().getAbsolutePath()));
            } catch (Exception e) {
                DirUsage du = new DirUsage();
                model.addAttribute("logs_dir_usage", du.toMap());
            }

            ProcMem mem = sigar.getProcMem(sigar.getPid());
            model.addAttribute("mem_resident", String.format("%.2f", mem.getResident() / 1024 / 1024f));
            model.addAttribute("mem_percent", String.format("%.2f", ((float)mem.getResident()) / sigar.getMem().getTotal() * 100f));
            model.addAttribute("env", JSONObject.fromObject(sigar.getProcEnv(sigar.getPid())).toString(4));

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "general";
    }

    @RequestMapping(value = "/args.do", method = RequestMethod.GET)
    public String viewArgs(ModelMap model) {
        try {
            model.addAttribute("pid", sigar.getPid());
            model.addAttribute("args", sigar.getProcArgs(sigar.getPid()));
            model.addAttribute("exe", JSONObject.fromObject(sigar.getProcExe(sigar.getPid()).toMap()).toString(4));
            model.addAttribute("env", JSONObject.fromObject(sigar.getProcEnv(sigar.getPid())).toString(4));
//            model.addAttribute("fd", JSONObject.fromObject(sigar.getProcFd(sigar.getPid()).toMap()).toString(4));
            model.addAttribute("mem", JSONObject.fromObject(sigar.getProcMem(sigar.getPid()).toMap()).toString(4));
            model.addAttribute("state", JSONObject.fromObject(sigar.getProcState(sigar.getPid()).toMap()).toString(4));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "args";
    }
}