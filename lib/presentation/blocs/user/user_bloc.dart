import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_architecture_template/core/error/failures.dart';
import 'package:clean_architecture_template/domain/entities/user.dart';
import 'package:clean_architecture_template/domain/usecases/get_user_by_id.dart';

part 'user_event.dart';
part 'user_state.dart';

/// BLoC for managing user state
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserByIdUseCase _getUserByIdUseCase;

  /// Creates a new [UserBloc] with the given [getUserByIdUseCase]
  UserBloc({
    required GetUserByIdUseCase getUserByIdUseCase,
  })  : _getUserByIdUseCase = getUserByIdUseCase,
        super(UserInitial()) {
    on<GetUserById>(_onGetUserById);
  }

  /// Handles the [GetUserById] event
  Future<void> _onGetUserById(
    GetUserById event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final result = await _getUserByIdUseCase(
      GetUserByIdParams(userId: event.userId),
    );

    result.fold(
      (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
      (user) => emit(UserLoaded(user: user)),
    );
  }

  /// Maps a [Failure] to a user-friendly error message
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error: ${failure.message}';
      case NetworkFailure:
        return 'Network error: ${failure.message}';
      case AuthFailure:
        return 'Authentication error: ${failure.message}';
      default:
        return 'Unexpected error: ${failure.message}';
    }
  }
} 