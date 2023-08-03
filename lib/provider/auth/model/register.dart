class ResponseDataRegister {
  String? idToken;
  String? localId;
  DataFailed? error;

  ResponseDataRegister({
    this.idToken,
    this.localId,
    this.error,
  });

  ResponseDataRegister.fromJson(Map<String, dynamic> json) {
    idToken = json['idToken'];
    localId = json['localId'];
    error = json['error'] != null ? DataFailed.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idToken'] = idToken;
    data['localId'] = localId;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    return data;
  }
}

class DataFailed {
  int? code;
  String? message;

  DataFailed({
    this.code,
    this.message,
  });

  DataFailed.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
