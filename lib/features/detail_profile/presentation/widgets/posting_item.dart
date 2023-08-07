import 'package:flutter/material.dart';
import 'package:kazokku_technical_test/features/detail_profile/presentation/cubit/detail_profile_cubit.dart';

import '../../domain/datas/models/data_posting_model.dart';
import '../../domain/datas/models/owner_model.dart';
import '../../../detail_posting/presentation/pages/detail_posting_page.dart';

class PostingItem extends StatelessWidget {
  final DataPostingModel? dataIndex;
  final Owner? userDataModel;
  final DetailProfileState? states;

  const PostingItem({
    super.key,
    this.dataIndex,
    this.userDataModel,
    this.states,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPostingPage(
              dataIndex: dataIndex,
              userDataModel: userDataModel,
              states: states,
              index: states!.listDataPostingModel!.indexOf(dataIndex!),
            ),
          ),
        );
      },
      child: Image(
        image: NetworkImage(dataIndex!.image!, scale: 1),
        fit: BoxFit.cover,
      ),
    );
  }
}
