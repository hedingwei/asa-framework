/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ambimmort.app.framework.core;

import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.servlets.MetricsServlet;

/**
 * Web application lifecycle listener.
 *
 * @author hedingwei
 */
public class AppMetricsServletListener extends MetricsServlet.ContextListener {

    @Override
    protected MetricRegistry getMetricRegistry() {
        return Application.getInstance().getMetricRegistry();
    }

}
