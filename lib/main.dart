import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kazokku_technical_test/features/home/presentation/pages/home_page.dart';
import 'package:kazokku_technical_test/features/users/presentation/cubit/users_cubit.dart';

import 'common/constants/router_constants.dart';
import 'features/detail_posting/presentation/cubit/detail_posting_cubit.dart';
import 'features/detail_profile/presentation/cubit/comment_cubit.dart';
import 'features/detail_profile/presentation/cubit/detail_profile_cubit.dart';
import 'features/explorer/presentation/cubit/explorer_cubit.dart';
import 'route/router.dart';
import 'utils/simple_bloc_observer.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: _getProviders(),
        child: ScreenUtilInit(
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              initialRoute: RouteName.homeRoute,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRouter.generateRoute,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.white,
                useMaterial3: true,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: const HomePage(),
            );
          },
        ));
  }

  List<BlocProvider> _getProviders() => [
        BlocProvider<UsersCubit>(
          create: (context) => di.sl<UsersCubit>(),
        ),
        BlocProvider<DetailProfileCubit>(
          create: (context) => di.sl<DetailProfileCubit>(),
        ),
        BlocProvider<CommentCubit>(
          create: (context) => di.sl<CommentCubit>(),
        ),
        BlocProvider<ExplorerCubit>(
          create: (context) => di.sl<ExplorerCubit>(),
        ),
        BlocProvider<DetailPostingCubit>(
          create: (context) => di.sl<DetailPostingCubit>(),
        ),
      ];
}
