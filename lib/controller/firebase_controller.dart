import 'package:firebase_database/firebase_database.dart';

class FirebaseController {
  final db = FirebaseDatabase.instance;

  // Future<void> postdata() async {
  //   try {
  //     await db.ref("user/123").set({"name": "ankit"});
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
