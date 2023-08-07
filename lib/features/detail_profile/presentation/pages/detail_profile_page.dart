import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../resources/colors.dart';
import '../../../../widgets/search_widget.dart';
import '../../domain/datas/models/owner_model.dart';
import '../widgets/header_detail_profile.dart';
import '../widgets/posting_detail_profile.dart';

class DetailProfilePage extends StatefulWidget {
  final Owner? userDataModel;

  const DetailProfilePage({
    super.key,
    this.userDataModel,
  });

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  String? query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            title: Padding(
              padding: EdgeInsets.only(top: 9.h),
              child: SearchWidget(
                text: query,
                hintText:
                    'Search in ${widget.userDataModel!.firstName!}\'s posts',
                onChanged: searchGift,
                controller: TextEditingController(),
                userDataModel: widget.userDataModel,
              ),
            ),
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              HeaderDetailProfile(widget.userDataModel!),
              SizedBox(
                height: 20.h,
              ),
              PostingDetailProfile(widget.userDataModel!),
            ],
            // ),
          ),
        ),
      ),
    );
  }

  void searchGift(String value) {
    setState(() {
      query = value;
    });
  }
}
