import 'package:equatable/equatable.dart';

/// A class representing a failure, typically used for error handling.
class Failure extends Equatable {
  final dynamic code;
  final String message;

  /// Constructor for the Failure class.
  const Failure(this.code, this.message);

  /// Override the Equatable props to enable equality comparison.
  @override
  List<Object?> get props => [code, message];
}