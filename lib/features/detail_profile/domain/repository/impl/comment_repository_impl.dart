import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/data_comment_model.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/repository/comment_repository.dart';

import '../../../../../common/exceptions/network_connection_exception.dart';
import '../../../../../core/network/network_info/network_info.dart';
import '../../../../../core/network/network_info_impl/network_info_impl.dart';
import '../../../../../injection_container.dart';
import '../../datasources/comment_datasource.dart';
import '../../datasources/impl/comment_datasource_impl.dart';

class CommentRepositoryImpl implements CommentRepository {
  final NetworkInfo networkInfo = sl<NetworkInfoImpl>();
  final CommentDatasource commentDatasource = sl<CommentDatasourceImpl>();


  @override
  Future<List<DataCommentModel>> fetchComments(String idPosting) async {
    try {
      if (await networkInfo.isConnected) {
        final commentModel = await commentDatasource.fetchComments(idPosting);
        return commentModel.data!;
      } else {
        throw NetworkConnectionException();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
