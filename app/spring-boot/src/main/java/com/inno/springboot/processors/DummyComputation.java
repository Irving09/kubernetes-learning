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

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * @author irving09 <innoirvinge@gmail.com>
 */
@Component
public class DummyComputation {

  public List<Long> calculatePrimes(Long iterations, Long multiplier) {
    List<Long> primes = new ArrayList<>();
    for (int i = 0; i < iterations; i++) {
      Long candidate = (Long) (i * (multiplier * new Random().nextLong()));
      boolean isPrime = true;
      for (int c = 2; c <= Math.sqrt(candidate); ++c) {
        if (candidate % c == 0) {
          // not prime
          isPrime = false;
          break;
        }
      }
      if (isPrime) {
        primes.add(candidate);
      }
    }
    return primes;
  }

}
