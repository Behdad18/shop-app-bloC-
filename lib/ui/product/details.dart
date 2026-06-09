import 'package:app/common/utills.dart';
import 'package:app/data/product.dart';
import 'package:app/theme.dart';
import 'package:app/ui/product/comment/comment_list.dart';
import 'package:app/ui/widgets/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: Text('افزودن به سبد خرید'),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          physics: defaultScroolPhsysics,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(imageUrl: product.imageUrl),
              foregroundColor: LightThemeColors.primarytextColor,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart)),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.previousPrice.withPriceLabel,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.apply(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(product.price.withPriceLabel),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'ین کتونی شدیدا  برای دویدن و راه رفتن مناسب هستو تقریبا هیچ فشاز مخربی رو نمیزاره به پا و زانوان شما انتقال داده بشه',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'نظرات کاربران',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(onPressed: () {}, child: Text('ثبت نظر')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CommentList(productId: product.id),
          ],
        ),
      ),
    );
  }
}
