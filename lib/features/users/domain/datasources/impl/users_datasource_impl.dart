import 'package:dio/dio.dart';
import 'package:kazokku_technical_test/features/users/domain/datas/models/users_model.dart';

import '../../../../../utils/url_utils.dart';
import '../users_datasource.dart';

class UsersDatasourceImpl implements UsersDatasource {
  Dio dio = Dio();

  @override
  Future<UsersModel> setUserParticipant(Map<String, dynamic> params) async {
    try {
      dio.options.baseUrl = UrlUtils.baseUrl;
      dio.options.headers["app-id"] = "64cb6be4736266727f2a9a2b";
      Response response = await dio.get(
        UrlUtils.user,
        queryParameters: params,
      );
      return UsersModel.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }
}
