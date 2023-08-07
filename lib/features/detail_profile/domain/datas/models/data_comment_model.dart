import 'owner_model.dart';

class DataCommentModel {
  String? id;
  String? message;
  Owner? owner;
  String? post;
  String? publishDate;

  DataCommentModel({this.id, this.message, this.owner, this.post, this.publishDate});

  DataCommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    post = json['post'];
    publishDate = json['publishDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['post'] = post;
    data['publishDate'] = publishDate;
    return data;
  }
}
