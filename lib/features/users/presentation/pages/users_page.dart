import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kazokku_technical_test/features/users/presentation/cubit/users_cubit.dart';

import '../../../../injection_container.dart';
import '../../../../resources/colors.dart';
import '../widgets/users_list_widget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    getDataUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Users',
          style: GoogleFonts.robotoMono(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontSize: 26.sp,
          ),
        ),
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: const UsersListWidget(),
    );
  }

  Future<void> getDataUsers() async {
    return await sl<UsersCubit>().fetchUsersList();
  }
}
