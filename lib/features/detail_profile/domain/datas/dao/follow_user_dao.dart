import 'package:kazokku_technical_test/core/database/db_provider.dart';

import '../../../../../core/database/base_dao.dart';
import '../models/follow_user_model.dart';

abstract class FollowUserDao extends BaseDao<FollowUserModel>{
  FollowUserDao() : super(usersFollowTABLE);

  Future<List<FollowUserModel>> fetchFollowUserSpecific(String? idUser);
}
