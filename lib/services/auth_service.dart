import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class AuthResult {
  AuthResult({required this.success, required this.message, this.userName = ''});

  final bool success;
  final String message;
  final String userName;
}

class OtpResult {
  OtpResult({required this.success, required this.message});

  final bool success;
  final String message;
}

class AuthService {
  static const _demoEmail = 'admin@mosque.app';
  static const _demoName = 'Mosque Admin';
  static final _hashedPassword = sha256.convert(utf8.encode('SecurePass123')).toString();

  String? _generatedOtp;

  Future<OtpResult> requestOtp(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (email != _demoEmail) {
      return OtpResult(success: false, message: 'Unknown email account.');
    }

    _generatedOtp = (Random().nextInt(900000) + 100000).toString();
    return OtpResult(
      success: true,
      message: 'OTP generated (demo: $_generatedOtp). Integrate with SMS/Email gateway in production.',
    );
  }

  Future<AuthResult> login({
    required String email,
    required String password,
    required String otp,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final hashedInputPassword = sha256.convert(utf8.encode(password)).toString();

    if (email != _demoEmail || hashedInputPassword != _hashedPassword) {
      return AuthResult(success: false, message: 'Invalid credentials.');
    }

    if (_generatedOtp == null) {
      return AuthResult(success: false, message: 'Please request OTP first.');
    }

    if (otp != _generatedOtp) {
      return AuthResult(success: false, message: 'Invalid OTP for 2-step verification.');
    }

    _generatedOtp = null;
    return AuthResult(success: true, message: 'Login successful with password hash + OTP 2FA.', userName: _demoName);
  }
}
