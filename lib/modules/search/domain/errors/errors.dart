abstract class FailureSearch implements Exception {
  final String message;

  FailureSearch({this.message});
}

class InvalidTextError implements FailureSearch {
  final String message;
  InvalidTextError({this.message});
}

class DataSourceError implements FailureSearch {
  final String message;
  DataSourceError({this.message});
}
