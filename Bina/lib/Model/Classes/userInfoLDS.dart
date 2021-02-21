import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SavingData {
// LStorage
  final lStorage = FlutterSecureStorage();

  // Saving data in local storage
  Future<bool> LDS({
    userId,
    username,
    avatar,
    fullname,
    phone,
    address,
    province_ar,
    province_ku,
  }) async {
    Map<String, dynamic> staffInfo = {
      "userId": userId,
      "username": username,
      "avatar": avatar,
      "fullname": fullname,
      "phone": phone,
      "address": address,
      "province_ar": province_ar,
      "province_ku": province_ku,
    };
    staffInfo.forEach((key, value) async {
      await lStorage.write(key: key, value: value);
    });
    String uId = await lStorage.read(key: "userId");
    return uId != null ? true : false;
  }
}
