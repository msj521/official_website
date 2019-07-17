package com;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
//开启定时任务
@EnableScheduling
//开启异步调用方法  注意：需要在启动类加入@EnableAsync使异步调用@Async注解生效。
@EnableAsync
//扫描 所有需要的包, 包含一些自用的工具类包 所在的路径
@ComponentScan(basePackages = "com.example")
//扫描 mybatis mapper 包路径
@MapperScan(basePackages = "com.example.mapper")
public class App  {
    public static void main(String[] args) {
        SpringApplication.run(App.class,args);
    }
}
