import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../resources/colors.dart';
import '../widgets/likes_list.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({super.key});

  @override
  State<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Likes',
          style: GoogleFonts.robotoMono(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontSize: 26.sp,
          ),
        ),
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: const LikesList(),
    );

  }
}
