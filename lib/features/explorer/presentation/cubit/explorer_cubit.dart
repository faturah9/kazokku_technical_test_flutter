import 'package:bloc/bloc.dart';

import '../../../../injection_container.dart';
import '../../../detail_profile/domain/datas/models/data_posting_model.dart';
import '../../../detail_profile/domain/repository/detail_profile_repository.dart';
import '../../../detail_profile/domain/repository/impl/detail_profile_repository_impl.dart';
import '../../domain/repository/explorer_repository.dart';
import '../../domain/repository/impl/explorer_repository_impl.dart';

part 'explorer_state.dart';

class ExplorerCubit extends Cubit<ExplorerState> {
  final ExplorerRepository explorerRepository = sl<ExplorerRepositoryImpl>();
  final DetailProfileRepository detailProfileRepository =
      sl<DetailProfileRepositoryImpl>();
  int? limit;

  ExplorerCubit() : super(ExplorerInitial());

  Future<void> fetchExplorer({
    bool? loadMore = false,
    String? stringSearch,
  }) async {
    if (!loadMore!) {
      emit(ExplorerLoading());
    }

    try {
      List<DataPostingModel> dataExplorerModel = [];
      limit = loadMore ? limit! + 10 : 20;

      Map<String, dynamic> params = {
        'limit': limit.toString(),
      };

      final fetchPostingLike = await detailProfileRepository.fetchPostingLike();

      final getData = await explorerRepository.getExplorers(params);

      if (getData.isNotEmpty) {
        List<DataPostingModel> newDataExplorerModel = getData;

        if (loadMore) {
          if (stringSearch != '' && stringSearch != null) {
            for (var element in getData) {
              // for (var element2 in fetchPostingLike) {
              //   if (element.id == element2.idPost) {
              //     element.isLike = true;
              //   }
              // }
              if (element.text!.contains(stringSearch)) {
                for (var element2 in fetchPostingLike) {
                  if (element.id == element2.idPost) {
                    element.isLike = true;
                  }
                }
                newDataExplorerModel.add(element);
              }
            }
            dataExplorerModel.addAll(newDataExplorerModel);
          } else {
            for (var element in getData) {
              for (var element2 in fetchPostingLike) {
                if (element.id == element2.idPost) {
                  element.isLike = true;
                }
              }
            }
            dataExplorerModel.addAll(newDataExplorerModel);
          }
        } else {
          if (stringSearch != '' && stringSearch != null) {
            for (var element in getData) {
              // for (var element2 in fetchPostingLike) {
              //   if (element.id == element2.idPost) {
              //     element.isLike = true;
              //   }
              // }
              if (element.text!.contains(stringSearch)) {
                for (var element2 in fetchPostingLike) {
                  if (element.id == element2.idPost) {
                    element.isLike = true;
                  }
                }
                // newDataExplorerModel.add(element);
                dataExplorerModel.add(element);
              }
            }
            // dataExplorerModel = getData;
          } else {
            for (var element in getData) {
              for (var element2 in fetchPostingLike) {
                if (element.id == element2.idPost) {
                  element.isLike = true;
                }
              }
            }
            dataExplorerModel = getData;
          }
        }
      }

      emit(
        state.copyWith(
          listDataExplorerModel: dataExplorerModel,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          listDataExplorerModel: [],
        ),
      );
    }
  }

  Future<void> fetchLikes({
    bool? loadMore = false,
  }) async {
    if (!loadMore!) {
      emit(LikesLoading());
    }

    try {
      List<DataPostingModel> dataExplorerModel = [];
      // limit = loadMore ? limit! + 10 : 0;
      //
      Map<String, dynamic> params = {
        'limit': "",
      };

      final fetchPostingLike = await detailProfileRepository.fetchPostingLike();

      final getData = await explorerRepository.getExplorers(params);

      if (getData.isNotEmpty) {
        // List<DataPostingModel> newDataExplorerModel = getData;

        if (loadMore) {
          for (var element in getData) {
            for (var element2 in fetchPostingLike) {
              if (element.id == element2.idPost) {
                element.isLike = true;
                dataExplorerModel.add(element);
              }
            }
          }
          // dataExplorerModel.addAll(newDataExplorerModel);
        } else {
          for (var element in getData) {
            for (var element2 in fetchPostingLike) {
              if (element.id == element2.idPost) {
                element.isLike = true;
                dataExplorerModel.add(element);
              }
            }
          }
          // dataExplorerModel = getData;
        }
      }

      emit(
        state.copyWith(
          listDataExplorerModel: dataExplorerModel,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          listDataExplorerModel: [],
        ),
      );
    }
  }
}
