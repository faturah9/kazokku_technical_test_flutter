import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../injection_container.dart';
import '../../../detail_posting/presentation/pages/detail_posting_page.dart';
import '../../../explorer/presentation/cubit/explorer_cubit.dart';

class LikesList extends StatefulWidget {
  const LikesList({super.key});

  @override
  State<LikesList> createState() => _LikesListState();
}

class _LikesListState extends State<LikesList> {
  @override
  void initState() {
    super.initState();
    fetchLikes();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExplorerCubit, ExplorerState>(
      builder: (context, state) {
        if (state is LikesLoading) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                childAspectRatio: 1,
                crossAxisSpacing: 0),
            itemBuilder: (context, index) {
              return Container(
                height: 100.h,
                width: 100.w,
                color: Colors.grey[300]!,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        } else {
          return state.listDataExplorerModel!.isNotEmpty
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
                    await Future.delayed(const Duration(milliseconds: 1000));
                    await sl<ExplorerCubit>().fetchLikes(
                      loadMore: true,
                    );
                    refreshController.loadComplete();
                  },
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 1000));
                    await sl<ExplorerCubit>().fetchLikes(
                      loadMore: false,
                    );
                    refreshController.refreshCompleted();
                  },
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.listDataExplorerModel!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 0,
                            childAspectRatio: 1,
                            crossAxisSpacing: 0),
                    itemBuilder: (context, index) {
                      final dataIndex = state.listDataExplorerModel![index];
                      final dataUserIndex = dataIndex.owner;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPostingPage(
                                dataIndex: dataIndex,
                                userDataModel: dataUserIndex,
                                statesListDataExplorerModel: state,
                                indexDataExplorer:
                                    state.listDataExplorerModel!.indexOf(
                                  dataIndex,
                                ),
                                navToProfile: true,
                              ),
                            ),
                          );
                        },
                        child: Image(
                          image: NetworkImage(dataIndex.image!),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text('No data'),
                );
        }
      },
    );
  }

  Future<void> fetchLikes() async {
    return await sl<ExplorerCubit>().fetchLikes();
  }
}
