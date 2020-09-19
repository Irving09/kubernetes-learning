package com.inno.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

@SpringBootApplication
public class Application extends WebMvcConfigurationSupport {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Override
	protected void configurePathMatch(PathMatchConfigurer configurer) {
		configurer.setUseTrailingSlashMatch(true);
	}

}
