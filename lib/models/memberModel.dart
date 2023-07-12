class MemberModel {
  MemberModel({
    required this.statusCode,
    required this.body,
  });
  late final int statusCode;
  late final List<Body> body;

  MemberModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    body = List.from(json['body']).map((e) => Body.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['body'] = body.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Body {
  Body({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.mobile,
    required this.password,
    this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String email;
  late final Null emailVerifiedAt;
  late final String mobile;
  late final String password;
  late final String? address;
  late final int status;
  late final String createdAt;
  late final String updatedAt;
  late final String image;

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = null;
    mobile = json['mobile'];
    password = json['password'];
    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['mobile'] = mobile;
    _data['password'] = password;
    _data['address'] = address;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['image'] = image;
    return _data;
  }
}
