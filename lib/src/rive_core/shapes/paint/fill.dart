import 'package:flutter/material.dart';
import 'package:rive/src/generated/shapes/paint/fill_base.dart';
import 'package:rive/src/rive_core/component_dirt.dart';
import 'package:rive/src/rive_core/shapes/shape_paint_container.dart';
export 'package:rive/src/generated/shapes/paint/fill_base.dart';

class Fill extends FillBase {
  @override
  Paint makePaint() => Paint()..style = PaintingStyle.fill;

  PathFillType get fillType =>
      (fillRule < PathFillType.values.length)
          ? PathFillType.values[fillRule]
          : PathFillType.nonZero;     // sólido quando vier 2

  set fillType(PathFillType t) => fillRule = t.index;

  @override
  void fillRuleChanged(int from, int to) =>
      parent?.addDirt(ComponentDirt.paint);

  @override
  void update(int _) {}

  @override
  void onAdded() {
    super.onAdded();
    if (parent is ShapePaintContainer) {
      (parent as ShapePaintContainer).addFill(this);
    }
  }

  @override
  void draw(Canvas canvas, Path path) {
    if (!isVisible || renderOpacity == 0) return;
    path.fillType = fillType;
    canvas.drawPath(path, paint);
  }
}
