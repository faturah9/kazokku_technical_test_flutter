import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../resources/colors.dart';
import '../../../../widgets/search_widget.dart';
import '../widgets/explorer_list.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({super.key});

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  String? query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title:
            // Text(
            //   'Explorer',
            //   style: GoogleFonts.robotoMono(
            //     fontWeight: FontWeight.w500,
            //     color: AppColors.black,
            //     fontSize: 26.sp,
            //   ),
            // ),
            Padding(
          padding: EdgeInsets.only(top: 9.h),
          child: SearchWidget(
            text: query,
            hintText: 'Search...',
            onChanged: searchGift,
            controller: TextEditingController(),
          ),
        ),
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: const ExplorerList(),
    );
  }
  void searchGift(String value) {
    setState(() {
      query = value;
    });
  }
}
