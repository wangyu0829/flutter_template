# Flutter Clean Architecture Template

A scalable and maintainable Flutter application template based on Clean Architecture principles.

## Architecture Overview

This template follows the Clean Architecture pattern with a clear separation of concerns:

### 1. Data Layer
- **Models**: Data models for serialization/deserialization
- **Sources**: Data source implementations (API, local storage)
- **Repositories**: Implementation of domain repositories

### 2. Domain Layer
- **Entities**: Business entities
- **Repositories**: Repository interfaces
- **Usecases**: Business logic implementations

### 3. Presentation Layer
- **Screens**: UI screens
- **Widgets**: Reusable UI components
- **Blocs**: State management using BLoC pattern

## Project Structure

```
lib/
├── core/                   # Core functionality
│   ├── di/                 # Dependency injection
│   ├── error/              # Error handling
│   ├── network/            # Network utilities
│   └── utils/              # Utility functions
├── data/                   # Data layer
│   ├── models/             # Data models
│   ├── repositories/       # Repository implementations
│   └── sources/            # Data sources
├── domain/                 # Domain layer
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Business logic
└── presentation/           # Presentation layer
    ├── blocs/              # BLoC state management
    ├── screens/            # Application screens
    └── widgets/            # Reusable UI components
```

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **equatable**: Value equality
- **dartz**: Functional programming
- **dio**: HTTP client
- **shared_preferences**: Local storage

## Code Standards

- Models must implement fromJson/toJson methods
- Entities should use Equatable for equality comparison
- Repository implementations must follow interface contracts
- Usecases should have a single call method
- BLoCs need clear Event and State definitions

## Error Handling

This template uses Either type from dartz package to handle errors in a functional way:
- Left side represents errors
- Right side contains success values

## Testing

The project includes examples of:
- Unit tests for Usecases
- Widget tests for presentation layer
- Integration tests for end-to-end flows 