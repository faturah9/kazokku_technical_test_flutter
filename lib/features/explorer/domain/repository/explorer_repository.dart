import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/data_posting_model.dart';

abstract class ExplorerRepository {
  Future<List<DataPostingModel>> getExplorers(Map<String, dynamic> params);
}
