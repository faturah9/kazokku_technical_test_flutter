import '../../../../../utils/model.dart';

class FollowUserModel implements BaseModel {
  int? id;
  String? idUser;
  int? follow;

  FollowUserModel({this.id, this.idUser, this.follow});

  static FollowUserModel fromJson(Map<String, dynamic> json) {
    return FollowUserModel(
      id: json['id'],
      idUser: json['idUser'],
      follow: json['follow'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUser'] = idUser;
    data['follow'] = follow;
    return data;
  }

  @override
  jsonToModel(Map<String, dynamic> json) {
    return fromJson(json);
  }

  FollowUserModel copyWith({
    int? id,
    String? idUser,
    int? follow,
  }) {
    return FollowUserModel(
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      follow: follow ?? this.follow,
    );
  }
}
