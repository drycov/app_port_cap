// ignore_for_file: avoid_print

import 'package:app_port_cap/app/models/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FRBQuery {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  Future<User> get getUser async => _auth.currentUser!;
  Future<dynamic> getUserCN(String? cn) {
    return _db.collection("cn").where('alt_name', isEqualTo: cn).get().then(
          (res) => CNModel.fromMap(res.docs[0].data()),
          onError: (e) => print("Error completing: $e"),
        );
  }

  Future<dynamic> getUserRegion(String? region) {
    return _db
        .collection("region")
        .where('alt_name', isEqualTo: region)
        .get()
        .then(
          (res) => RegionModel.fromMap(res.docs[0].data()),
          onError: (e) => print("Error completing: $e"),
        );
  }

  Future<dynamic> getUserCP(String? post) {
    return _db
        .collection("company_posts")
        .where('alt_name', isEqualTo: post)
        .get()
        .then(
          (res) => CompanyPostsModel.fromMap(res.docs[0].data()),
          onError: (e) => print("Error completing: $e"),
        );
  }

  Future<dynamic> getUserCnD(String? cnd) {
    return _db
        .collection("cn_deportaments")
        .where('alt_name', isEqualTo: cnd)
        .get()
        .then(
          (res) => CompanyDeportamentsModel.fromMap(res.docs[0].data()),
          onError: (e) => print("Error completing: $e"),
        );
  }
}
