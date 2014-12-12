/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ambimmort.app.framework.controller.rest;

import com.ambimmort.app.framework.core.RRD;
import net.sf.json.JSONArray;
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
    public String getShopInJSON(@PathVariable(value = "name") String name,
                                @PathVariable(value = "length") String length,
                                @PathVariable(value = "res") String res) throws IOException {
        FetchRequest request = null;

        try {
            long time = Util.getTime();
            request = RRD.getInstance().getDb().createFetchRequest(
                    ConsolFun.AVERAGE, time - Integer.parseInt(length) + Integer.parseInt(res), time - Integer.parseInt(res), Integer.parseInt(res));
            FetchData fetchData = request.fetchData();

            System.out.println(fetchData.dump());

            {
                long[] times = fetchData.getTimestamps();
                double[] values = fetchData.getValues(name);
                JSONArray data = new JSONArray();
                JSONArray point = null;
                for (int i = 0; i < times.length; i++) {
                    System.out.println("times[i]:" + times[i] + "\tvalues[i]:" + values[i]);
                    point = new JSONArray();
                    point.add(times[i]*1000);
                    if (((Double) values[i]).isNaN()) {
                        point.add(0);
                    } else {
                        point.add(values[i]);
                    }
                    data.add(point);
                }
                return data.toString();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "[]";
        }

    }


}
