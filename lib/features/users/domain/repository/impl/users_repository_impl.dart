import 'package:kazokku_technical_test/features/users/domain/datasources/users_datasource.dart';

import '../../../../../common/exceptions/network_connection_exception.dart';
import '../../../../../core/network/network_info/network_info.dart';
import '../../../../../core/network/network_info_impl/network_info_impl.dart';
import '../../../../../injection_container.dart';
import '../../../../detail_profile/domain/datas/models/owner_model.dart';
import '../../datasources/impl/users_datasource_impl.dart';
import '../users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final NetworkInfo networkInfo = sl<NetworkInfoImpl>();
  final UsersDatasource usersDatasource = sl<UsersDatasourceImpl>();


  @override
  Future<List<Owner>> fetchUsers(Map<String, dynamic> params) async {
    try {
      if (await networkInfo.isConnected) {
        final userModel = await usersDatasource.setUserParticipant(params);
        return userModel.data!;
      } else {
        throw NetworkConnectionException();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
