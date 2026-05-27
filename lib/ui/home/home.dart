import 'package:app/common/utills.dart';
import 'package:app/data/product.dart';
import 'package:app/data/repository/banner_repository.dart';
import 'package:app/data/repository/product_repository.dart';
import 'package:app/ui/home/bloc/home_bloc.dart';
import 'package:app/ui/product/product.dart';
import 'package:app/ui/widgets/image.dart';
import 'package:app/ui/widgets/slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
          bannerRepository: bannerRepository,
          productRepository: productRepository,
        );
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: ((context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/img/nike_logo.png',
                            height: 28,
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      case 2:
                        return BannerSlider(banners: state.banners);
                      case 3:
                        return _HorizantalProductList(
                          title: 'جدیدترین',
                          ontap: () {},
                          products: state.latestProducts,
                        );
                      case 4:
                        return _HorizantalProductList(
                          title: 'پربازدیدترین',
                          ontap: () {},
                          products: state.popularProducts,
                        );

                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(state.exception.message),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                        },
                        child: const Text('تلاش دوباره'),
                      ),
                    ],
                  ),
                );
              } else {
                throw Exception('state is not supported');
              }
            }),
          ),
        ),
      ),
    );
  }
}

class _HorizantalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback ontap;
  final List<ProductEntity> products;
  const _HorizantalProductList({
    super.key,
    required this.title,
    required this.ontap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              TextButton(onPressed: ontap, child: Text('مشاهده همه')),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            physics: defaultScroolPhsysics,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: EdgeInsets.only(left: 8, right: 8),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(product: product, borderRadius: BorderRadius.circular(12),);
            },
          ),
        ),
      ],
    );
  }
}

