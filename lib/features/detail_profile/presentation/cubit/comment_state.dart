part of 'comment_cubit.dart';

class CommentState {
  final List<DataCommentModel>? listDataCommentModel;

  CommentState({this.listDataCommentModel});

  CommentState copyWith({
    List<DataCommentModel>? listDataCommentModel,
  }) {
    return CommentState(
      listDataCommentModel: listDataCommentModel ?? this.listDataCommentModel,
    );
  }
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}
