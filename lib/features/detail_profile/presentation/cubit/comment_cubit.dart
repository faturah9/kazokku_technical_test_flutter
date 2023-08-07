import 'package:bloc/bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/datas/models/data_comment_model.dart';
import '../../domain/repository/comment_repository.dart';
import '../../domain/repository/impl/comment_repository_impl.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {

  final CommentRepository commentRepository = sl<CommentRepositoryImpl>();

  CommentCubit() : super(CommentInitial());

  Future<void> fetchComment(String idPosting) async {
    emit(CommentLoading());

    try {
      final getData = await commentRepository.fetchComments(idPosting);

      emit(
        state.copyWith(
          listDataCommentModel: getData,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          listDataCommentModel: [],
        ),
      );
    }
  }
}
