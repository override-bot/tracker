import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracker/core/models/message.dart';
import 'package:tracker/core/services/subcollection_api.dart';

User user = FirebaseAuth.instance.currentUser!;

class MessageViewModel {
//  SubcollectionApi subcollectionApi = SubcollectionApi("Locations", "received", u);
  List<Message> userIds = [];

  Future<List<Message>> getLocations() async {
    var result = await SubcollectionApi("Locations", "received", user.uid)
        .getDocuments();
    userIds = result.docs
        .map((doc) =>
            Message.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return userIds;
  }

  sendMessage(Message data, userid) async {
    var result = await SubcollectionApi("Locations", "received", userid)
        .setData(data.toJson());
    return result;
  }
}
