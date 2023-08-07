import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kazokku_technical_test/features/explorer/presentation/cubit/explorer_cubit.dart';
import 'package:kazokku_technical_test/widgets/string_casing_extension.dart';

import '../../../../resources/colors.dart';
import '../cubit/detail_profile_cubit.dart';

class NameCaptionItems extends StatelessWidget {
  final int? index;
  final DetailProfileState? states;
  final ExplorerState? statesListDataExplorerModel;

  const NameCaptionItems({
    super.key,
    this.index,
    this.states,
    this.statesListDataExplorerModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      alignment: const Alignment(-1, 1),
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, bottom: 50.h),
        child: Container(
          color: Colors.transparent,
          height: 200.h,
          width: 250.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  states !=null ?
                  Text(
                    '${states!.listDataPostingModel![index!].owner!.title!.toCapitalized()}.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.robotoMono(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ) : Text(
                    '${statesListDataExplorerModel!.listDataExplorerModel![index!].owner!.title!.toCapitalized()}.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.robotoMono(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  states != null ?
                  Text(
                    states!.listDataPostingModel![index!].owner!.firstName!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.robotoMono(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ) : Text(
                    statesListDataExplorerModel!.listDataExplorerModel![index!].owner!.firstName!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.robotoMono(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  states != null ? Flexible(
                    child: Text(
                      states!.listDataPostingModel![index!].owner!.lastName!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ) : Flexible(
                    child: Text(
                      statesListDataExplorerModel!.listDataExplorerModel![index!].owner!.lastName!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.robotoMono(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // caption
              states != null ? Text(
                states!.listDataPostingModel![index!].text!,
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w300,
                  color: AppColors.white,
                  fontSize: 16.sp,
                ),
              ) : Text(
                statesListDataExplorerModel!.listDataExplorerModel![index!].text!,
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w300,
                  color: AppColors.white,
                  fontSize: 16.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
