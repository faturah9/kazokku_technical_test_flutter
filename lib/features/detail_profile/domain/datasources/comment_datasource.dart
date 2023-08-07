import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/comment_model.dart';

abstract class CommentDatasource {
  Future<CommentModel> fetchComments(String idPosting);
}