import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkConnectivity {
  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();

    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      print(result);
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      // final result = await InternetAddress.lookup('example.com');
      // isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      switch (result) {
        case ConnectivityResult.mobile:
          final url = 'https://pokeapi.co/api/v2/pokemon/';
          var header = {"Content-Type": "application/json"};
          final response = await http.get(Uri.parse(url), headers: header);
          if (response.statusCode == 200) {
            isOnline = true;
          } else {
            isOnline = false;
          }
          break;
        case ConnectivityResult.wifi:
          if (await InternetConnectionChecker().hasConnection) {
            isOnline = true;
          } else {
            isOnline = false;
          }
          break;
        case ConnectivityResult.none:
          isOnline = false;
          break;
        default:
          isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    if (!_controller.isClosed) _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
