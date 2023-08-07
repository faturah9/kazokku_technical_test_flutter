class LocationDetailProfileModel {
  String? street;
  String? city;
  String? state;
  String? country;
  String? timezone;

  LocationDetailProfileModel({this.street, this.city, this.state, this.country, this.timezone});

  LocationDetailProfileModel.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['timezone'] = timezone;
    return data;
  }
}
