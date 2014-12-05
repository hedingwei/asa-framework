/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ambimmort.app.framework.controller.rest;

import com.ambimmort.app.framework.core.RRD;
import org.rrd4j.ConsolFun;
import org.rrd4j.core.FetchData;
import org.rrd4j.core.FetchRequest;
import org.rrd4j.core.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;

@Controller
@RequestMapping("/rrd")
public class ServiceController {

    @RequestMapping(value = "/query/{name}/{length}/{res}", method = RequestMethod.GET)
    @ResponseBody
    public double[] getShopInJSON(@PathVariable(value = "name") String name,
                                  @PathVariable(value = "length") String length,
                                  @PathVariable(value = "res") String res) throws IOException {
        FetchRequest request = null;

        try {
            long time = Util.getTime();
            request = RRD.getInstance().getDb().createFetchRequest(
                    ConsolFun.AVERAGE, time - Integer.parseInt(length) + 1, time, Integer.parseInt(res));
            FetchData fetchData = request.fetchData();
            System.out.println(fetchData.dump());
            double[] values = fetchData.getValues(name);
            return values;
        } catch (Exception e) {
            return new double[]{-1d};
        }

    }




}
