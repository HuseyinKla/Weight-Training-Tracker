class UserData {
  static String? _userGender = "";
  static String? _userName = "";
  static String? _userSurname = "";
  static String? _userKilo = "";
  static String? _userTargetKilo = "";
  static String? _userGap = "0";
  static String? _userAge = "";
  static String? _userVKI = "";
  static String? _userFatRatio = "";
  static String? _userWaistRatio = "";
  static String? _userHipRatio = "";
  //static String userUid = Uuid().v4();
  static String userUid = "";
  static bool _isSignIn = false;
  static List<double?> pastKilos = List.filled(7, null);

  static updateChartValue(int index, String value) {
    double? parsedValue = double.tryParse(value);
    UserData.pastKilos[index] = parsedValue != null ? parsedValue : 0;
  }

  static String getUserUid() {
    return userUid;
  }

  static setUserUid(String value) {
    userUid = value;
  }

  static List<double?> getPastKilos() {
    return pastKilos;
  }

  static List<double?> setPastKilos() => pastKilos = List.filled(7, null);

  static bool get getisSignIn => _isSignIn;

  static String? get getUserName => _userName;

  static String? get getUserGender => _userGender;

  static String? get getUserSurname => _userSurname;

  static String? get getUserKilo => _userKilo;

  static String? get getUserTargetKilo => _userTargetKilo;

  static String? get getUserGap => _userGap;

  static String? get getUserAge => _userAge;

  static String? get getUserVKI => _userVKI;

  static String? get getUserFatRatio => _userFatRatio;

  static String? get getUserWaistRatio => _userWaistRatio;

  static String? get getUserHipRatio => _userHipRatio;

  static setUserName(String value) {
    _userName = value;
  }

  static setUserSingIn(bool value) {
    _isSignIn = value;
  }

  static setUserGender(String value) {
    _userGender = value;
  }

  static setUserHipRatio(String value) {
    _userHipRatio = value;
  }

  static setUserWaistRatio(String value) {
    _userWaistRatio = value;
  }

  static setUserFatRatio(String value) {
    _userFatRatio = value;
  }

  static setUserVKI(String value) {
    _userVKI = value;
  }

  static setUserAge(String value) {
    _userAge = value;
  }

  static setUserKilo(String value) {
    _userKilo = value;
  }

  static setUserTargetKilo(String value) {
    _userTargetKilo = value;
  }

  static setUserGap(String value) {
    _userGap = value;
  }

  static setUserSurname(String value) {
    _userSurname = value;
  }

/*UserData(
      {this.userGender,
      this.userName,
      this.userSurname,
      this.userKilo,
      this.userAge,
      this.userVKI,
      this.userFatRatio,
      this.userWaistRatio,
      this.userHipRatio});*/
}
