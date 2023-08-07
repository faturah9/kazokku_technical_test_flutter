import 'location_detail_profile_model.dart';

class DetailProfileModel {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? gender;
  String? email;
  String? dateOfBirth;
  String? phone;
  LocationDetailProfileModel? location;
  String? registerDate;
  String? updatedDate;
  bool? isFollow = false;

  DetailProfileModel({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.phone,
    this.location,
    this.registerDate,
    this.updatedDate,
    this.isFollow,
  });

  DetailProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picture = json['picture'];
    gender = json['gender'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    phone = json['phone'];
    location = json['location'] != null
        ? LocationDetailProfileModel.fromJson(json['location'])
        : null;
    registerDate = json['registerDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['picture'] = picture;
    data['gender'] = gender;
    data['email'] = email;
    data['dateOfBirth'] = dateOfBirth;
    data['phone'] = phone;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['registerDate'] = registerDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
