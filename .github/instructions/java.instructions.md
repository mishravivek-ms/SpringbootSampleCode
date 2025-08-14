applyTo: '**/java/**'


## Industry Standard Java Guidelines for Spring Boot Projects

1. **Project Structure**
	- Use the standard Maven/Gradle directory layout (`src/main/java`, `src/main/resources`, `src/test/java`).
	- Organize code by feature or layer (controller, service, repository, entity).

2. **Coding Practices**
	- Use meaningful class, method, and variable names.
	- Prefer constructor injection for dependencies.
	- Avoid field injection and hard-coded values.
	- Use Lombok for boilerplate code reduction (e.g., getters/setters).
	- Annotate public APIs with JavaDoc.

3. **Exception Handling & Logging**
	- Use custom exception classes for domain-specific errors.
	- Handle exceptions globally with `@ControllerAdvice`.
	- Use SLF4J for logging.

4. **REST API Design**
	- Use `@RestController` and `@RequestMapping` for endpoints.
	- Return `ResponseEntity` with proper HTTP status codes.
	- Validate input using `@Valid` and custom validators.

5. **Testing**
	- Write unit and integration tests using JUnit 5 and Mockito.
	- Use `@SpringBootTest` for integration tests.
	- Ensure high code coverage and meaningful assertions.

6. **Security**
	- Use Spring Security for authentication and authorization.
	- Store secrets in environment variables or secure vaults.

7. **Documentation**
	- Document APIs using Swagger/OpenAPI.

8. **Performance & Maintainability**
	- Profile and optimize code for performance.
	- Refactor regularly to improve readability and maintainability.

9. **Dependency Management**
	- Use the latest stable versions of dependencies.
	- Avoid deprecated APIs and libraries.

10. **Configuration**
	 - Externalize configuration using `application.properties` or `application.yml`.
	 - Use profiles for environment-specific settings.
