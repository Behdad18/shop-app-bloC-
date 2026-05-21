import 'package:app/common/exceptins.dart';
import 'package:app/data/banner.dart';
import 'package:app/data/product.dart';
import 'package:app/data/repository/banner_repository.dart';
import 'package:app/data/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  HomeBloc({required this.bannerRepository, required this.productRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final banners = await bannerRepository.getAll();
          final latestProducts =
              await productRepository.getAll(ProductSort.latest);
          final popularProducts =
              await productRepository.getAll(ProductSort.popular);
          emit(HomeSuccess(
              banners: banners,
              latestProducts: latestProducts,
              popularProducts: popularProducts));
        } catch (e) {
          emit(HomeError(exception: e is AppExceotions ? e : AppExceotions()));
        }
      }
    });
  }
}
