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
  late List<String> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = List.from(widget.values);
  }

  @override
  Widget build(BuildContext context) {

    List<ChiperChip> options = widget.options.expand((option) {
      List<ChiperOption> list = [];
      if (selectedValues.contains(option.value)) list.add(option);
      if ((option.subOptions ?? []).isNotEmpty) {
        list.addAll(option.subOptions!.where((subOption) {
          return selectedValues.contains(subOption.value);
        }).toList());
      }
      return list;
    })
      .map((option) => ChiperChip(label: option.label))
      .toList();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showOptionsDialog(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: widget.labelText,
          ),
          isEmpty: selectedValues.isEmpty,
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: options,
          ),
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    final tempSelectedValues = List<String>.from(selectedValues);

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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // parent option
                        FilterChip(
                          label: Text(option.label),
                          selected: tempSelectedValues.contains(option.value),
                          onSelected: (isSelected) {
                            setState(() {
                              isSelected
                                  ? tempSelectedValues.add(option.value)
                                  : tempSelectedValues.remove(option.value);
                            });
                          },
                        ),
                        // children options
                        if (option.subOptions != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: option.subOptions!.map((subOption) {
                                return FilterChip(
                                  label: Text(subOption.label),
                                  selected: tempSelectedValues
                                      .contains(subOption.value),
                                  onSelected: (isSelected) {
                                    setState(() {
                                      isSelected
                                          ? tempSelectedValues
                                          .add(subOption.value)
                                          : tempSelectedValues
                                          .remove(subOption.value);
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Отмена'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FilledButton(
                  child: const Text('ОК'),
                  onPressed: () {
                    Navigator.of(context).pop(tempSelectedValues);
                  },
                ),
              ],
            );
          },
        );
      },
    ).then((values) {
      if (values != null) {
        setState(() {
          selectedValues = values;
          widget.onChanged(selectedValues);
        });
      }
    });
  }
}

class ChiperChip extends StatelessWidget {
  final String label;

  const ChiperChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Text(label, style: const TextStyle(
        fontSize: 14,
        height: 1.25,
      )),
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
