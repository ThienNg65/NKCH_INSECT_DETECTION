import 'package:equatable/equatable.dart';

class Process extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final bool succeeded;

  const Process({
    required this.isLoading,
    this.errorMessage,
    required this.succeeded,
  });

  @override
  List<Object?> get props => [isLoading, errorMessage, succeeded];

  Process copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? succeeded,
  }) {
    return Process(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      succeeded: succeeded ?? this.succeeded,
    );
  }
}

final class Success extends Process {
  const Success()
      : super(
          succeeded: true,
          errorMessage: null,
          isLoading: false,
        );
}

final class Initial extends Process {
  const Initial()
      : super(
          succeeded: false,
          errorMessage: null,
          isLoading: false,
        );
}

final class Failed extends Process {
  const Failed(String? errorMessage)
      : super(
          isLoading: false,
          errorMessage: errorMessage ?? 'Unknown error',
          succeeded: false,
        );
}

final class Loading extends Process {
  const Loading()
      : super(
          isLoading: true,
          errorMessage: null,
          succeeded: false,
        );
}
