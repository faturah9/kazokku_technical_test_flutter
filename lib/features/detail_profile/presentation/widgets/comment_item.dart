import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kazokku_technical_test/features/explorer/presentation/cubit/explorer_cubit.dart';
import 'package:kazokku_technical_test/widgets/string_casing_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../cubit/comment_cubit.dart';
import '../cubit/detail_profile_cubit.dart';

class CommentItem extends StatefulWidget {
  final int? index;
  final DetailProfileState? states;
  final ExplorerState? statesListDataExplorerModel;

  const CommentItem({
    super.key,
    this.index,
    this.states, this.statesListDataExplorerModel,
  });

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  void initState() {
    super.initState();
    getComment();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            //show modal bottom sheet
            onTabShowBottomSheet(state, context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.comment,
                color: AppColors.white,
                size: 30.sp,
              ),
              SizedBox(width: 5.w),
              state is CommentLoading
                  ? Text(
                '0',
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
              )
                  : state.listDataCommentModel!.isNotEmpty
                  ? Text(
                state.listDataCommentModel!.length.toString(),
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
              )
                  : Text(
                '0',
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.white,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> getComment() async {
    widget.states != null ? await sl<CommentCubit>().fetchComment(
      widget.states!.listDataPostingModel![widget.index!].id!,
    ) : await sl<CommentCubit>().fetchComment(
      widget.statesListDataExplorerModel!.listDataExplorerModel![widget.index!]
          .id!,
    );
  }

  Future<dynamic> onTabShowBottomSheet(CommentState state,
      BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builderCtx) {
        return Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.5,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 8.w, right: 8.w),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                color: Colors.transparent,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  height: 8.h,
                                  width: 50.w,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/icon_close.svg',
                                      height: 26.h,
                                      width: 26.w,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    state.listDataCommentModel!.length
                                        .toString(),
                                    style: GoogleFonts.robotoMono(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp,
                                      color: AppColors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Comment',
                                    style: GoogleFonts.robotoMono(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp,
                                      color: AppColors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SizedBox(
                        child: Container(
                          color: Colors.transparent,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.listDataCommentModel!.length,
                            itemBuilder: (context, index) {
                              return state.listDataCommentModel!.isNotEmpty
                                  ? ListTile(
                                leading: CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage: NetworkImage(
                                    state.listDataCommentModel![index]
                                        .owner!.picture!,
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      '${state.listDataCommentModel![index]
                                          .owner!.title!.toCapitalized()}.',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.robotoMono(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: AppColors.black
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      state.listDataCommentModel![index]
                                          .owner!.firstName!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.robotoMono(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: AppColors.black
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    SizedBox(width: 3.w),
                                    Flexible(
                                      child: Text(
                                        state.listDataCommentModel![index]
                                            .owner!.lastName!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.robotoMono(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          color: AppColors.black
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      state.listDataCommentModel![index]
                                          .message!,
                                      style: GoogleFonts.robotoMono(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    //date
                                    Text(
                                      formatDate(
                                        state.listDataCommentModel![index]
                                            .publishDate!,
                                      ),
                                      style: GoogleFonts.robotoMono(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14.sp,
                                        color: AppColors.black
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  : Center(
                                child: Text(
                                  'No Comment',
                                  style: GoogleFonts.robotoMono(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: AppColors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
