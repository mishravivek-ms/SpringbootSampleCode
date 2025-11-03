---
applyTo: '**.sql'
---
Provide project context and coding guidelines that AI should follow when generating code, answering questions, or reviewing changes.

1. **Project Context**:
   - This project is a Spring Boot application that interacts with a SQL database.
   - The application uses JPA (Java Persistence API) for database operations.
   - SQL scripts are used for database initialization and migration.

2. **Coding Guidelines**:
   - Follow the established naming conventions for SQL files (e.g., `V1__initial.sql`, `V2__add_user_table.sql`).
   - Ensure that all SQL scripts are idempotent, meaning they can be run multiple times without causing errors.
   - Include comments in SQL scripts to explain the purpose of each statement.
   - Use transactions in SQL scripts to ensure data integrity.
   - Test all SQL scripts in a local development environment before deploying to production.