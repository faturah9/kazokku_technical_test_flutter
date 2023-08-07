import 'package:bloc/bloc.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/post_like_model.dart';
import 'package:meta/meta.dart';

import '../../../../injection_container.dart';
import '../../domain/datas/models/data_posting_model.dart';
import '../../domain/datas/models/detail_profile_model.dart';
import '../../domain/datas/models/follow_user_model.dart';
import '../../domain/datas/models/posting_model.dart';
import '../../domain/repository/detail_profile_repository.dart';
import '../../domain/repository/impl/detail_profile_repository_impl.dart';

part 'detail_profile_state.dart';

class DetailProfileCubit extends Cubit<DetailProfileState> {
  final DetailProfileRepository detailProfileRepository =
      sl<DetailProfileRepositoryImpl>();
  int? limit;

  DetailProfileCubit() : super(DetailProfileInitial());

  Future<void> fetchPostingLike() async {
    try {
      final fetchPostingList = await detailProfileRepository.fetchPostingLike();
      emit(
        state.copyWith(
          listDataPostingLikeModel: fetchPostingList,
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  fetchDetailUser(String idUser) async {
    emit(DetailProfileLoading());
    try {
      final fetchFollowUser =
          await detailProfileRepository.fetchFollowUserSpecific(idUser);

      final getDataProfile =
          await detailProfileRepository.fetchDetailUserProfile(idUser);

      if (fetchFollowUser.isNotEmpty) {
        getDataProfile.isFollow = true;
      }

      emit(
        state.copyWith(
          detailProfileModel: getDataProfile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailProfileModel: null,
        ),
      );
    }
  }

  fetchPostingUser({String? idUser, String? stringSearch}) async {
    if (stringSearch != '' && stringSearch != null) {
      emit(DetailProfileLoading());

      emit(PostingProfileLoading());
    } else {
      emit(PostingProfileLoading());
    }

    try {
      List<DataPostingModel> listDataPostingModel = [];

      final fetchPostingLike = await detailProfileRepository.fetchPostingLike();

      final getData = await detailProfileRepository.fetchPostingUser(idUser!);

      if (stringSearch != '' && stringSearch != null) {
        await fetchDetailUser(idUser);
        for (var element in getData) {
          if (element.text!.contains(stringSearch)) {
            for (var element2 in fetchPostingLike) {
              if (element.id == element2.idPost) {
                element.isLike = true;
              }
            }
            listDataPostingModel.add(element);
          }
        }
      } else {
        // await fetchDetailUser(idUser);
        for (var element in getData) {
          for (var element2 in fetchPostingLike) {
            if (element.id == element2.idPost) {
              element.isLike = true;
            }
          }
        }
        listDataPostingModel = getData;
      }

      emit(
        state.copyWith(
          listDataPostingModel: listDataPostingModel,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          listDataPostingModel: [],
        ),
      );
    }
  }

  followUser(String idUser) async {
    emit(DetailProfileLoading());
    emit(PostingProfileLoading());
    try {
      List<FollowUserModel> dataFollowUserModel =
          await detailProfileRepository.fetchFollowUserSpecific(idUser);

      if (dataFollowUserModel.isEmpty) {
        await detailProfileRepository.followUser(idUser);
        final getDataProfile =
            await detailProfileRepository.fetchDetailUserProfile(idUser);
        getDataProfile.isFollow = true;
        final getData = await detailProfileRepository.fetchPostingUser(idUser);
        emit(
          state.copyWith(
            detailProfileModel: getDataProfile,
            listDataPostingModel: getData,
          ),
        );
      } else {
        await detailProfileRepository.deleteFollowUser(idUser);
        final getDataProfile =
            await detailProfileRepository.fetchDetailUserProfile(idUser);
        getDataProfile.isFollow = false;
        final getData = await detailProfileRepository.fetchPostingUser(idUser);
        emit(
          state.copyWith(
            detailProfileModel: getDataProfile,
            listDataPostingModel: getData,
          ),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
