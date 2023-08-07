import 'package:dio/dio.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/detail_profile_model.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/posting_model.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datasources/detail_profile_datasource.dart';

import '../../../../../utils/url_utils.dart';

class DetailProfileDatasourceImpl implements DetailProfileDatasource {
  Dio dio = Dio();

  @override
  Future<DetailProfileModel> fetchDetailUserProfile(String idUser) async {
    try {
      dio.options.baseUrl = UrlUtils.baseUrl;
      dio.options.headers["app-id"] = "64cb6be4736266727f2a9a2b";
      Response response = await dio.get(
        "${UrlUtils.user}/$idUser",
      );
      return DetailProfileModel.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<PostingModel> fetchPostingUser(String idUser) async {
    try {
      dio.options.baseUrl = UrlUtils.baseUrl;
      dio.options.headers["app-id"] = "64cb6be4736266727f2a9a2b";
      Response response = await dio.get(
        UrlUtils.postingUser.replaceAll('id', idUser),
      );
      return PostingModel.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }
}
