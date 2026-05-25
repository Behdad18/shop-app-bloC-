import 'package:app/common/utills.dart';
import 'package:app/data/banner.dart';
import 'package:app/ui/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final PageController _controller = PageController();
  final List<BannerEntity> banners;
  BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: SizedBox(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: banners.length,
              physics: defaultScroolPhsysics,
              itemBuilder: (context, index) {
                return _Slide(banner: banners[index]);
              },
            ),
            Center(
              child: Positioned(
                right: 0,
                left: 0,
                bottom: 8,
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: banners.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                    paintStyle: PaintingStyle.fill,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: Theme.of(context).colorScheme.onSurface,
                    radius: 4,
                    strokeWidth: 1.5,
                  spacing: 4,
                  dotHeight: 3,
                  dotWidth: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final BannerEntity banner;
  const _Slide({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: ImageLoadingService(
        imageUrl: banner.imageUrl,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
