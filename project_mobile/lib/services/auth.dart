import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signiInWithEmailAndPassword({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  } //si occupa del login

  Future<void> createUserWithEmailAndPassword({required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  } //si occupa della registrazione, 5.10 del video 37 ti spiega come vuoi fare anche se hai più dati per l'utente


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}