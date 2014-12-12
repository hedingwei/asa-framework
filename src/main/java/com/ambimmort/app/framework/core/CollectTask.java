/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ambimmort.app.framework.core;

import org.apache.log4j.Logger;
import org.rrd4j.core.Sample;
import org.rrd4j.core.Util;

import java.io.IOException;

/**
 * @author hedingwei
 */
public class CollectTask {

    private static final Logger logger = Logger.getLogger(CollectTask.class);

    public void run() {

        try {

            Sample sample = RRD.getInstance().getSample();
            sample.setTime(Util.getTimestamp());
            sample.setValue("memory", Application.getInstance().getMemoryResident() / 1024.0 / 1024.0 + 0.0d);
            sample.setValue("memory-percent", ((double)Application.getInstance().getMemoryResident())/Application.getInstance().getMemoryActualTotal()+0.0d);
            sample.setValue("cpu", Application.getInstance().getCpuPercent()+0.0d);
            sample.setValue("memory-heap",Application.getInstance().getMemoryHeap().getUsed()+0.0d);
            sample.setValue("memory-nonheap",Application.getInstance().getMemoryNonHeap().getUsed()+0.0d);
            sample.update();

        } catch (IOException ex) {
            ex.printStackTrace();
            logger.error(ex);
        }

    }
}
