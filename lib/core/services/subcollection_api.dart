import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubcollectionApi {
  FirebaseFirestore database = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;
  final String subPath;

  final String? userId;
  SubcollectionApi(this.path, this.subPath, this.userId) {
    ref = database.collection(path).doc(userId).collection(subPath);
  }
  Future<QuerySnapshot> getDocuments() async {
    return ref.get();
  }

  Future<DocumentSnapshot> getDocumentById(id) {
    return ref.doc(id).get();
  }

  Stream<DocumentSnapshot> streamDocumentById(id) {
    return ref.doc(id).snapshots();
  }

  setData(data) {
    return ref.add(data);
  }
}
