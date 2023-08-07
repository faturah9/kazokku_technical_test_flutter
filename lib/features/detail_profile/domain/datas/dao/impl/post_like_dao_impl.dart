import 'package:sqflite/sqflite.dart';

import '../../../../../../core/database/db_provider.dart';
import '../../../../../../injection_container.dart';
import '../../models/post_like_model.dart';
import '../post_like_dao.dart';

class PostLikeDaoImpl extends PostLikeDao {
  final Database db = sl<Database>();

  @override
  Future<List<PostLikeModel>> fetchPostLike({String? idPosting}) async {
    List<Map<String, Object?>> a =
        await db.rawQuery("select * from $postLikeTABLE");

    return a.isNotEmpty ? a.map((e) => PostLikeModel.fromJson(e)).toList() : [];
  }

  @override
  Future<List<PostLikeModel>> fetchPostLikeSpecific(
      String? idPosting) async {
    List<Map<String, Object?>> a = await db.rawQuery(
        "select * from $postLikeTABLE WHERE idPost = '$idPosting'");

    return a.isNotEmpty ? a.map((e) => PostLikeModel.fromJson(e)).toList() : [];
  }
}
