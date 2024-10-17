import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackthon_2024/model/user.dart';
import 'package:hackthon_2024/services/auth_services.dart';
class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  String _getUid() {
    final uid = _authService.getUid();
    if (uid == null) {
      throw Exception("User doesn't exist");
    }
    return uid;
  }

  CollectionReference _getCollection() {
    return _firestore.collection('users');
  }

  Future<void> createUser(User user) async {
    await _getCollection().doc(_getUid()).set(user.toMap());
  }

  Future<User?> getUser() async {
    final res = await _getCollection().doc(_getUid()).get();
    if (res.data() != null) {
      return User.fromMap(res.data()! as Map<String, dynamic>);
    }
    return null;
  }

  Future<String?> getCurrentUserId() async {
    try {
      return _getUid();
    } catch (e) {
      print("Error getting current user ID: $e");
      return null;
    }
  }
}