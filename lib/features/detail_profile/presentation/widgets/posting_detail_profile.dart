import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazokku_technical_test/features/detail_profile/presentation/widgets/posting_item.dart';
import 'package:kazokku_technical_test/features/detail_profile/presentation/widgets/posting_profile_load.dart';

import '../../../../injection_container.dart';
import '../../domain/datas/models/owner_model.dart';
import '../cubit/detail_profile_cubit.dart';

class PostingDetailProfile extends StatefulWidget {
  final Owner? userDataModel;

  const PostingDetailProfile(this.userDataModel, {super.key});

  @override
  State<PostingDetailProfile> createState() => _PostingDetailProfileState();
}

class _PostingDetailProfileState extends State<PostingDetailProfile> {
  @override
  void initState() {
    super.initState();
    getPostingUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProfileCubit, DetailProfileState>(
      buildWhen: (previous, current) =>
          previous.listDataPostingModel != current.listDataPostingModel,
      builder: (context, state) {
        if (state is PostingProfileLoading || state is DetailProfileLoading) {
          return const PostingProfileLoad();
        } else {
          return state.listDataPostingModel != null &&
                  state.listDataPostingModel!.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.listDataPostingModel!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 0,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    final dataIndex = state.listDataPostingModel![index];
                    return PostingItem(
                      dataIndex: dataIndex,
                      userDataModel: widget.userDataModel,
                      states: state,
                    );
                  },
                )
              : const Center(
                  child: Text('don\'t have post'),
                );
        }
      },
    );
  }

  Future<void> getPostingUserProfile() async {
    return await sl<DetailProfileCubit>()
        .fetchPostingUser(idUser: widget.userDataModel!.id!);
  }
}
