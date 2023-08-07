import 'package:kazokku_technical_test/features/detail_profile/domain/datas/dao/follow_user_dao.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/data_posting_model.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/detail_profile_model.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/repository/detail_profile_repository.dart';

import '../../../../../common/exceptions/network_connection_exception.dart';
import '../../../../../core/database/db_provider.dart';
import '../../../../../core/network/network_info/network_info.dart';
import '../../../../../core/network/network_info_impl/network_info_impl.dart';
import '../../../../../injection_container.dart';
import '../../datas/dao/impl/follow_user_dao_impl.dart';
import '../../datas/dao/impl/post_like_dao_impl.dart';
import '../../datas/dao/post_like_dao.dart';
import '../../datas/models/follow_user_model.dart';
import '../../datas/models/post_like_model.dart';
import '../../datasources/detail_profile_datasource.dart';
import '../../datasources/impl/detail_profile_datasource_impl.dart';

class DetailProfileRepositoryImpl implements DetailProfileRepository {
  final NetworkInfo networkInfo = sl<NetworkInfoImpl>();
  final DetailProfileDatasource detailProfileDatasource =
      sl<DetailProfileDatasourceImpl>();
  final PostLikeDao postLikeDao = sl<PostLikeDaoImpl>();
  final FollowUserDao followUserDao = sl<FollowUserDaoImpl>();

  @override
  Future<DetailProfileModel> fetchDetailUserProfile(String idUser) async {
    try {
      if (await networkInfo.isConnected) {
        final detailProfileModel =
            await detailProfileDatasource.fetchDetailUserProfile(idUser);
        return detailProfileModel;
      } else {
        throw NetworkConnectionException();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<DataPostingModel>> fetchPostingUser(String idUser) async {
    try {
      if (await networkInfo.isConnected) {
        final dataPostingModel =
            await detailProfileDatasource.fetchPostingUser(idUser);
        return dataPostingModel.data!;
      } else {
        throw NetworkConnectionException();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PostLikeModel>> fetchPostingLike({String? idPosting}) async {
    return await postLikeDao.fetchPostLike(idPosting: idPosting);
  }

  @override
  Future<List<PostLikeModel>> fetchPostingLikeSpecific(
      String? idPosting) async {
    return await postLikeDao.fetchPostLikeSpecific(idPosting);
  }

  @override
  Future<PostLikeModel> savePostingLike(String idPosting) async {
    try {
      PostLikeModel postLikeModel = PostLikeModel(
        idPost: idPosting,
        like: 1,
      );

      int? idPostLikeModel = await postLikeDao.upsert(postLikeModel);
      postLikeModel.id = idPostLikeModel;
      return postLikeModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  deletePostingLike(String idPosting) {
    try {
      final deletedPostLikeModel =
          postLikeDao.deleteBySpecific(postLikeTABLE, "idPost", idPosting);

      return deletedPostLikeModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  deleteFollowUser(String idUser) {
    try {
      final deletedPostLikeModel =
          postLikeDao.deleteBySpecific(usersFollowTABLE, "idUser", idUser);

      return deletedPostLikeModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<FollowUserModel>> fetchFollowUserSpecific(String? idUser) {
    try {
      return followUserDao.fetchFollowUserSpecific(idUser);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<FollowUserModel> followUser(String idUser) async {
    try {
      FollowUserModel followUserModel = FollowUserModel(
        idUser: idUser,
        follow: 1,
      );

      int? idFollowUserModel = await followUserDao.upsert(followUserModel);

      followUserModel.id = idFollowUserModel;

      return followUserModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
