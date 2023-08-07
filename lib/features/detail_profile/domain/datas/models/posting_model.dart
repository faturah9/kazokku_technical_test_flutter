import 'data_posting_model.dart';

class PostingModel {
  List<DataPostingModel>? data;
  int? total;
  int? page;
  int? limit;

  PostingModel({this.data, this.total, this.page, this.limit});

  PostingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataPostingModel>[];
      json['data'].forEach((v) {
        data!.add(DataPostingModel.fromJson(v));
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
