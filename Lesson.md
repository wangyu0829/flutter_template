# Lessons Learned

## Clean Architecture Principles

1. **Separation of Concerns**
   - Keep data, domain, and presentation layers separate
   - Each layer has its own responsibilities and should not depend on implementation details of other layers

2. **Dependency Rule**
   - Dependencies should point inward
   - Domain layer should not depend on data or presentation layers
   - Data and presentation layers depend on domain layer

3. **Entities**
   - Represent business objects
   - Should be independent of any framework or implementation details
   - Use Equatable for equality comparison

4. **Use Cases**
   - Represent business logic
   - Should have a single responsibility
   - Should return Either<Failure, Success> for error handling

5. **Repositories**
   - Define interfaces in domain layer
   - Implement in data layer
   - Coordinate data sources and handle data transformation

## Best Practices

1. **Error Handling**
   - Use Either<Failure, Success> for functional error handling
   - Define specific failure types for different error scenarios
   - Handle exceptions in repository implementations

2. **Dependency Injection**
   - Use GetIt for service location
   - Register dependencies in a centralized place
   - Use lazy singletons for services and repositories

3. **State Management**
   - Use BLoC pattern for state management
   - Define clear events and states
   - Keep UI components stateless when possible

4. **Code Organization**
   - Use feature-based organization within each layer
   - Follow consistent naming conventions
   - Document public APIs with dartdoc comments

## Common Pitfalls to Avoid

1. **Leaking Implementation Details**
   - Don't expose data layer models to presentation layer
   - Use entities for business logic and UI

2. **Tight Coupling**
   - Avoid direct dependencies between components
   - Use dependency injection to provide dependencies

3. **Inconsistent Error Handling**
   - Use the same error handling approach throughout the application
   - Don't mix different error handling strategies

4. **Overly Complex Architecture**
   - Don't add unnecessary abstractions
   - Keep it simple for small features 