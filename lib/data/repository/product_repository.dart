import 'package:app/data/data_source/product_data_source.dart';
import 'package:app/data/product.dart';
import 'package:dio/dio.dart';

final httpClient = Dio(BaseOptions(baseUrl: 'fttps://fapi.7learn.com/api/v1/'));
// Create a product repository instance with a remote data source
final productReposirory = ProductRepository(dataSource: ProductRemoteDataSource(httpClient: httpClient));

// Abstract interface defining the contract for product repository
abstract class IProductRepository{
  // Get all products with specified sorting order
  Future<List<ProductEntity>> getAll(int sort );
  // Search products by a search term
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepository{
  final IProductDataSource dataSource;

  ProductRepository({required this.dataSource});
  @override
  Future<List<ProductEntity>> getAll(int sort) => dataSource.getAll(sort);

  @override
  Future<List<ProductEntity>> search(String searchTerm) => dataSource.search(searchTerm);
}