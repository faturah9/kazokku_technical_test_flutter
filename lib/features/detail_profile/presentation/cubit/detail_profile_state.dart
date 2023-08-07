part of 'detail_profile_cubit.dart';

class DetailProfileState {
  final DetailProfileModel? detailProfileModel;
  final List<DataPostingModel>? listDataPostingModel;
  final List<PostLikeModel>? listDataPostingLikeModel;

  DetailProfileState({
    this.detailProfileModel,
    this.listDataPostingModel,
    this.listDataPostingLikeModel,
  });

  DetailProfileState copyWith({
    DetailProfileModel? detailProfileModel,
    List<DataPostingModel>? listDataPostingModel,
    List<PostLikeModel>? listDataPostingLikeModel,
  }) {
    return DetailProfileState(
      detailProfileModel: detailProfileModel ?? this.detailProfileModel,
      listDataPostingModel: listDataPostingModel ?? this.listDataPostingModel,
      listDataPostingLikeModel:
          listDataPostingLikeModel ?? this.listDataPostingLikeModel,
    );
  }
}

class DetailProfileInitial extends DetailProfileState {}

class DetailProfileLoading extends DetailProfileState {}

class PostingProfileLoading extends DetailProfileState {}
