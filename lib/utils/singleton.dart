class FlashSingleton {
  Map<String, dynamic>? errorMapValues;
  String? bearerToken;
  String? phone;
  String? otp;
  int? id;
  String? vehicleName;
  String? chasisNo;
  String? dealerId;

  static final FlashSingleton _singleton = FlashSingleton._internal();

  FlashSingleton._internal();

  static FlashSingleton get instance => _singleton;
}
