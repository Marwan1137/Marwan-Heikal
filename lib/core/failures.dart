abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}
