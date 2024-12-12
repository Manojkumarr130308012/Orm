import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Result result;
  String message;
  int statusCode;

  Login({
    required this.result,
    required this.message,
    required this.statusCode,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    result: Result.fromJson(json["result"]),
    message: json["message"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
    "message": message,
    "statusCode": statusCode,
  };
}

class Result {
  String id;
  String siteId;
  String firstName;
  String lastName;
  String siteName;
  String organizationName;
  String roleName;
  String accessToken;
  String refreshToken;
  String organizationId;
  List<MenuList> menuList;

  Result({
    required this.id,
    required this.siteId,
    required this.firstName,
    required this.lastName,
    required this.siteName,
    required this.organizationName,
    required this.roleName,
    required this.accessToken,
    required this.refreshToken,
    required this.organizationId,
    required this.menuList,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    siteId: json["siteId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    siteName: json["siteName"],
    organizationName: json["organizationName"],
    roleName: json["roleName"],
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    organizationId: json["organizationId"],
    menuList: List<MenuList>.from(json["menuList"].map((x) => MenuList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "siteId": siteId,
    "firstName": firstName,
    "lastName": lastName,
    "siteName": siteName,
    "organizationName": organizationName,
    "roleName": roleName,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "organizationId": organizationId,
    "menuList": List<dynamic>.from(menuList.map((x) => x.toJson())),
  };
}

class MenuList {
  String id;
  String name;
  String href;
  String apiRoute;
  int displayOrder;
  String icon;
  bool view;
  bool edit;
  bool delete;
  bool create;
  String module;
  List<MenuList>? childMenus;

  MenuList({
    required this.id,
    required this.name,
    required this.href,
    required this.apiRoute,
    required this.displayOrder,
    required this.icon,
    required this.view,
    required this.edit,
    required this.delete,
    required this.create,
    required this.module,
    this.childMenus,
  });

  factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
    id: json["id"],
    name: json["name"],
    href: json["href"],
    apiRoute: json["apiRoute"],
    displayOrder: json["displayOrder"],
    icon: json["icon"],
    view: json["view"],
    edit: json["edit"],
    delete: json["delete"],
    create: json["create"],
    module: json["module"],
    childMenus: json["childMenus"] == null ? [] : List<MenuList>.from(json["childMenus"]!.map((x) => MenuList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "href": href,
    "apiRoute": apiRoute,
    "displayOrder": displayOrder,
    "icon": icon,
    "view": view,
    "edit": edit,
    "delete": delete,
    "create": create,
    "module": module,
    "childMenus": childMenus == null ? [] : List<dynamic>.from(childMenus!.map((x) => x.toJson())),
  };
}
