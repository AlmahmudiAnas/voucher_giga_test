import 'package:hive/hive.dart';
import 'package:voucher_giga/Model/user_model.dart';

class UserAdapter extends TypeAdapter<User> {
  final int typeid = 1;

  @override
  User read(BinaryReader reader) {
    final Map<dynamic, dynamic> fields = reader.readMap();
    return User(
      name: fields['name'] as String,
      email: fields['email'] as String,
      id: fields['id'] as int,
      balance: fields['balance'] as String,
      token: fields['token'] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User user) {
    writer.writeMap({
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'token': user.token,
    });
  }

  @override
  // TODO: implement typeId
  int get typeId => typeid;
}
