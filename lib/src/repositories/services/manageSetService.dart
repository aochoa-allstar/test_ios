import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class ManageSetService {
  final String url;
  final dynamic body;
  final dynamic headers;

  ManageSetService({required this.url, this.headers, this.body});

  post() {
    /*final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);*/

    return http
        .post(Uri.parse(url), headers: headers, body: body)
        .timeout(const Duration(minutes: 2));
  }
}
