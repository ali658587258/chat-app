class MassageModel {
  String? senderId;
  String? reciverId;
  String? dateTime;
  String? text;
  MassageModel({this.senderId, this.reciverId, this.dateTime, this.text});
  MassageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId '];
    reciverId = json['reciverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reciverId': reciverId,
      'dateTime': dateTime,
      'text': text
    };
  }
}