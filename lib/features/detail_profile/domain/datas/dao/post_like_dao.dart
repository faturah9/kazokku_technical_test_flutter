import 'package:kazokku_technical_test/core/database/base_dao.dart';

import '../../../../../core/database/db_provider.dart';
import '../models/post_like_model.dart';

abstract class PostLikeDao extends BaseDao<PostLikeModel> {
  PostLikeDao() : super(postLikeTABLE);

  Future<List<PostLikeModel>> fetchPostLike({String? idPosting});

  Future<List<PostLikeModel>> fetchPostLikeSpecific(String? idPosting);
}
