class NotificationModel {
  NotificationModel({
    required this.statusCode,
    required this.body,
  });
  late final int statusCode;
  late final List<Body> body;

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
    required this.title,
    required this.description,
    required this.type,
  });
  late final int id;
  late final String title;
  late final String description;
  late final String type;
  late final String createdAt;
  late final String updatedAt;

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    // image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['type'] = type;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
