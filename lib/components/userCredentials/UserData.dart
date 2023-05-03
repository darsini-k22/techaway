
class UserData {
  late final String _userId;
  late final String _userEmail;
  late final String _userName;


  UserData({
    required String userId,
    required String userEmail,
    required String userName,

  }) : _userId = userId,
        _userEmail = userEmail,
        _userName = userName;


  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get userEmail => _userEmail;

  set userEmail(String value) {
    _userEmail = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }
}


