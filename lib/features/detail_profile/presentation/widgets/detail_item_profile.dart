import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kazokku_technical_test/features/detail_profile/presentation/cubit/detail_profile_cubit.dart';
import 'package:kazokku_technical_test/widgets/string_casing_extension.dart';

import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../../domain/datas/models/detail_profile_model.dart';
import 'button_follow_widget.dart';

class DetailItemProfile extends StatelessWidget {
  final DetailProfileModel? detailProfileModel;

  const DetailItemProfile(
    this.detailProfileModel, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        children: [
          //image center
          Container(
            height: 130.h,
            width: 130.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  detailProfileModel!.picture!,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${detailProfileModel!.title!.toCapitalized()}. ${detailProfileModel!.firstName!} ${detailProfileModel!.lastName!}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.black,
                ),
              ),
              detailProfileModel!.gender == 'female'
                  ? const Icon(
                      Icons.female,
                      color: AppColors.pink,
                    )
                  : const Icon(
                      Icons.male,
                      color: AppColors.deepSkyBlue,
                    ),
            ],
          ),
          //birthday
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatDate(detailProfileModel!.dateOfBirth!),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.black,
                ),
              ),
              const Icon(
                Icons.cake,
                color: AppColors.orange,
              )
            ],
          ),
          //phone
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                detailProfileModel!.phone!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.black,
                ),
              ),
              const Icon(
                Icons.phone,
                color: AppColors.green,
              )
            ],
          ),
          //email
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                detailProfileModel!.email!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.black,
                ),
              ),
              const Icon(
                Icons.email,
                color: AppColors.red,
              )
            ],
          ),
          //address
          Text(
            '${detailProfileModel!.location!.country}, ${detailProfileModel!.location!.state},',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.robotoMono(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.black,
            ),
          ),
          Text(
            '${detailProfileModel!.location!.city}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.robotoMono(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ' ${detailProfileModel!.location!.street!}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.robotoMono(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(
                Icons.location_on,
                color: AppColors.red,
              ),
            ],
          ),
          //join date
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatDate(detailProfileModel!.registerDate!),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.robotoMono(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.black,
                ),
              ),
              const Icon(
                Icons.calendar_month_outlined,
                color: AppColors.deepSkyBlue,
              ),
            ],
          ),

          SizedBox(
            height: 10.h,
          ),
          //button follow
          ButtonFollowWidget(
            detailProfileModel: detailProfileModel,
          ),
        ],
      ),
    );
  }
}
