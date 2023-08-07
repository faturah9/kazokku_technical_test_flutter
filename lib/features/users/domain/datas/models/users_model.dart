
import '../../../../detail_profile/domain/datas/models/owner_model.dart';

class UsersModel {
  List<Owner>? data;
  int? total;
  int? page;
  int? limit;

  UsersModel({this.data, this.total, this.page, this.limit});

  UsersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Owner>[];
      json['data'].forEach((v) {
        data!.add(Owner.fromJson(v));
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
