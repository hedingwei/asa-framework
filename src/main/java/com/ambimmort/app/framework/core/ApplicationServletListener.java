/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ambimmort.app.framework.core;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Enumeration;

/**
 * Web application lifecycle listener.
 *
 * @author hedingwei
 */
public class ApplicationServletListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Application.getInstance();
        Enumeration e = LogManager.getCurrentLoggers();
        while (e.hasMoreElements()) {
            Logger loger = (Logger) e.nextElement();
            System.out.println(loger.getName() + "\t" + loger.getLevel());
        }

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
