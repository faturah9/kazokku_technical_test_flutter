import 'package:bloc/bloc.dart';

import '../../../../injection_container.dart';
import '../../../detail_profile/domain/datas/models/owner_model.dart';
import '../../domain/repository/impl/users_repository_impl.dart';
import '../../domain/repository/users_repository.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepository usersRepository = sl<UsersRepositoryImpl>();
  int? limit;

  UsersCubit() : super(UsersInitial());

  Future<void> fetchUsersList({
    bool? loadMore = false,
  }) async {
    if (!loadMore!) {
      emit(UsersLoading());
    }

    try {
      List<Owner> userDataModel = [];
      limit = loadMore ? limit! + 10 : 20;

      Map<String, dynamic> params = {
        'limit': limit.toString(),
      };

      final getData = await usersRepository.fetchUsers(params);

      if (getData.isNotEmpty) {
        List<Owner> newOwner = getData;
        if (loadMore) {
          userDataModel.addAll(newOwner);
        } else {
          userDataModel = getData;
        }
      }

      emit(
        state.copyWith(
          listOwner: userDataModel,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          listOwner: [],
        ),
      );
    }
  }
}
