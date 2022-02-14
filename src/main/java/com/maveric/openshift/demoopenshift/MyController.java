package com.maveric.openshift.demoopenshift;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;

@RestController
public class MyController {
    @GetMapping("/getenv")
    public String getEnvVariable() {
        try {
            String hostname = System.getenv("HOSTNAME");

            String hostname1 = InetAddress.getLocalHost().getHostName();

            return "Hello SystemHost :" + hostname + "InetAddress :" + hostname1;
        } catch (UnknownHostException e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }
}
