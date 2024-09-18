import 'package:flutter/material.dart';


enum BrickWidth { xs, sm, md, lg, xl, xxl }

// верхние границы диапазонов
const defaultBricsBreakpoints = BricsBreakpointsConfig(
  xs: 576,
  sm: 768,
  md: 992,
  lg: 1200,
  xl: 1400,
);

class BricsBreakpointsConfig {
  final int xs;
  final int sm;
  final int md;
  final int lg;
  final int xl;
  const BricsBreakpointsConfig({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });
}

class BricsConfig extends InheritedWidget {
  final BricsBreakpointsConfig breakpoints;
  final int totalColumns;

  const BricsConfig({
    super.key,
    Widget? child,
    this.totalColumns = 12,
    this.breakpoints = defaultBricsBreakpoints,
  }) : super(child: child ?? const SizedBox.shrink());

  static BricsConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BricsConfig>()
        ?? const BricsConfig();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
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
    this.alignment = Alignment.topCenter,
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

  int _getColumnCount(double width, int totalColumns, BricsBreakpointsConfig breakpoints) {
    if (width < breakpoints.xs) {
      return size[BrickWidth.xs] ?? totalColumns;
    }
    if (width < breakpoints.sm) {
      return size[BrickWidth.sm] ?? size[BrickWidth.xs] ?? totalColumns;
    }
    if (width < breakpoints.md) {
      return size[BrickWidth.md] ?? size[BrickWidth.sm] ?? size[BrickWidth.xs] ?? totalColumns;
    }
    if (width < breakpoints.lg) {
      return size[BrickWidth.lg] ?? size[BrickWidth.md] ?? size[BrickWidth.sm] ?? size[BrickWidth.xs] ?? totalColumns;
    }
    if (width < breakpoints.xl) {
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
