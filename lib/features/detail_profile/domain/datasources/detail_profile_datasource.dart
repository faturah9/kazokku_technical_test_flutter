import '../datas/models/detail_profile_model.dart';
import '../datas/models/posting_model.dart';

abstract class DetailProfileDatasource {
  Future<DetailProfileModel> fetchDetailUserProfile(String idUser);

  Future<PostingModel> fetchPostingUser(String idUser);
}