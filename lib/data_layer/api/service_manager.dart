import 'package:dio/dio.dart';
import 'package:hf/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceManager {
  late Dio dio;

  ServiceManager() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<String> getToken({bool getNewToken = false}) async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    if (getNewToken) {
      try {
        var formData = FormData.fromMap({
          'secret_key':
              '5b330853eada79529bf3da09bc51fd251e8d8d217a296c34fde3bb665d51b31c86325c908ae36d7401c699bf1ce6d36be616b04148e5ae3d3560e26e32423737',
        });

        Response response = await dio.post(
          'login',
          data: formData,
        );
        final cleanToken = response.data
            .toString()
            .replaceAll(RegExp(",|!|'|token:|{|}| "), '');
        await _storage.setString(userToken, cleanToken);
        return cleanToken;
      } catch (e) {
        return "";
      }
    } else {
      final String? savedToken = _storage.getString(userToken);
      return savedToken!;
    }
  }
}
