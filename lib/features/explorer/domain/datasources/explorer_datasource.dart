import 'package:kazokku_technical_test/features/explorer/domain/datas/models/explorer_model.dart';

abstract class ExplorerDatasource {
  Future<ExplorerModel> getExplorers(Map<String, dynamic> params);
}