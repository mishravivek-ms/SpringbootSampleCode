package com.example.demo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    /**
     * Handles GET requests to the root endpoint.
     * @return Greeting message for Azure and Spring Boot API.
     */
    /**
     * Handles HTTP requests to the "/api" endpoint.
     * Logs a message to the console and returns a greeting string.
     *
     * @return a greeting message for Azure and Spring Boot (Production)
     */
    @RequestMapping("/api")
    String getHelloMessage() {
        System.out.println("This is logs");
        return "api: Hello Azure and Spring Boot! (Production) This is Demo";
    }

    
    @RequestMapping("/api/daysBetween")
    String getDaysBetween(String startDate, String endDate) {
        // Logic to calculate days between startDate and endDate
        // For simplicity, let's assume the dates are in "yyyy-MM-dd" format
        try {
            java.time.LocalDate start = java.time.LocalDate.parse(startDate);
            java.time.LocalDate end = java.time.LocalDate.parse(endDate);
            long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(start, end);
            return "Days between: " + daysBetween;
        } catch (Exception e) {
            return "Invalid date format. Please use 'yyyy-MM-dd'.";
        }
    }

    //Create a method that add 2 dates and return date
    

    

}
