import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../constant.dart';

@singleton
class ApiManager {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Constant.baseUrl,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<dynamic> getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token, // ✅ دعم التوكن
  }) async {
    try {
      Response response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  Future<Response> postRequest({
    required String endPoint,
    required Map<String, dynamic> body,
    bool isFormData = false,
    List<XFile>? images,  // إضافة متغير images لتحمل صور متعددة
    String? token,  // ✅ دعم التوكن
  }) async {
    try {
      dynamic dataToSend = body;

      // إذا كانت البيانات تحتاج إلى أن تكون في شكل form-data
      if (isFormData) {
        // إضافة الصور إلى FormData
        FormData formData = FormData();

        // أضف البيانات الأخرى إلى FormData
        body.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });

        // أضف الصور إلى FormData
        if (images != null) {
          for (var image in images) {
            String fileName = image.path.split('/').last;
            formData.files.add(MapEntry(
              'files',  // اسم الحقل في الـ API
              await MultipartFile.fromFile(image.path, filename: fileName),
            ));
          }
        }

        // إرسال البيانات
        dataToSend = formData;
      }

      Response response = await dio.post(
        endPoint,
        data: dataToSend,
        options: Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
          contentType: isFormData ? "multipart/form-data" : null,
        ),
      );

      return response;
    } catch (error) {
      throw Exception('Post request error: $error');
    }
  }

  Future<Response> putRequest({
    required String endPoint,
    Map<String, dynamic>? body,
    bool isFormData = false,
    String? token, // ✅ دعم التوكن
  }) async {
    try {
      dynamic dataToSend = body;

      if (isFormData && body != null) {
        dataToSend = FormData.fromMap(body);
      }

      Response response = await dio.put(
        endPoint,
        data: dataToSend,
        options: Options(
          headers: token != null ? {'Authorization': 'Bearer $token'} : null,
          contentType: isFormData ? "multipart/form-data" : null,
        ),
      );

      return response;
    } catch (error) {
      throw Exception('Put request error: $error');
    }
  }


  Future<Response> uploadImageWithToken({
    required String endPoint,
    required XFile imageFile,
    required String token,
  }) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        'File': await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      Response response = await dio.post(
        endPoint,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return response;
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

}
