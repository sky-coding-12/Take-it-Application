class RemainderModel {
  int? reminderId;
  int? userId;
  int? vendorId;
  String? sendTime;
  String? message;

  RemainderModel({
    this.reminderId,
    this.userId,
    this.vendorId,
    this.sendTime,
    this.message,
  });

  RemainderModel.fromJson(Map<String, dynamic> json) {
    reminderId = json['reminderId'];
    userId = json['userId'];
    vendorId = json['vendorId'];
    sendTime = json['sendTime'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reminderId'] = this.reminderId;
    data['userId'] = this.userId;
    data['vendorId'] = this.vendorId;
    data['sendTime'] = this.sendTime;
    data['message'] = this.message;
    return data;
  }
}
