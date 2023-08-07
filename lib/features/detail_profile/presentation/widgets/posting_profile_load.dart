import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PostingProfileLoad extends StatelessWidget {
  const PostingProfileLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          childAspectRatio: 1,
          crossAxisSpacing: 0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: SizedBox(
              height: 80.h,
              width: 80.w,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
