import 'package:flutter/material.dart';

class Chiper extends StatefulWidget {
  final String labelText;
  final List<ChiperOption> options;
  final List<String> values;
  final ValueChanged<List<String>> onChanged;

  const Chiper({
    super.key,
    required this.labelText,
    required this.options,
    required this.values,
    required this.onChanged,
  });

  @override
  State<Chiper> createState() => _ChiperState();
}

class _ChiperState extends State<Chiper> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showOptionsDialog(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: widget.labelText,
          ),
          isEmpty: widget.values.isEmpty,
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: widget.options.where((option) {
              return widget.values.contains(option.value);
            }).map((option) {
              return ChiperItem(label: option.label);
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    final List<String> selectedValues = List.from(widget.values);
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(widget.labelText),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.options.map((option) {
                    return FilterChip(
                      label: Text(option.label),
                      selected: selectedValues.contains(option.value),
                      onSelected: (isSelected) {
                        setState(() {
                          isSelected
                              ? selectedValues.add(option.value)
                              : selectedValues.remove(option.value);
                        });
                        widget.onChanged(selectedValues);
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                FilledButton(
                  child: const Text('ОК'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ChiperItem extends StatelessWidget {
  final String label;

  const ChiperItem({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 1
      ),
      child: Text(label),
    );
  }
}

class ChiperOption {
  final String value;
  final String label;
  final List<ChiperOption>? subOptions;

  ChiperOption({
    required this.value,
    required this.label,
    this.subOptions,
  });
}
