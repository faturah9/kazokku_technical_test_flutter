
import '../../../../../common/exceptions/network_connection_exception.dart';
import '../../../../../core/network/network_info/network_info.dart';
import '../../../../../core/network/network_info_impl/network_info_impl.dart';
import '../../../../../injection_container.dart';
import '../../../../detail_profile/domain/datas/models/data_posting_model.dart';
import '../../datasources/explorer_datasource.dart';
import '../../datasources/impl/explorer_datasource_impl.dart';
import '../explorer_repository.dart';

class ExplorerRepositoryImpl implements ExplorerRepository {
  final NetworkInfo networkInfo = sl<NetworkInfoImpl>();
  final ExplorerDatasource explorerDatasource = sl<ExplorerDatasourceImpl>();

  @override
  Future<List<DataPostingModel>> getExplorers(Map<String, dynamic> params) async {
    try {
      if (await networkInfo.isConnected) {
        final dataExplorerModel = await explorerDatasource.getExplorers(params);
        return dataExplorerModel.data!;
      } else {
        throw NetworkConnectionException();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

}