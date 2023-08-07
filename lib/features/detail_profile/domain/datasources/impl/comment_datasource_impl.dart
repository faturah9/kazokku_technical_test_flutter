import 'package:dio/dio.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/comment_model.dart';
import 'package:kazokku_technical_test/utils/url_utils.dart';

import '../comment_datasource.dart';

class CommentDatasourceImpl implements CommentDatasource {
  Dio dio = Dio();

  @override
  Future<CommentModel> fetchComments(String idPosting) async {
    try {
      dio.options.baseUrl = "https://dummyapi.io/data/v1/";
      dio.options.headers["app-id"] = "64cb6be4736266727f2a9a2b";
      Response response = await dio.get(
        UrlUtils.comment.replaceAll('id', idPosting),
      );
      return CommentModel.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }
}
