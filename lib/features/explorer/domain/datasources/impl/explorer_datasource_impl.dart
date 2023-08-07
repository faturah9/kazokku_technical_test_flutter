import 'package:dio/dio.dart';
import 'package:kazokku_technical_test/features/explorer/domain/datas/models/explorer_model.dart';
import 'package:kazokku_technical_test/features/explorer/domain/datasources/explorer_datasource.dart';

import '../../../../../utils/url_utils.dart';

class ExplorerDatasourceImpl implements ExplorerDatasource {
  Dio dio = Dio();

  @override
  Future<ExplorerModel> getExplorers(Map<String, dynamic> params) async {
    try {
      dio.options.baseUrl = UrlUtils.baseUrl;
      dio.options.headers["app-id"] = "64cb6be4736266727f2a9a2b";
      Response response = await dio.get(
        UrlUtils.explorer,
        queryParameters: params,
      );
      return ExplorerModel.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }
}