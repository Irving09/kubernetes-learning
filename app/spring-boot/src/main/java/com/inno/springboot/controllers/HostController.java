/**
 * CONFIDENTIAL INFORMATION
 * <p>
 * All Rights Reserved.  Unauthorized reproduction, transmission, or
 * distribution of this software is a violation of applicable laws.
 * <p>
 * Date: Sep 09, 2020
 * Copyright 2020 innoirvinge@gmail.com
 */
package com.inno.springboot.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import com.inno.springboot.models.Host;
import com.inno.springboot.models.NodeJSResponse;
import com.inno.springboot.processors.DummyComputation;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;

/**
 * @author irving09 <innoirvinge@gmail.com>
 */

@RestController
public class HostController {

  private final Logger logger = LoggerFactory.getLogger(HostController.class);

  private final String appVersion = "1.0";

  private int dummyCounter = 1;

  private final DummyComputation computer;

  public HostController(DummyComputation dummyComputation) {
    this.computer = dummyComputation;
  }

  @GetMapping("/hello")
  public ResponseEntity<Host> helloClient(HttpServletRequest request) throws UnknownHostException {
    String hostname = InetAddress.getLocalHost().getHostName();
    String clientIp = request.getRemoteAddr();

    logger.info("/hello received request for " + hostname + " from " + clientIp);

    Random r = new Random();
    computer.calculatePrimes(300L, 100000000L);
    return ResponseEntity.ok(new Host(hostname, clientIp, appVersion, "Spring Boot"));
  }

  @GetMapping("/other/hi")
  public ResponseEntity<Object> helloNodeClient(HttpServletRequest request) throws UnknownHostException {
    dummyCounter = (dummyCounter + 1) % 4;

    String hostname = InetAddress.getLocalHost().getHostName();
    String clientIp = request.getRemoteAddr();

    logger.info("/other/hi received request for " + hostname + " from " + clientIp);

    RestTemplate restTemplate = new RestTemplate();

    if (dummyCounter == 0) {
      return ResponseEntity
          .status(503)
          .body(new Host(
              hostname,
              clientIp,
              appVersion,
              "Springboot - 503 gateway error"
          ));
    } else {
      ResponseEntity<String> response = restTemplate.getForEntity("http://hello-nodejs/hello", String.class);
      Host host = new Host(hostname, clientIp, appVersion, "Spring Boot");
      computer.calculatePrimes(300L, 100000000L);
      NodeJSResponse nodejsResponse = new NodeJSResponse(host, response);
      return ResponseEntity.ok(nodejsResponse);
    }
  }

}
