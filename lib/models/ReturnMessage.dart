class ReturnMessage {
  String message = 'Sucesso na execução';
  bool error = false;
  ReturnMessage();

  String get getMessage => this.message;
  set setMessage(value) => this.message = value;
  bool get isError => this.error;
  set isError(value) => this.error = value;
}
