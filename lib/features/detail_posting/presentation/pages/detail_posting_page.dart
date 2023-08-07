import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/data_posting_model.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/owner_model.dart';
import 'package:kazokku_technical_test/features/detail_profile/presentation/cubit/detail_profile_cubit.dart';
import 'package:kazokku_technical_test/features/explorer/presentation/cubit/explorer_cubit.dart';

import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../../../detail_profile/presentation/widgets/comment_item.dart';
import '../../../detail_profile/presentation/widgets/name_caption_items.dart';
import '../../../detail_profile/presentation/pages/detail_profile_page.dart';
import '../../../detail_profile/presentation/pages/heart_animating_widget.dart';
import '../cubit/detail_posting_cubit.dart';

class DetailPostingPage extends StatefulWidget {
  final DataPostingModel? dataIndex;
  final Owner? userDataModel;
  final DetailProfileState? states;
  final ExplorerState? statesListDataExplorerModel;
  final int? index;
  final int? indexDataExplorer;
  final bool? navToProfile;

  const DetailPostingPage({
    super.key,
    this.dataIndex,
    this.userDataModel,
    this.states,
    this.statesListDataExplorerModel,
    this.index,
    this.indexDataExplorer,
    this.navToProfile,
  });

  @override
  State<DetailPostingPage> createState() => _DetailPostingPageState();
}

class _DetailPostingPageState extends State<DetailPostingPage> {
  PageController pageController = PageController();

  // bool isLiked = false;
  bool isHeartAnimating = false;

  @override
  void initState() {
    super.initState();

    pageController = PageController(
        initialPage:
            widget.index != null ? widget.index! : widget.indexDataExplorer!);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollToIndex(
    //       widget.index != null ? widget.index! : widget.indexDataExplorer!);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.dataIndex!.isLike == true
        ? Icons.favorite
        : Icons.favorite_outline;
    final color = widget.dataIndex!.isLike == true ? Colors.red : Colors.white;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: widget.navToProfile == null || widget.navToProfile == false
            ? AppBar(
                elevation: 0.0,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Column(
                  children: [
                    Text(
                      widget.userDataModel!.firstName!,
                      style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      "Posting",
                      style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            : AppBar(
                elevation: 0.0,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Container(),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
        extendBodyBehindAppBar: true,
        body: PageView.builder(

            //disable swipe
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: pageController,
            itemCount: widget.states != null
                ? widget.states!.listDataPostingModel!.length
                : widget
                    .statesListDataExplorerModel!.listDataExplorerModel!.length,
            itemBuilder: (context, index) {
              return Center(
                child: GestureDetector(
                  onDoubleTap: () {
                    saveLikePosting(widget.states != null
                        ? widget.states!.listDataPostingModel![index].id!
                        : widget.statesListDataExplorerModel!
                            .listDataExplorerModel![index].id!);
                    setState(() {
                      isHeartAnimating = true;
                      widget.dataIndex!.isLike = true;
                    });
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            image: NetworkImage(widget.states != null
                                ? widget
                                    .states!.listDataPostingModel![index].image!
                                : widget.statesListDataExplorerModel!
                                    .listDataExplorerModel![index].image!),
                            fit: BoxFit.cover,
                          ),
                          //icon love
                          Opacity(
                            opacity: isHeartAnimating ? 1 : 0,
                            child: HeartAnimatingWidget(
                              onEnd: () {
                                setState(() {
                                  isHeartAnimating = false;
                                });
                              },
                              duration: const Duration(milliseconds: 0),
                              isAnimating: isHeartAnimating,
                              child: Icon(
                                Icons.favorite,
                                color: AppColors.white,
                                size: 100.sp,
                              ),
                            ),
                          ),
                        ],
                      ),

                      ///left
                      NameCaptionItems(
                        index: index,
                        states: widget.states,
                        statesListDataExplorerModel:
                            widget.statesListDataExplorerModel,
                      ),

                      ///right
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        alignment: const Alignment(1, 1),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w, bottom: 50.h),
                          child: Container(
                            color: Colors.transparent,
                            height: 200.h,
                            width: 250.w,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //back
                                        widget.navToProfile == false ||
                                                widget.navToProfile == null
                                            ? Navigator.pop(context)
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailProfilePage(
                                                    userDataModel: widget
                                                        .statesListDataExplorerModel!
                                                        .listDataExplorerModel![
                                                            index]
                                                        .owner,
                                                  ),
                                                ),
                                              );
                                      },
                                      child: Container(
                                        height: 45.h,
                                        width: 45.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.white,
                                            width: 1,
                                          ),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              widget.states != null
                                                  ? widget
                                                      .states!
                                                      .listDataPostingModel![
                                                          index]
                                                      .owner!
                                                      .picture!
                                                  : widget
                                                      .statesListDataExplorerModel!
                                                      .listDataExplorerModel![
                                                          index]
                                                      .owner!
                                                      .picture!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 15.h),
                                    //iconlove
                                    HeartAnimatingWidget(
                                      alwaysAnimate: true,
                                      isAnimating: widget.dataIndex!.isLike,
                                      child: InkWell(
                                        onTap: () {
                                          widget.dataIndex!.isLike == false
                                              ? saveLikePosting(widget.states !=
                                                      null
                                                  ? widget
                                                      .states!
                                                      .listDataPostingModel![
                                                          index]
                                                      .id!
                                                  : widget
                                                      .statesListDataExplorerModel!
                                                      .listDataExplorerModel![
                                                          index]
                                                      .id!)
                                              : deleteLikePosting(widget
                                                          .states !=
                                                      null
                                                  ? widget
                                                      .states!
                                                      .listDataPostingModel![
                                                          index]
                                                      .id!
                                                  : widget
                                                      .statesListDataExplorerModel!
                                                      .listDataExplorerModel![
                                                          index]
                                                      .id!);
                                          setState(() {
                                            widget.dataIndex!.isLike =
                                                !widget.dataIndex!.isLike!;

                                            // saveLikePosting(widget.states != null
                                            //     ? widget
                                            //     .states!
                                            //     .listDataPostingModel![index]
                                            //     .id!
                                            //     : widget
                                            //     .statesListDataExplorerModel!
                                            //     .listDataExplorerModel![index]
                                            //     .id!);
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              icon,
                                              color: color,
                                              size: 30.sp,
                                            ),
                                            SizedBox(width: 5.w),
                                            widget.states != null
                                                ? widget.dataIndex!.isLike ==
                                                        true
                                                    ? Text(
                                                        (widget
                                                                    .states!
                                                                    .listDataPostingModel![
                                                                        index]
                                                                    .likes! +
                                                                1)
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .robotoMono(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16.sp,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      )
                                                    : Text(
                                                        widget
                                                            .states!
                                                            .listDataPostingModel![
                                                                index]
                                                            .likes
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .robotoMono(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16.sp,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      )
                                                : widget.dataIndex!.isLike ==
                                                        true
                                                    ? Text(
                                                        (widget
                                                                    .statesListDataExplorerModel!
                                                                    .listDataExplorerModel![
                                                                        index]
                                                                    .likes! +
                                                                1)
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .robotoMono(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16.sp,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      )
                                                    : Text(
                                                        widget
                                                            .statesListDataExplorerModel!
                                                            .listDataExplorerModel![
                                                                index]
                                                            .likes
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .robotoMono(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16.sp,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      )
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 15.h),

                                    //iconcomment
                                    CommentItem(
                                      index: index,
                                      states: widget.states,
                                      statesListDataExplorerModel:
                                          widget.statesListDataExplorerModel,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  void saveLikePosting(String idPosting) async {
    await sl<DetailPostingCubit>().saveLikePosting(idPosting);
  }

  deleteLikePosting(String idPosting) {
    sl<DetailPostingCubit>().deleteLikePosting(idPosting);
  }
}

class HeartLikeWidget extends StatefulWidget {
  final Color? color;
  final IconData? icon;
  final DetailProfileState? states;
  final ExplorerState? statesListDataExplorerModel;
  final int? index;
  final bool? isLiked;

  const HeartLikeWidget({
    super.key,
    this.icon,
    this.color,
    this.states,
    this.statesListDataExplorerModel,
    this.index,
    this.isLiked = false,
  });

  @override
  State<HeartLikeWidget> createState() => _HeartLikeWidgetState();
}

class _HeartLikeWidgetState extends State<HeartLikeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          // widget.isLiked = widget.!isLiked;
          // this.isLiked = !widget.isLiked!;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            widget.icon,
            color: widget.color,
            size: 30.sp,
          ),
          SizedBox(width: 5.w),
          widget.states != null
              ? widget.isLiked == true
                  ? Text(
                      (widget.states!.listDataPostingModel![widget.index!]
                                  .likes! +
                              1)
                          .toString(),
                      style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    )
                  : Text(
                      widget.states!.listDataPostingModel![widget.index!].likes
                          .toString(),
                      style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    )
              : widget.isLiked == true
                  ? Text(
                      (widget
                                  .statesListDataExplorerModel!
                                  .listDataExplorerModel![widget.index!]
                                  .likes! +
                              1)
                          .toString(),
                      style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    )
                  : Text(
                      widget.statesListDataExplorerModel!
                          .listDataExplorerModel![widget.index!].likes
                          .toString(),
                      style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    )
        ],
      ),
    );
  }
}
