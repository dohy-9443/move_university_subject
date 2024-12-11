abstract class IFailure {
  final String message;

  const IFailure(this.message);
}

class ServerFailure extends IFailure {
  const ServerFailure(super.message);
}