import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:photo_sender/api_statuses/api_failure.dart';
import 'package:photo_sender/api_statuses/api_success.dart';
import 'package:photo_sender/utils/constants.dart';
import 'package:path/path.dart' as p;
import 'package:photo_sender/utils/language_util.dart';

class ImageUploadDatasource {

  Future<Object> uploadImage({required String photoPath, required String comment, required Position position}) async {
    final dio = Dio();
    dio.options.headers['Content-Type'] = 'application/javascript';

    String url = '${Constants.baseUrl}${Constants.uploadPhotoPath}';

    FormData formData = FormData.fromMap({
      "comment": comment,
      "latitude": position.latitude,
      "longitude": position.longitude,
      "photo":
      await MultipartFile.fromFile(photoPath, filename: p.basename(photoPath)),
    });
    try {
      await dio.post(url, data: formData);
      return ApiSuccess();
    } on DioException catch (e) {
      if (e.response?.statusCode != null) {
        //if response status code != 200
        int? statusCode = e.response!.statusCode;
        String message = e.message ?? LanguageUtil.unknownError;
        throw ApiFailure(code: statusCode, errorResponse: message);
      } else {
        String message = e.message ?? LanguageUtil.unknownError;
        throw ApiFailure(errorResponse: message);
      }
    } catch (e) {
      throw ApiFailure(errorResponse: e.toString());
    }
  }
}