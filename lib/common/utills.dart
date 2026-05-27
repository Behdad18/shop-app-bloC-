import 'package:flutter/widgets.dart';

const defaultScroolPhsysics = BouncingScrollPhysics();

extension LabelPrice on int{
  String get withPriceLabel=> '$this تومان';
}