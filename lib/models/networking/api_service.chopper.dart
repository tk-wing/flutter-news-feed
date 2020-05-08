// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiService;

  @override
  Future<Response<dynamic>> getHeadLines(
      {String country = 'jp',
      int pageSize = 10,
      String apiKey = ApiService.API_KEY}) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{
      'country': country,
      'pageSize': pageSize,
      'apiKey': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getKeywordNews(
      {String country = 'jp',
      int pageSize = 10,
      String keyword,
      String apiKey = ApiService.API_KEY}) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{
      'country': country,
      'pageSize': pageSize,
      'p': keyword,
      'apiKey': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCategoryNews(
      {String country = 'jp',
      int pageSize = 10,
      String category,
      String apiKey = ApiService.API_KEY}) {
    final $url = '/top-headlines';
    final $params = <String, dynamic>{
      'country': country,
      'pageSize': pageSize,
      'category': category,
      'apiKey': apiKey
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}