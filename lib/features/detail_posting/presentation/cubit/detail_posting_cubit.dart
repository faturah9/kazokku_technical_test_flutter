import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../injection_container.dart';
import '../../../detail_profile/domain/datas/models/post_like_model.dart';
import '../../../detail_profile/domain/repository/detail_profile_repository.dart';
import '../../../detail_profile/domain/repository/impl/detail_profile_repository_impl.dart';

part 'detail_posting_state.dart';

class DetailPostingCubit extends Cubit<DetailPostingState> {
  final DetailProfileRepository detailProfileRepository =
      sl<DetailProfileRepositoryImpl>();

  DetailPostingCubit() : super(DetailPostingInitial());

  Future<void> saveLikePosting(String idPosting) async {
    try {
      List<PostLikeModel> dataPostLikeModel = await detailProfileRepository
          .fetchPostingLikeSpecific(idPosting);

      if (dataPostLikeModel.isEmpty) {
        await detailProfileRepository.savePostingLike(idPosting);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteLikePosting(String idPosting) async {
    try {
      List<PostLikeModel> dataPostLikeModel = await detailProfileRepository
          .fetchPostingLikeSpecific(idPosting);

      if (dataPostLikeModel.isNotEmpty) {
        await detailProfileRepository.deletePostingLike(idPosting);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
