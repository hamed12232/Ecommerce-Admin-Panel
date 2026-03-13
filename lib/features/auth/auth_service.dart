import 'package:firebase_auth/firebase_auth.dart';

/// A singleton service that wraps [FirebaseAuth] and exposes
/// reactive auth state for use with [StreamBuilder] or listeners.
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /// Reactive stream of auth state changes.
  /// Emits the current [User] when logged in, or `null` when logged out.
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  /// The currently signed-in user, or `null`.
  User? get currentUser => _auth.currentUser;
  /// Whether a user is currently authenticated.
  bool get isAuthenticated => _auth.currentUser != null;
  /// Signs the current user out.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
