import 'data_comment_model.dart';

class CommentModel {
  List<DataCommentModel>? data;
  int? total;
  int? page;
  int? limit;

  CommentModel({this.data, this.total, this.page, this.limit});

  CommentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataCommentModel>[];
      json['data'].forEach((v) {
        data!.add(DataCommentModel.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    return data;
  }
}

