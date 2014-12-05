package com.ambimmort.app.framework.monitor;

import com.codahale.metrics.MetricRegistry;

interface CanRegisterGauges {

    /**
     * Register zero or more Gauges in the given registry.
     */
    public void registerGauges(MetricRegistry registry);

}


