package com.eyewear;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.eyewear.configs.CustomSiteMeshFilter;

@Configuration
public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(EyewearEcmApplication.class);
	}

	@Bean
	FilterRegistrationBean<CustomSiteMeshFilter> siteMeshFilter() {
		FilterRegistrationBean<CustomSiteMeshFilter> filter = new FilterRegistrationBean<CustomSiteMeshFilter>();
		filter.setFilter(new CustomSiteMeshFilter());
		filter.addUrlPatterns("/*");
		return filter;
	}
}
