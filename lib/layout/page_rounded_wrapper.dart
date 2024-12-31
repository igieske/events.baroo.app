import 'package:flutter/material.dart';


class PageRoundedWrapper extends StatelessWidget {
  final Widget child;
  final Widget? topContent;

  const PageRoundedWrapper({
    super.key,
    required this.child,
    this.topContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [

          if (topContent != null) topContent!,

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(13),
              clipBehavior: Clip.antiAlias,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: child,
            ),
          ),

        ],
      ),
    );
  }
}
