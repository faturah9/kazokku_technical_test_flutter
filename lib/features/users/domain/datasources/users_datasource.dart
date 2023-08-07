import 'package:kazokku_technical_test/features/users/domain/datas/models/users_model.dart';

abstract class UsersDatasource {
  Future<UsersModel> setUserParticipant(Map<String, dynamic> params);
}