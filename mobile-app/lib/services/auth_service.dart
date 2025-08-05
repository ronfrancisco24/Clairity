import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    // Verifies the current phone number
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      // If verification fails show error message
      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? "Verification failed");
      },
      // send code here.
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      // if app can't auto-retrieve OTP, tell user to enter it manually.
      codeAutoRetrievalTimeout: (String verificationId) {
        print("OTP auto-retrieval timed out. Please enter it manually.");
      },
    );
  }

  // Verify OTP here and sign in with credential here.
  Future<void> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential);
  }
}
