/// Model for cloud function message
class ResponseMessage {
  bool result;
  String message;
  ResponseMessage({
    required this.result,
    this.message = "",
  });

  factory ResponseMessage.fromJson(Map<String, dynamic> json) {
    return ResponseMessage(
      result: json['result'],
      message: json['message'],
    );
  }
}
