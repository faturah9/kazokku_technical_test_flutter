
import '../../../detail_profile/domain/datas/models/owner_model.dart';

abstract class UsersRepository {
  Future<List<Owner>> fetchUsers(Map<String, dynamic> params);
}