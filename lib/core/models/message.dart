class Message {
  final String? id;
  final String? sentId;
  Message({this.id, this.sentId});
  Message.fromMap(Map<String, dynamic> snapshot, this.id)
      : sentId = snapshot['sentId'];
  toJson() {
    return {"sentId": sentId};
  }
}
