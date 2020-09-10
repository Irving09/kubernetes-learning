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

/**
 * @author irving09 <innoirvinge@gmail.com>
 */
public class Host {
  private final String hostname;
  private final String clientIp;
  private final String appVersion;

  public Host(String hostname, String clientIp, String appVersion) {
    this.hostname = hostname;
    this.clientIp = clientIp;
    this.appVersion = appVersion;
  }

  public String getHostname() {
    return hostname;
  }

  public String getClientIp() {
    return clientIp;
  }

  public String getAppVersion() {
    return appVersion;
  }
}
