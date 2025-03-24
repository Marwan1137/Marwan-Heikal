abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class StorageFailure extends Failure {
  const StorageFailure(String message) : super(message);
}

class GeneralFailure extends Failure {
  const GeneralFailure(String message) : super(message);
}
