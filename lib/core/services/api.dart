import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  FirebaseFirestore database = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;
  Api(this.path) {
    ref = database.collection(path);
  }
  Future<QuerySnapshot> getDocuments() async {
    return ref.get();
  }

  Future<DocumentSnapshot> getDocumentById(id) {
    return ref.doc(id).get();
  }

  Stream streamDocumentById(id) {
    return ref.doc(id).snapshots();
  }

  setData(data, id) {
    return ref.doc(id).set(data);
  }

  updateData(data, id) {
    return ref.doc(id).update(data);
  }
}
