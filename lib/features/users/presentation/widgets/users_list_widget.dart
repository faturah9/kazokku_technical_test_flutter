import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kazokku_technical_test/features/users/presentation/widgets/users_item_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/not_found_widget.dart';
import '../cubit/users_cubit.dart';
import 'users_list_loading.dart';

class UsersListWidget extends StatefulWidget {
  const UsersListWidget({super.key});

  @override
  State<UsersListWidget> createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: AppColors.white,
      child: BlocListener<UsersCubit, UsersState>(
        listener: (context, state) {},
        child: BlocBuilder<UsersCubit, UsersState>(
          buildWhen: (previous, current) =>
              previous.listOwner != current.listOwner,
          builder: (context, state) {
            if (state is UsersLoading) {
              return const Padding(
                padding: EdgeInsets.all(18.0),
                child: UsersListLoading(),
              );
            } else {
              return state.listOwner!.isNotEmpty
                  ? SmartRefresher(
                      controller: refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const ClassicHeader(),
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus? mode) {
                          Widget body;
                          if (mode == LoadStatus.idle) {
                            body = const Text("Pull Up Load");
                          } else if (mode == LoadStatus.loading) {
                            body = const CircularProgressIndicator();
                          } else if (mode == LoadStatus.failed) {
                            body = const Text("Load Failed! Click Retry!");
                          } else if (mode == LoadStatus.canLoading) {
                            body = const Text("Release to Load More");
                          } else {
                            body = const Text("No More Data");
                          }
                          return SizedBox(
                            height: 55.0,
                            child: Center(child: body),
                          );
                        },
                      ),
                      onLoading: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        await sl<UsersCubit>().fetchUsersList(
                          loadMore: true,
                        );
                        refreshController.loadComplete();
                      },
                      onRefresh: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        await sl<UsersCubit>().fetchUsersList(
                          loadMore: false,
                        );
                        refreshController.refreshCompleted();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: AlignedGridView.count(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          itemCount: state.listOwner!.length,
                          itemBuilder: (context, index) {
                            final user = state.listOwner![index];
                            return UsersItemCard(user: user);
                          },
                        ),
                      ))
                  : const SingleChildScrollView(
                      child: NotFoundWidget(
                          image: 'assets/icons/tracking_not_found.png',
                          title: 'Gagal Ambil Data',
                          subtitle: 'Silahkan Coba Lagi Nanti'),
                    );
            }
          },
        ),
      ),
    );
  }
}
