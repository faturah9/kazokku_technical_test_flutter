import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kazokku_technical_test/widgets/string_casing_extension.dart';

import '../../../../resources/colors.dart';
import '../../../detail_profile/domain/datas/models/owner_model.dart';
import '../../../detail_profile/presentation/pages/detail_profile_page.dart';

class UsersItemCard extends StatelessWidget {
  final Owner user;

  const UsersItemCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProfilePage(
              userDataModel: user,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.network(
                        user.picture!,
                        height: 80.h,
                        width: 80.w,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return SvgPicture.asset(
                            'assets/icons/icon_error.svg',
                            height: 12.h,
                            width: 12.w,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '${user.title!.toCapitalized()}.',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.robotoMono(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          user.firstName!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.robotoMono(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Flexible(
                          child: Text(
                            user.lastName!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.robotoMono(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    user.id!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.robotoMono(
                      fontSize: 12.sp,
                      color: AppColors.black.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
