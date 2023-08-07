import '../datas/models/data_comment_model.dart';

abstract class CommentRepository {
  Future<List<DataCommentModel>> fetchComments(String idPosting);
}