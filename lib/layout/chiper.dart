import 'package:flutter/material.dart';

class Chiper extends StatefulWidget {
  final String labelText;
  final List<String> options;
  final List<String> value;
  final ValueChanged<List<String>> onChanged;

  const Chiper({
    super.key,
    required this.labelText,
    required this.options,
    required this.value,
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
          isEmpty: widget.value.isEmpty,
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: widget.value
                .map((selectedOption) => ChiperItem(value: selectedOption))
                .toList(),
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    List<String> selectedOptions = List.from(widget.value);
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
                  children: widget.options.map((option) {
                    return FilterChip(
                      label: Text(option),
                      selected: selectedOptions.contains(option),
                      onSelected: (isSelected) {
                        setState(() {
                          isSelected
                              ? selectedOptions.add(option)
                              : selectedOptions.remove(option);
                        });
                        widget.onChanged(selectedOptions);
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
  final String value;

  const ChiperItem({super.key, required this.value});

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
      child: Text(value),
    );
  }
}
