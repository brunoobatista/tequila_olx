class ErrorMessage {
  String message;
  bool error;
  ErrorMessage({
    this.message = 'Sucesso na execução',
    this.error = false,
  });

  String get getMessage => this.message;
  set setMessage(value) => this.message = value;
  bool get isError => this.error;
  set isError(value) => this.error = value;

  @override
  String toString() => 'ErrorMessage(message: $message, error: $error)';
}
