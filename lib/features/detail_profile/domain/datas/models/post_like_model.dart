import '../../../../../utils/model.dart';

class PostLikeModel implements BaseModel {
  int? id;
  String? idPost;
  int? like;

  PostLikeModel({this.id, this.idPost, this.like});

  static PostLikeModel fromJson(Map<String, dynamic> json) {
    return PostLikeModel(
      id: json['id'],
      idPost: json['idPost'],
      like: json['like'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idPost'] = idPost;
    data['like'] = like;
    return data;
  }

  @override
  jsonToModel(Map<String, dynamic> json) {
    return fromJson(json);
  }

  PostLikeModel copyWith({
    int? id,
    String? idPost,
    int? like,
  }) {
    return PostLikeModel(
      id: id ?? this.id,
      idPost: idPost ?? this.idPost,
      like: like ?? this.like,
    );
  }
}
