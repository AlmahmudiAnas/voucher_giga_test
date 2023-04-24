import 'package:hive_flutter/hive_flutter.dart';
import 'package:voucher_giga/Model/voucher_model.dart';

class VoucherAdapter extends TypeAdapter<Voucher> {
  final int typeid = 2;
  @override
  Voucher read(BinaryReader reader) {
    final Map<dynamic, dynamic> fields = reader.readMap();
    return Voucher(
      name: fields['name'] as String,
      validity: fields['validity'] as String,
      cost: fields['cost'] as String,
      downloadSpeed: fields['download_speed'] as String,
      uploadSpeed: fields['upload_speed'] as String,
      quotaLimit: fields['quota_limit'] as String,
      id: fields['id'] as int,
    );
  }

  @override
  // TODO: implement typeId
  int get typeId => typeid;

  @override
  void write(BinaryWriter writer, Voucher voucher) {
    writer.writeMap({
      'id': voucher.id,
      'name': voucher.name,
      'cost': voucher.cost,
      'validity': voucher.validity,
      'download_speed': voucher.downloadSpeed,
      'upload_speed': voucher.uploadSpeed,
      'quota_limit': voucher.quotaLimit,
    });
  }
}
