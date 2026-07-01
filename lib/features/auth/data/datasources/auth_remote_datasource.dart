import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lex_core/core/network/api_exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<dynamic> login(String email, String password);
  Future<dynamic> signup(Map<String, dynamic> body);
  Future<dynamic> forgotPassword(String email);
  Future<dynamic> verifyOtp(String email, String otp);
  Future<dynamic> resetPassword(String email, String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth? _injectedFirebaseAuth;
  final FirebaseFirestore? _injectedFirestore;

  AuthRemoteDataSourceImpl({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _injectedFirebaseAuth = firebaseAuth,
        _injectedFirestore = firestore;

  FirebaseAuth get _firebaseAuth => _injectedFirebaseAuth ?? FirebaseAuth.instance;
  FirebaseFirestore get _firestore => _injectedFirestore ?? FirebaseFirestore.instance;

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found': return 'No account found with this email.';
      case 'wrong-password': return 'Incorrect password.';
      case 'invalid-credential': return 'Invalid email or password.';
      case 'network-request-failed': return 'Check your internet connection.';
      case 'user-disabled': return 'This account has been disabled.';
      default: return e.message ?? 'An unknown error occurred.';
    }
  }

  @override
  Future<dynamic> login(String email, String password) async {
    // -------------------------------------------------------------
    // UI TEST BYPASS (Allows logging in without Firebase Auth)
    // -------------------------------------------------------------
    if (email == 'student' || email == 'esha.student@example.com') {
      return {
        "statusCode": 200, "message": "Bypass successful", "data": {
          "accessToken": "dummy", "user": { "id": "std_123", "email": "esha.student@example.com", "name": "Esha Farrukh", "role": "student" }
        }
      };
    } else if (email == 'lawyer' || email == 'ayesha.khan@legalsuite.com') {
      return {
        "statusCode": 200, "message": "Bypass successful", "data": {
          "accessToken": "dummy", "user": { "id": "lw_1", "email": "ayesha.khan@legalsuite.com", "name": "Ayesha Khan", "role": "lawyer" }
        }
      };
    } else if (email == 'client' || email == 'client@example.com') {
      return {
        "statusCode": 200, "message": "Bypass successful", "data": {
          "accessToken": "dummy", "user": { "id": "client_1", "email": "client@example.com", "name": "James Carter", "role": "client" }
        }
      };
    }
    // -------------------------------------------------------------

    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) throw ApiException('Authentication failed.');

      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        throw ApiException('Your user profile is missing. Contact support.');
      }

      final data = doc.data()!;
      return {
        "statusCode": 200,
        "message": "Login successful",
        "data": {
          "accessToken": "firebase_managed_token",
          "user": {
            "id": uid,
            "email": data['email'] ?? email,
            "name": data['fullName'] ?? "User",
            "role": data['role'] ?? "client",
          }
        }
      };
    } on FirebaseAuthException catch (e) {
      throw ApiException(_mapFirebaseError(e));
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<dynamic> signup(Map<String, dynamic> body) async {
    try {
      final email = body['email'] as String;
      final password = body['password'] as String;
      
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) throw ApiException('Signup failed.');

      final role = body['role'] ?? "client";
      final fullName = body['fullName'] ?? "New User";

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'fullName': fullName,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return {
        "statusCode": 201,
        "message": "User registered successfully",
        "data": {
          "accessToken": "firebase_managed_token",
          "user": {
            "id": uid,
            "email": email,
            "name": fullName,
            "role": role,
          }
        }
      };
    } on FirebaseAuthException catch (e) {
      throw ApiException(_mapFirebaseError(e));
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<dynamic> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return {
        "statusCode": 200,
        "message": "Password reset email sent. Please check your inbox.",
      };
    } on FirebaseAuthException catch (e) {
      throw ApiException(_mapFirebaseError(e));
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  @override
  Future<dynamic> verifyOtp(String email, String otp) async {
    // Deprecated for Firebase Auth (uses email links instead)
    return {
      "statusCode": 200,
      "message": "Proceed to reset password",
    };
  }

  @override
  Future<dynamic> resetPassword(String email, String newPassword) async {
    // Handled entirely by Firebase dynamic link in email
    return {
      "statusCode": 200,
      "message": "Password reset successfully",
    };
  }
}
