import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kazokku_technical_test/features/explorer/presentation/cubit/explorer_cubit.dart';

import '../../../../resources/colors.dart';
import '../cubit/detail_profile_cubit.dart';
import '../pages/detail_profile_page.dart';
import 'comment_item.dart';

class ImageLikeItems extends StatefulWidget {
  final int? index;
  final DetailProfileState? states;
  final ExplorerState? statesListDataExplorerModel;
  final bool? navToProfile;
  final bool? isLiked;

  const ImageLikeItems({
    super.key,
    this.index,
    this.states,
    this.statesListDataExplorerModel,
    this.navToProfile,
    this.isLiked,
  });

  @override
  State<ImageLikeItems> createState() => _ImageLikeItemsState();
}

class _ImageLikeItemsState extends State<ImageLikeItems> {
  @override
  Widget build(BuildContext context) {
    final icon = widget.isLiked == true ? Icons.favorite : Icons.favorite;
    final color = widget.isLiked == true ? Colors.red : Colors.white;
    return Container(
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
                      widget.navToProfile == false || widget.navToProfile == null
                          ? Navigator.pop(context)
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailProfilePage(
                                  userDataModel: widget.statesListDataExplorerModel!
                                      .listDataExplorerModel![widget.index!].owner,
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
                                ? widget.states!.listDataPostingModel![widget.index!].owner!
                                    .picture!
                                : widget.statesListDataExplorerModel!
                                    .listDataExplorerModel![widget.index!]
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        // widget.isLiked == true
                        //     ? widget.states != null
                        //         ? widget.states!.listDataPostingModel![widget.index!].likes--
                        //         : widget.statesListDataExplorerModel!
                        //             .listDataExplorerModel![widget.index!].likes--
                        //     : widget.states != null
                        //         ? widget.states!.listDataPostingModel![widget.index!].likes++
                        //         : widget.statesListDataExplorerModel!
                        //             .listDataExplorerModel![widget.index!].likes++;
                        // widget.isLiked = !widget.isLiked!;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          icon,
                          color: color,
                          size: 30.sp,
                        ),
                        SizedBox(width: 5.w),
                        widget.states != null
                            ? Text(
                                widget.states!.listDataPostingModel![widget.index!].likes
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
                  ),

                  SizedBox(height: 15.h),

                  //iconcomment
                  CommentItem(
                    index: widget.index,
                    states: widget.states,
                    statesListDataExplorerModel: widget.statesListDataExplorerModel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
