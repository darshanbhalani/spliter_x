class Membermodel {
  String? photoUrl;
  String? name;
  String? number;

  Membermodel({this.photoUrl, this.name, this.number});

  Membermodel.fromJson(Map<String, dynamic> json) {
    photoUrl = json['PhotoUrl'];
    name = json['Name'];
    number = json['Number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PhotoUrl'] = this.photoUrl;
    data['Name'] = this.name;
    data['Number'] = this.number;
    return data;
  }
}
