import 'dart:convert';

OtpVerify otpVerifyFromJson(String str) => OtpVerify.fromJson(json.decode(str));

String otpVerifyToJson(OtpVerify data) => json.encode(data.toJson());

class OtpVerify {
  Data data;
  String status;
  String message;

  OtpVerify({
    required this.data,
    required this.status,
    required this.message,
  });

  factory OtpVerify.fromJson(Map<String, dynamic> json) => OtpVerify(
    data: Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  String token;
  int id;
  String dealerId;
  String customerType;
  String title;
  String firstName;
  String lastName;
  String email;
  dynamic customerPhoneWork;
  int customerPhoneMobile;
  IngAddress billingAddress;
  IngAddress shippingAddress;
  String panNo;
  String aadharNo;
  String licenceNo;
  String panDoc;
  String aadharDoc;
  String licenceDoc;
  DateTime createdAt;
  DateTime updatedAt;
  String gstNumber;

  Data({
    required this.token,
    required this.id,
    required this.dealerId,
    required this.customerType,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.customerPhoneWork,
    required this.customerPhoneMobile,
    required this.billingAddress,
    required this.shippingAddress,
    required this.panNo,
    required this.aadharNo,
    required this.licenceNo,
    required this.panDoc,
    required this.aadharDoc,
    required this.licenceDoc,
    required this.createdAt,
    required this.updatedAt,
    required this.gstNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    id: json["id"],
    dealerId: json["dealer_id"],
    customerType: json["customer_type"],
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    customerPhoneWork: json["customer_phone_work"],
    customerPhoneMobile: json["customer_phone_mobile"],
    billingAddress: IngAddress.fromJson(json["billing_address"]),
    shippingAddress: IngAddress.fromJson(json["shipping_address"]),
    panNo: json["pan_no"],
    aadharNo: json["aadhar_no"],
    licenceNo: json["licence_no"],
    panDoc: json["pan_doc"],
    aadharDoc: json["aadhar_doc"],
    licenceDoc: json["licence_doc"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    gstNumber: json["gst_number"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
    "dealer_id": dealerId,
    "customer_type": customerType,
    "title": title,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "customer_phone_work": customerPhoneWork,
    "customer_phone_mobile": customerPhoneMobile,
    "billing_address": billingAddress.toJson(),
    "shipping_address": shippingAddress.toJson(),
    "pan_no": panNo,
    "aadhar_no": aadharNo,
    "licence_no": licenceNo,
    "pan_doc": panDoc,
    "aadhar_doc": aadharDoc,
    "licence_doc": licenceDoc,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "gst_number": gstNumber,
  };
}

class IngAddress {
  String country;
  String state;
  String address;
  String city;
  String pincode;

  IngAddress({
    required this.country,
    required this.state,
    required this.address,
    required this.city,
    required this.pincode,
  });

  factory IngAddress.fromJson(Map<String, dynamic> json) => IngAddress(
    country: json["country"],
    state: json["state"],
    address: json["address"],
    city: json["city"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "state": state,
    "address": address,
    "city": city,
    "pincode": pincode,
  };
}
