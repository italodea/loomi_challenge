import 'dart:io';

import 'package:flutter/foundation.dart';

class FileUtil {
  static Future<File> downloadFile(String url) async {
    final httpClient = HttpClient();
    final request = await httpClient.getUrl(Uri.parse(url));
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);
    final tempDir = Directory.systemTemp;
    final file = await File('${tempDir.path}/profile_image.jpg').writeAsBytes(bytes);
    return file;
  }
}
