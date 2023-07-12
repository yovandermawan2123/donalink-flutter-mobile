class MyDonationModel {
  MyDonationModel({
    required this.statusCode,
    required this.body,
  });
  late final int statusCode;
  late final List<Body> body;

  MyDonationModel.fromJson(Map<String, dynamic> json) {
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
    required this.invoice_number,
    required this.amount,
    required this.snap_token,
    required this.status,
    required this.campaign_name,
    required this.campaign_slug,
    required this.campaign_image,
  });
  late final int id;
  late final String invoice_number;
  late final String amount;
  late final String snap_token;
  late final String status;
  late final String campaign_name;
  late final String campaign_slug;
  late final String campaign_image;

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoice_number = json['invoice_number'];
    amount = json['amount'];
    snap_token = json['snap_token'];
    status = json['status'];
    campaign_name = json['campaign_name'];
    campaign_slug = json['campaign_slug'];
    campaign_image = json['campaign_image'];

    // image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['invoice_number'] = invoice_number;
    _data['amount'] = amount;
    _data['snap_token'] = snap_token;
    _data['status'] = status;
    _data['campaign_name'] = campaign_name;
    _data['campaign_slug'] = campaign_slug;
    _data['campaign_image'] = campaign_image;

    return _data;
  }
}
