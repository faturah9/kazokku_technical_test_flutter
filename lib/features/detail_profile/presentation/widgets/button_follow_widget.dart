import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../../domain/datas/models/detail_profile_model.dart';
import '../cubit/detail_profile_cubit.dart';

class ButtonFollowWidget extends StatefulWidget {
  final DetailProfileModel? detailProfileModel;

  const ButtonFollowWidget({
    super.key,
    this.detailProfileModel,
  });

  @override
  State<ButtonFollowWidget> createState() => _ButtonFollowWidgetState();
}

class _ButtonFollowWidgetState extends State<ButtonFollowWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProfileCubit, DetailProfileState>(
      buildWhen: (previous, current) =>
          previous.detailProfileModel != current.detailProfileModel,
      builder: (context, state) {
        if (state is DetailProfileLoading || state is PostingProfileLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          );
        } else {
          return state.detailProfileModel!.isFollow == false
              ? InkWell(
                  onTap: () {
                    followUser(widget.detailProfileModel!.id!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppColors.deepSkyBlue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.person_add,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: 3.h,
                          ),
                          Text(
                            'Follow',
                            style: GoogleFonts.robotoMono(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    followUser(widget.detailProfileModel!.id!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.grey,
                        ),
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.person_pin_circle_outlined,
                            color: AppColors.grey,
                          ),
                          SizedBox(
                            width: 3.h,
                          ),
                          Text(
                            'Unfollow',
                            style: GoogleFonts.robotoMono(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        }
      },
    );
  }

  Future<void> followUser(String idUser) async {
    return await sl<DetailProfileCubit>().followUser(idUser);
  }
}
