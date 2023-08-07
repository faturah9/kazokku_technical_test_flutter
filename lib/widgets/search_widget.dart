import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../features/detail_profile/domain/datas/models/owner_model.dart';
import '../features/detail_profile/presentation/cubit/detail_profile_cubit.dart';
import '../features/explorer/presentation/cubit/explorer_cubit.dart';
import '../injection_container.dart';
import '../resources/colors.dart';

class SearchWidget extends StatefulWidget {
  final String? text;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final TextEditingController? controller;
  final Owner? userDataModel;

  const SearchWidget({
    Key? key,
    this.hintText,
    this.onChanged,
    this.text,
    this.controller,
    this.userDataModel,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setState(() {
      _controller.text = widget.text!;
    });
    final styleActive = GoogleFonts.lato(
        fontWeight: FontWeight.w400, color: AppColors.black, fontSize: 14.sp);
    final styleHint = GoogleFonts.lato(
        fontWeight: FontWeight.w400,
        color: AppColors.black.withOpacity(0.5),
        fontSize: 14.sp);
    final style = widget.text!.isEmpty ? styleHint : styleActive;
    return Container(
      height: 42.h,
      margin: EdgeInsets.only(
        top: 10.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.black.withOpacity(0.3),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: TextFormField(
        controller: _controller,
        onFieldSubmitted: (value) async {
          await fetchSearch(value);

          setState(() {
            _controller.text = value;
          });
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
          icon: const Icon(
            Icons.search,
            color: AppColors.black,
          ),
          suffixIcon: widget.text!.isNotEmpty
              ? GestureDetector(
                  child: const Icon(
                    Icons.close,
                    color: AppColors.black,
                  ),
                  onTap: () {
                    _controller.clear();
                    widget.onChanged!('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
        ),
      ),
    );
  }

  Future<void> fetchSearch(String value) async {
    return widget.userDataModel != null
        ? await sl<DetailProfileCubit>().fetchPostingUser(
            idUser: widget.userDataModel!.id!, stringSearch: value)
        : await sl<ExplorerCubit>().fetchExplorer(stringSearch: value);
  }
}
