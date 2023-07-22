class AlertModel {
  final String? message;
  final String? error;
  final String? id;
  final String? token;

  AlertModel({this.token, this.id, this.error, this.message});

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('error')) {
      return AlertModel(
        error: json['error'],
      );
    } else if (json.containsKey('userId') && json.containsKey('token')) {
      return AlertModel(
        id: json['userId'],
        token: json['token'],
      );
    } else {
      return AlertModel(
        message: json['message'],
      );
    }
  }
}
