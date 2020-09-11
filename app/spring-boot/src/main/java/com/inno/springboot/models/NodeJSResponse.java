/**
 * CONFIDENTIAL INFORMATION
 * <p>
 * All Rights Reserved.  Unauthorized reproduction, transmission, or
 * distribution of this software is a violation of applicable laws.
 * <p>
 * Date: Sep 09, 2020
 * Copyright 2020 innoirvinge@gmail.com
 */
package com.inno.springboot.models;

import org.springframework.http.ResponseEntity;

/**
 * @author irving09 <innoirvinge@gmail.com>
 */
public class NodeJSResponse {
  private final Host host;
  private final ResponseEntity<String> nodeJsResponse;

  public NodeJSResponse(Host host, ResponseEntity<String> nodeJsResponse) {
    this.host = host;
    this.nodeJsResponse = nodeJsResponse;
  }

  public Host getHost() {
    return host;
  }

  public ResponseEntity<String> getNodeJsResponse() {
    return nodeJsResponse;
  }
}
