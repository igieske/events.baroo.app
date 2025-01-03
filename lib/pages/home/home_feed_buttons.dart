import 'package:flutter/material.dart';


class HomeFeedButtons extends StatelessWidget {
  final int casesCount;
  final int pastCasesCount;
  final VoidCallback onOpenPastCases;

  const HomeFeedButtons({
    super.key,
    required this.casesCount,
    required this.pastCasesCount,
    required this.onOpenPastCases,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Row(
            spacing: 6,
            children: [

              FilledButton.tonal(
                onPressed: onOpenPastCases,
                style: FilledButton.styleFrom(
                  minimumSize: Size(50, 50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chevron_left),
                    Icon(Icons.history),
                    const SizedBox(width: 5),
                    Text(pastCasesCount.toString()),
                    const SizedBox(width: 5),
                  ],
                ),
              ),

              Expanded(
                child: FilledButton.tonal(
                  onPressed: null,
                  style: FilledButton.styleFrom(
                    disabledForegroundColor: Color(0xFF475C73),
                  ),
                  child: Text('Найдено: $casesCount'),
                ),
              ),

              FilledButton.tonal(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  minimumSize: Size(50, 50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 5),
                    Text('X'),
                    const SizedBox(width: 5),
                    Icon(Icons.visibility_off_outlined),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
