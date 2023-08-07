import '../../../../detail_profile/domain/datas/models/data_posting_model.dart';

class ExplorerModel {
  List<DataPostingModel>? data;
  int? total;
  int? page;
  int? limit;

  ExplorerModel({this.data, this.total, this.page, this.limit});

  ExplorerModel.fromJson(Map<String, dynamic> json) {
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