// To parse this JSON data, do
//
//     final profileDetails = profileDetailsFromJson(jsonString);

import 'dart:convert';

ProfileDetails profileDetailsFromJson(String str) => ProfileDetails.fromJson(json.decode(str));

String profileDetailsToJson(ProfileDetails data) => json.encode(data.toJson());

class ProfileDetails {
  ProfileData data;
  String status;

  ProfileDetails({
    required this.data,
    required this.status,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
    data: ProfileData.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
  };
}

class ProfileData {
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

  ProfileData({
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

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
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
