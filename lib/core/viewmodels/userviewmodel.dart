import 'package:tracker/core/models/user.dart';
import 'package:tracker/core/services/api.dart';

class UserViewModel {
  Api api = Api('users');
  List<UserModel> users = [];
  Future<List<UserModel>> getUsers() async {
    var result = await api.getDocuments();
    users = result.docs
        .map((doc) =>
            UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return users;
  }

  Future<UserModel> getUserById(id) async {
    var doc = await api.getDocumentById(id);
    return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  Stream streamUserById(id) {
    var doc = api.streamDocumentById(id);
    return doc;
  }

  addUser(UserModel data, id) async {
    var result = await api.setData(data.toJson(), id);
    return result;
  }

  updateLocation(Map<String, double> data, id) {
    return api.updateData(data, id);
  }
}
