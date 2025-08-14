---
mode: ask
---
Define the task to achieve, including specific requirements, constraints, and success criteria.

## Demo Feature Suggestion

**Feature:** Interactive Algorithm Issue Tracker

- Implement a REST API for users to submit, update, and retrieve algorithm issues.
- Each issue should include: title, description, difficulty, and status (open/closed).
- Add endpoints for:
	- Creating a new issue (`POST /api/`)
	- Listing all issues (`GET /api/`)
	- Updating issue status (`PUT /api//{id}/status`)
	- Searching issues by keyword or difficulty (`GET /api/?difficulty=easy&search=sort`)
- Use in-memory storage for simplicity, or connect to a database for persistence.
- Return clear HTTP status codes and use ResponseEntity for all responses.
- Add basic validation and error handling.
- Optionally, integrate Swagger/OpenAPI for interactive API documentation.

This feature demonstrates RESTful design, CRUD operations, validation, and documentation—all using Spring Boot best practices.