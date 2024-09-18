import 'package:flutter/material.dart';


enum BrickWidth { xs, sm, md, lg, xl, xxl }

class BricsConfig extends InheritedWidget {
  final Map<BrickWidth, double> breakpoints;
  final int totalColumns;

  const BricsConfig({
    super.key,
    required super.child,
    this.breakpoints = const {
      BrickWidth.xs: 576,
      BrickWidth.sm: 768,
      BrickWidth.md: 992,
      BrickWidth.lg: 1200,
      BrickWidth.xl: 1400,
      BrickWidth.xxl: 1600,
    },
    this.totalColumns = 12,
  });

  static BricsConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BricsConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class Brics extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final double crossGap;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final Alignment alignment;

  const Brics({
    super.key,
    required this.children,
    this.gap = 0,
    this.crossGap = 0,
    this.maxWidth,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bricsConstraints = maxWidth == null ? null : BoxConstraints(
            maxWidth: constraints.maxWidth < maxWidth! ? constraints.maxWidth : maxWidth!
        );
        return Align(
          alignment: alignment,
          child: Container(
            padding: padding!,
            constraints: bricsConstraints,
            child: Wrap(
              spacing: gap,
              runSpacing: crossGap,
              children: children,
            ),
          ),
        );
      },
    );
  }
}


class Bric extends StatelessWidget {
  final Map<BrickWidth, int> size;
  final Widget child;

  const Bric({
    super.key,
    required this.child,
    this.size = const {},
  });

  int _getColumnCount(double width, int totalColumns, Map<BrickWidth, double> breakpoints) {
    if (width < breakpoints[BrickWidth.xs]!) {
      return size[BrickWidth.xs] ?? totalColumns;
    }
    if (width < breakpoints[BrickWidth.sm]!) {
      return size[BrickWidth.sm] ?? size[BrickWidth.xs] ?? totalColumns;
    }
    if (width < breakpoints[BrickWidth.md]!) {
      return size[BrickWidth.md] ?? size[BrickWidth.sm] ?? size[BrickWidth.xs] ?? totalColumns;
    }
    if (width < breakpoints[BrickWidth.lg]!) {
      return size[BrickWidth.lg] ?? size[BrickWidth.md] ?? size[BrickWidth.sm] ?? size[BrickWidth.xs] ?? totalColumns;
    }
    if (width < breakpoints[BrickWidth.xl]!) {
      return size[BrickWidth.xl] ?? size[BrickWidth.lg] ?? size[BrickWidth.md] ?? size[BrickWidth.sm] ?? size[BrickWidth.xs] ?? totalColumns;
    }
    return size[BrickWidth.xxl] ?? size[BrickWidth.xl] ?? size[BrickWidth.lg] ?? size[BrickWidth.md] ?? size[BrickWidth.sm] ?? size[BrickWidth.xs] ?? totalColumns;
  }


  @override
  Widget build(BuildContext context) {
    final config = BricsConfig.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final columnCount = _getColumnCount(width, config.totalColumns, config.breakpoints);
    final brics = context.findAncestorWidgetOfExactType<Brics>();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Получаем значения отступов (gap) и общего количества колонок
        final gap = brics?.gap ?? 0;
        final totalColumns = config.totalColumns;
        // Ширина одной колонки с учётом промежутков между колонками
        final columnWidth = (constraints.maxWidth - gap * (totalColumns - 1)) / totalColumns;
        // Ширина текущего Bric с учётом количества колонок и отступов
        final bricWidth = columnCount * columnWidth + (columnCount - 1) * gap;
        // Корректное отображение для пустого контейнера
        if (bricWidth <= 0) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          width: bricWidth,
          child: child,
        );
      },
    );
  }
}
