import 'package:kazokku_technical_test/features/detail_profile/domain/datas/dao/post_like_dao.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/detail_profile_model.dart';

import '../datas/models/data_posting_model.dart';
import '../datas/models/follow_user_model.dart';
import '../datas/models/post_like_model.dart';

abstract class DetailProfileRepository {
  Future<DetailProfileModel> fetchDetailUserProfile(String idUser);

  Future<List<DataPostingModel>> fetchPostingUser(String idUser);

  Future<List<PostLikeModel>> fetchPostingLike({String? idPosting});

  savePostingLike(String idPosting);

  deletePostingLike(String idPosting);

  Future<List<PostLikeModel>> fetchPostingLikeSpecific(String? idPosting);

  followUser(String idUser);

  deleteFollowUser(String idUser);

  Future<List<FollowUserModel>> fetchFollowUserSpecific(String? idPosting);
}
