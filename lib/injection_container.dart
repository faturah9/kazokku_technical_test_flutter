import 'package:get_it/get_it.dart';
import 'package:kazokku_technical_test/features/users/presentation/cubit/users_cubit.dart';
import 'package:sqflite/sqflite.dart';

import 'core/database/db_provider.dart';
import 'core/network/network_info/network_info.dart';
import 'core/network/network_info_impl/network_info_impl.dart';
import 'features/detail_posting/presentation/cubit/detail_posting_cubit.dart';
import 'features/detail_profile/domain/datas/dao/follow_user_dao.dart';
import 'features/detail_profile/domain/datas/dao/impl/follow_user_dao_impl.dart';
import 'features/detail_profile/domain/datas/dao/impl/post_like_dao_impl.dart';
import 'features/detail_profile/domain/datas/dao/post_like_dao.dart';
import 'features/detail_profile/domain/datasources/comment_datasource.dart';
import 'features/detail_profile/domain/datasources/detail_profile_datasource.dart';
import 'features/detail_profile/domain/datasources/impl/comment_datasource_impl.dart';
import 'features/detail_profile/domain/datasources/impl/detail_profile_datasource_impl.dart';
import 'features/detail_profile/domain/repository/comment_repository.dart';
import 'features/detail_profile/domain/repository/detail_profile_repository.dart';
import 'features/detail_profile/domain/repository/impl/comment_repository_impl.dart';
import 'features/detail_profile/domain/repository/impl/detail_profile_repository_impl.dart';
import 'features/detail_profile/presentation/cubit/comment_cubit.dart';
import 'features/detail_profile/presentation/cubit/detail_profile_cubit.dart';
import 'features/explorer/domain/datasources/explorer_datasource.dart';
import 'features/explorer/domain/datasources/impl/explorer_datasource_impl.dart';
import 'features/explorer/domain/repository/explorer_repository.dart';
import 'features/explorer/domain/repository/impl/explorer_repository_impl.dart';
import 'features/explorer/presentation/cubit/explorer_cubit.dart';
import 'features/users/domain/datasources/impl/users_datasource_impl.dart';
import 'features/users/domain/datasources/users_datasource.dart';
import 'features/users/domain/repository/impl/users_repository_impl.dart';
import 'features/users/domain/repository/users_repository.dart';

final sl = GetIt.instance;

Future<GetIt> init() async {
  /// Bloc or Cubit
  if (!sl.isRegistered<UsersCubit>()) {
    sl.registerLazySingleton(() => UsersCubit());
  }
  if (!sl.isRegistered<DetailProfileCubit>()) {
    sl.registerLazySingleton(() => DetailProfileCubit());
  }
  if (!sl.isRegistered<CommentCubit>()) {
    sl.registerLazySingleton(() => CommentCubit());
  }
  if (!sl.isRegistered<ExplorerCubit>()) {
    sl.registerLazySingleton(() => ExplorerCubit());
  }
  if (!sl.isRegistered<DetailPostingCubit>()) {
    sl.registerLazySingleton(() => DetailPostingCubit());
  }

  ///database
  final dbClient = DbClient();
  final db = await dbClient();
  if (!sl.isRegistered<Database>()) {
    sl.registerLazySingleton(() => db);
  }

  ///core
  if (!sl.isRegistered<NetworkInfo>()) {
    sl.registerLazySingleton(() => NetworkInfoImpl());
  }

  ///dao
  if (!sl.isRegistered<PostLikeDao>()) {
    sl.registerLazySingleton(() => PostLikeDaoImpl());
  }
  if (!sl.isRegistered<FollowUserDao>()) {
    sl.registerLazySingleton(() => FollowUserDaoImpl());
  }

  /// Repository
  if (!sl.isRegistered<UsersRepository>()) {
    sl.registerLazySingleton(() => UsersRepositoryImpl());
  }
  if (!sl.isRegistered<DetailProfileRepository>()) {
    sl.registerLazySingleton(() => DetailProfileRepositoryImpl());
  }
  if (!sl.isRegistered<CommentRepository>()) {
    sl.registerLazySingleton(() => CommentRepositoryImpl());
  }
  if (!sl.isRegistered<ExplorerRepository>()) {
    sl.registerLazySingleton(() => ExplorerRepositoryImpl());
  }

  /// Data sources
  if (!sl.isRegistered<UsersDatasource>()) {
    sl.registerLazySingleton(() => UsersDatasourceImpl());
  }
  if (!sl.isRegistered<DetailProfileDatasource>()) {
    sl.registerLazySingleton(() => DetailProfileDatasourceImpl());
  }
  if (!sl.isRegistered<CommentDatasource>()) {
    sl.registerLazySingleton(() => CommentDatasourceImpl());
  }
  if (!sl.isRegistered<ExplorerDatasource>()) {
    sl.registerLazySingleton(() => ExplorerDatasourceImpl());
  }

  /// External
  // final sharedPreferences = await SharedPreferences.getInstance();
  // if (!sl.isRegistered<SharedPreferences>()) {
  //   sl.registerLazySingleton(() => sharedPreferences);
  // }
  // if (!sl.isRegistered<AppSharedPreferences>()) {
  //   sl.registerLazySingleton(() => AppSharedPreferencesImpl());
  // }
  return sl;
}
