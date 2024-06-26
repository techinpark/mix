// ignore_for_file: prefer-named-boolean-parameters

import 'dart:ui';

import 'package:flutter/material.dart';

import '../attributes/scalars/scalar_util.dart';
import '../core/attribute.dart';
import '../core/factory/mix_data.dart';
import '../core/modifier.dart';

final class SizedBoxModifierSpec
    extends WidgetModifierSpec<SizedBoxModifierSpec> {
  final double? width;
  final double? height;

  const SizedBoxModifierSpec({this.width, this.height});

  @override
  SizedBoxModifierSpec lerp(SizedBoxModifierSpec? other, double t) {
    return SizedBoxModifierSpec(
      width: lerpDouble(width, other?.width, t),
      height: lerpDouble(height, other?.height, t),
    );
  }

  @override
  SizedBoxModifierSpec copyWith({double? width, double? height}) {
    return SizedBoxModifierSpec(
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  get props => [width, height];

  @override
  Widget build(Widget child) {
    return SizedBox(width: width, height: height, child: child);
  }
}

final class SizedBoxModifierAttribute extends WidgetModifierAttribute<
    SizedBoxModifierAttribute, SizedBoxModifierSpec> {
  final double? width;
  final double? height;

  const SizedBoxModifierAttribute({this.width, this.height});

  @override
  SizedBoxModifierSpec resolve(MixData mix) {
    return SizedBoxModifierSpec(width: width, height: height);
  }

  @override
  SizedBoxModifierAttribute merge(SizedBoxModifierAttribute? other) {
    return SizedBoxModifierAttribute(
      width: other?.width ?? width,
      height: other?.height ?? height,
    );
  }

  @override
  get props => [width, height];
}

final class SizedBoxModifierUtility<T extends Attribute>
    extends MixUtility<T, SizedBoxModifierAttribute> {
  const SizedBoxModifierUtility(super.builder);

  T call({double? width, double? height}) {
    return builder(SizedBoxModifierAttribute(width: width, height: height));
  }
}
