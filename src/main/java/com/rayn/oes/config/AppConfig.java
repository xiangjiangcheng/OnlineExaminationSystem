package com.rayn.oes.config;

import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.concurrent.ConcurrentMapCacheManager;
import org.springframework.context.annotation.*;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.scheduling.annotation.EnableScheduling;


/**
 * AppConfig
 * Created by rayn on 05/08 2015.
 */
@Configuration
@ComponentScan(basePackages = {"com.rayn.oes"})
@PropertySource(value = {"classpath:application.properties"})
@EnableScheduling
@EnableAspectJAutoProxy
@EnableCaching
public class AppConfig {
    @Bean
    public static PropertySourcesPlaceholderConfigurer placeholderConfigurer() {
        return new PropertySourcesPlaceholderConfigurer();
    }
    @Bean
    public CacheManager cacheManager() {
        return new ConcurrentMapCacheManager();
    }
}
