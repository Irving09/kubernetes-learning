/**
 * CONFIDENTIAL INFORMATION
 * <p>
 * All Rights Reserved.  Unauthorized reproduction, transmission, or
 * distribution of this software is a violation of applicable laws.
 * <p>
 * Date: Sep 13, 2020
 * Copyright 2020 innoirvinge@gmail.com
 */
package com.inno.springboot.processors;

import org.springframework.stereotype.Component;

import java.math.BigInteger;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @author irving09 <innoirvinge@gmail.com>
 */
@Component
public class DummyComputation {
  private BigInteger fib(BigInteger n) {
    if (n.compareTo(BigInteger.ONE) == -1 || n.compareTo(BigInteger.ONE) == 0 ) return n;
    else
      return fib(n.subtract(BigInteger.ONE)).add(fib(n.subtract(BigInteger.ONE).subtract(BigInteger.ONE)));
  }

  public void calculate() {
    ExecutorService executorService = Executors.newFixedThreadPool(10);
    for (int j = 0; j < 10; j++) {
      final int ID = j;
      executorService.submit(new Runnable() {

        public void run() {
          for (int i=0; i < 15; i++) {
            fib(new BigInteger(String.valueOf(i)));
          }
        }
      });
    }
  }
}
