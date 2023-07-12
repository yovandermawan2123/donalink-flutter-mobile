class CampaignModel {
  CampaignModel({
    required this.statusCode,
    required this.body,
  });
  late final int statusCode;
  late final List<Body> body;

  CampaignModel.fromJson(Map<String, dynamic> json) {
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
    required this.slug,
    required this.description,
    required this.target,
    required this.image,
    required this.status,
    required this.start_date,
    required this.end_date,
    required this.total_collected,
    required this.total_collected_percentage,
    required this.createdAt,
    required this.updatedAt,
    // required this.image,
  });
  late final int id;
  late final String name;
  late final String slug;
  late final String description;
  late final String target;
  late final String image;
  late final String status;
  late final String start_date;
  late final String end_date;
  late final int total_collected;
  late final int total_collected_percentage;
  late final String createdAt;
  late final String updatedAt;
  // late final String image;

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    target = json['target'];
    image = json['image'];
    status = json['status'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    total_collected = json['total_collected'];
    total_collected_percentage = json['total_collected_percentage'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['description'] = description;
    _data['target'] = target;
    _data['image'] = image;
    _data['start_date'] = start_date;
    _data['end_date'] = end_date;
    _data['total_collected'] = total_collected;
    _data['total_collected_percentage'] = total_collected_percentage;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    // _data['image'] = image;
    return _data;
  }
}
