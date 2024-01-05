class AppException implements Exception {
  String message;

  AppException({required this.message});
}

class NoInternetException extends AppException {
  NoInternetException({message}) : super(message: message);
}

class ConnectionTimedOutException extends AppException {
  ConnectionTimedOutException({message}) : super(message: message);
}

class BadRequestException extends AppException {
  BadRequestException({message}) : super(message: message);
}
