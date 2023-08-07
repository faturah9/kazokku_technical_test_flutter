import 'package:kazokku_technical_test/core/database/db_provider.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/follow_user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../../injection_container.dart';
import '../follow_user_dao.dart';

class FollowUserDaoImpl extends FollowUserDao {
  final Database db = sl<Database>();

  @override
  Future<List<FollowUserModel>> fetchFollowUserSpecific(
      String? idUser) async {
    List<Map<String, Object?>> a = await db
        .rawQuery("select * from $usersFollowTABLE WHERE idUser = '$idUser'");

    return a.isNotEmpty
        ? a.map((e) => FollowUserModel.fromJson(e)).toList()
        : [];
  }
}
