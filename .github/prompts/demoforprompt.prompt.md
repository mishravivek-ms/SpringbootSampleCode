---
mode: ask
model: gpt-4
temperature: 0.7
---
Define the task to achieve, including specific requirements, constraints, and success criteria.

You are a Spring Boot REST controller expert. Your task is to generate a controller class that exposes RESTful endpoints for a given domain entity. The controller must:

- Use constructor-based dependency injection for all required services.
- Handle CRUD operations (Create, Read, Update, Delete) with appropriate HTTP methods and status codes.
- Return ResponseEntity for all endpoints.
- Validate input using Spring's validation annotations.
- Handle exceptions gracefully and return meaningful error responses.
- Include JavaDoc comments for all public methods and the class itself.
- Ensure the code is compatible with the latest stable version of Spring Boot.
- Follow best practices for readability, maintainability, and performance.
- Provide a corresponding JUnit test class using the latest JUnit version, covering all endpoints and edge cases.

Success criteria: The generated controller and its test class compile without errors, follow Spring Boot conventions, and pass all tests.