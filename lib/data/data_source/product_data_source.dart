import 'package:app/common/exceptins.dart';
import 'package:app/data/product.dart';
import 'package:dio/dio.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource({required this.httpClient});
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get('product/list?$sort');
    validateRespone(response);
    // Initialize empty list to hold product entities
    final productas = <ProductEntity>[];
    (response.data as List).forEach((element) {
      productas.add(ProductEntity.fromJson(element));
    });
    return productas;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('product/search?q=$searchTerm');
    validateRespone(response);
    // Initialize empty list to hold product entities
    final productas = <ProductEntity>[];
    (response.data as List).forEach((element) {
      productas.add(ProductEntity.fromJson(element));
    });
    return productas;
  }

  // Helper method to validate HTTP response
  // Throws AppExceptions if status code is not 200 (OK)
  validateRespone(Response response) {
    if (response.statusCode != 200) {
      throw AppExceotions();
    }
  }
}
