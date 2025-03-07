package com.example.demo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @RequestMapping("/")
    String hello() {
        System.out.println("This is logs");
        return "Hello Azure and Spring Boot! (Production) This is Demo";
    }

}
