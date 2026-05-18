import 'package:app/common/http_client.dart';
import 'package:app/data/banner.dart';
import 'package:app/data/data_source/banner_data_source.dart';

final bannerRepository = BannerRepository(dataSource: BannerRemoteDataSource(httpClient: httpClient));

abstract class IBannerRepository{
 Future<List<BannerEntity>> getAll();
}

class BannerRepository  implements IBannerRepository{
  final IBannerDataSource dataSource;

  BannerRepository({required this.dataSource});
  @override
  Future<List<BannerEntity>> getAll() => dataSource.getAll();
}