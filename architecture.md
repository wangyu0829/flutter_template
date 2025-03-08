# Clean Architecture Template Documentation

## Architecture Overview

This template follows the Clean Architecture principles with a clear separation of concerns, making the codebase modular, testable, and maintainable.

## Layer Structure

### 1. Data Layer
- **Location**: `lib/data/`
- **Responsibility**: Handling data sources, API calls, data persistence
- **Components**:
  - **Models**: Data models for serialization/deserialization
  - **Sources**: Data source implementations (API, local storage)
  - **Repositories**: Implementation of domain repository interfaces

### 2. Domain Layer
- **Location**: `lib/domain/`
- **Responsibility**: Defining business entities and use cases
- **Components**:
  - **Entities**: Business entity definitions
  - **Repositories**: Repository interface definitions
  - **Usecases**: Business logic implementations

### 3. Presentation Layer
- **Location**: `lib/presentation/`
- **Responsibility**: Handling UI and user interactions
- **Components**:
  - **Screens**: Screen UI implementations
  - **Blocs**: State management
  - **Widgets**: Reusable components

## Key Concepts

### 1. Dependency Injection
- Uses `service_locator.dart` for service registration
- Follows the Inversion of Control principle
- Register repositories, use cases, and services

### 2. Code Standards
- Model classes must implement fromJson/toJson methods
- Entity classes use Equatable for equality comparison
- Repository implementations must follow interface contracts
- UseCase classes have a single `call` method that receives parameters
- Blocs define clear Events and States
- UseCase classes must end with "UseCase"
- Use snake_case for file names
- Use PascalCase for class names

### 3. Error Handling
- All data and domain layer methods return `Either<Failure, Success>` type
- Service layer handles basic API call errors
- Repository layer handles data transformation errors
- Use try-catch blocks to wrap all code that might throw exceptions

## Implementation Flow

### 1. Implementation Order
1. Start with the domain layer (Entity -> Repository Interface)
2. Then implement the data layer (Model -> Service -> Repository Implementation)
3. Finally, implement the use case layer (UseCase)

### 2. Detailed Steps
```
1. Create Entity
2. Define Repository interface
3. Create Model (extends Entity)
4. Define Service interface
5. Implement Service
6. Implement Repository
7. Implement UseCase
8. Register in service_locator
```

### 3. Directory Structure
```
lib/
├── domain/         # Implement first
│   └── feature/
│       ├── entities/
│       ├── repositories/ (interfaces)
│       └── usecases/
└── data/           # Implement second
    └── feature/
        ├── models/
        ├── sources/
        └── repositories/ (implementations)
```

## Best Practices

### 1. Code Reuse
- Reference existing similar functionality implementations
- Maintain consistent error handling approaches
- Maintain consistent dependency injection patterns
- Maintain consistent code organization

### 2. Data Flow
1. UI triggers Bloc Event
2. Bloc calls UseCase
3. UseCase calls Repository
4. Repository coordinates DataSource
5. Data is transformed through Model to Entity
6. Entity is returned to UI for display

### 3. Testing Strategy
- Unit tests for UseCases
- Integration tests for Repositories
- Widget tests for UI components
- Mock dependencies using Mockito 