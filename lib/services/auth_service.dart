import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AuthService {
  Future<void> signup(String name, String email, String password) async {
    UserCredential userCred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await FirebaseFirestore.instance.collection("users").doc(userCred.user!.uid)
        .set({"name": name, "email": email});
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}




Future<void> logoutFirebase(BuildContext context) async {
  await FirebaseAuth.instance.signOut();

  Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
}
