class FcmTokenService {
  String? _fcmToken;

  void setFcmToken(String token) {
    _fcmToken = token;
  }

  String? get fcmToken => _fcmToken;
}
