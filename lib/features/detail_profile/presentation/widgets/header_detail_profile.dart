import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazokku_technical_test/features/detail_profile/domain/datas/models/post_like_model.dart';
import 'package:kazokku_technical_test/features/detail_profile/presentation/cubit/detail_profile_cubit.dart';

import '../../../../injection_container.dart';
import '../../domain/datas/models/owner_model.dart';
import 'detail_item_profile.dart';
import 'detail_profile_load.dart';

class HeaderDetailProfile extends StatefulWidget {
  final Owner? userDataModel;

  const HeaderDetailProfile(
    this.userDataModel, {
    super.key,
  });

  @override
  State<HeaderDetailProfile> createState() => _HeaderDetailProfileState();
}

class _HeaderDetailProfileState extends State<HeaderDetailProfile> {
  @override
  void initState() {
    super.initState();
    getDataProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProfileCubit, DetailProfileState>(
      buildWhen: (previous, current) =>
          previous.detailProfileModel != current.detailProfileModel,
      builder: (context, state) {
        if (state is DetailProfileLoading) {
          return const DetailProfileLoad();
        } else {
          return state.detailProfileModel != null
              ? DetailItemProfile(state.detailProfileModel!)
              : const Center(
                  child: Text(''),
                );
        }
      },
    );
  }

  Future<void> getDataProfile() async {
    return await sl<DetailProfileCubit>()
        .fetchDetailUser(widget.userDataModel!.id!);
  }
}
