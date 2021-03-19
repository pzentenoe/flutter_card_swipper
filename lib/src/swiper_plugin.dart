import 'package:flutter/widgets.dart';
import 'package:flutter_card_swipper/src/swiper.dart';
import 'package:flutter_card_swipper/src/swiper_controller.dart';
import 'package:flutter_card_swipper/widgets/flutter_page_indicator/flutter_page_indicator.dart';

/// plugin to display swiper components
///
abstract class SwiperPlugin {
  const SwiperPlugin();

  Widget build(BuildContext context, SwiperPluginConfig config);
}

class SwiperPluginConfig {
  final int activeIndex;
  final int itemCount;
  final PageIndicatorLayout indicatorLayout;
  final Axis scrollDirection;
  final bool loop;
  final bool outer;
  final PageController pageController;
  final SwiperController controller;
  final SwiperLayout layout;

  const SwiperPluginConfig({
    this.activeIndex,
    this.itemCount,
    this.indicatorLayout,
    this.outer,
    @required this.scrollDirection,
    this.controller,
    @required this.pageController,
    this.layout,
    this.loop,
  });
}

class SwiperPluginView extends StatelessWidget {
  final SwiperPlugin plugin;
  final SwiperPluginConfig config;

  const SwiperPluginView(this.plugin, this.config);

  @override
  Widget build(BuildContext context) {
    return plugin.build(context, config);
  }
}
