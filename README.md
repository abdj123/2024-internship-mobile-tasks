## Flutter App Documentation

### Project Overview
This project is part of an internship at A2SV, focusing on learning Flutter development using Test Driven Development (TDD), Clean Architecture, and BLoC (Business Logic Component) pattern. The application aims to demonstrate these principles through practical implementation.

### Architecture

#### Clean Architecture
Clean Architecture divides the project into multiple layers, each with a specific responsibility. This separation of concerns improves code maintainability, scalability, and testability.

1. **Presentation Layer**:
   - **Widgets**: UI components of the application.
   - **BLoC (Business Logic Component)**: Manages the state of the application and interacts with the use cases. It receives events from the UI, processes them, and emits new states.

2. **Domain Layer**:
   - **Entities**: Core classes of the application representing business objects.
   - **Use Cases**: Business logic implementation, coordinating the flow of data from the Repository to the BLoC.

3. **Data Layer**:
   - **Repositories**: Abstract classes defining the operations for data handling.
   - **Data Sources**: Concrete implementations for data handling, e.g., local database or remote API.

### Data Flow

1. **User Interaction**: User interacts with the UI (Presentation Layer).
2. **Event Triggering**: UI triggers an event which is sent to the BLoC.
3. **BLoC Processing**: BLoC receives the event and interacts with the Use Case.
4. **Use Case Execution**: The Use Case fetches/updates data from/to the Repository.
5. **Data Source Interaction**: Repository interacts with Data Sources to perform actual data operations.
6. **State Update**: Once data is fetched or updated, the Use Case returns the result to the BLoC.
7. **State Emission**: BLoC emits a new state based on the result, which the UI listens to and updates accordingly.

### Folder Structure

```
lib/
├── data/
│   ├── models/
│   ├── repositories/
│   ├── data_sources/
│
├── domain/
│   ├── entities/
│   ├── use_cases/
│
├── presentation/
│   ├── blocs/
│   ├── pages/
│   ├── widgets/
│
├── main.dart
```

- **data/models**: Contains data models.
- **data/repositories**: Contains repository implementations.
- **data/data_sources**: Contains data sources like API or local storage.
- **domain/entities**: Contains entity classes.
- **domain/use_cases**: Contains use case implementations.
- **presentation/blocs**: Contains BLoC classes.
- **presentation/pages**: Contains UI pages.
- **presentation/widgets**: Contains reusable UI widgets.
- **main.dart**: Entry point of the application.

### Test Driven Development (TDD)

Following TDD principles, the project is developed in a cycle of writing tests, implementing functionality, and refactoring code. Each layer (presentation, domain, data) has its own set of tests.

- **Unit Tests**: For testing individual components like use cases, repositories, and BLoC.
- **Widget Tests**: For testing UI components.
- **Integration Tests**: For testing the complete flow from UI to data sources.

### Dependencies

- **flutter_bloc**: For state management using BLoC pattern.
- **provider**: For dependency injection.
- **get_it**: For service locator pattern.
- **mockito**: For mocking dependencies in tests.
- **flutter_test**: For writing tests.

### Conclusion

This documentation provides a high-level overview of the architecture, data flow, and development practices used in this Flutter application. Following Clean Architecture and TDD ensures the project is robust, maintainable, and scalable. The use of BLoC for state management aligns with best practices in Flutter development, providing a reactive and testable approach to building applications.
