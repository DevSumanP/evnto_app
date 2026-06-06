// ==============================================================================
// lib/core/di/modules/remote_module.dart
// Injectable bindings for the network layer.
// ==============================================================================

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../network/api_client.dart';
import '../../network/dio_client.dart';
import '../../network/network_info.dart';

@module
abstract class RemoteModule {
  /// The Dio instance owned by [DioClient]. Exposed for code that needs raw
  /// HTTP access (for example, third-party SDK integrations).
  @lazySingleton
  Dio get dio => DioClient.instance.dio;

  /// HTTP wrapper used by repositories.
  @lazySingleton
  ApiClient get apiClient => ApiClient(dioClient: DioClient.instance);

  /// Connectivity helper shared across the app.
  @lazySingleton
  NetworkInfo get networkInfo => NetworkInfo.instance;
}
