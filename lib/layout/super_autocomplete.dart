import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class SuperAutocomplete<T extends Object> extends StatelessWidget {
  final List<T> options;
  final double maxWidth;
  final String hintText;
  final String Function(T) displayStringForOption;
  final void Function(T) onSelected;

  const SuperAutocomplete({
    super.key,
    required this.options,
    required this.maxWidth,
    required this.hintText,
    required this.displayStringForOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      displayStringForOption: displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.length < 2) {
          return Iterable<T>.empty();
        }
        return options.where((T option) => displayStringForOption(option)
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<T> onSelected,
          Iterable<T> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final T option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Builder(
                      builder: (BuildContext context) {
                        final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                        if (highlight) {
                          SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
                            Scrollable.ensureVisible(context, alignment: 0.5);
                          });
                        }
                        return Container(
                          color: highlight ? Theme.of(context).focusColor : null,
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            RawAutocomplete.defaultStringForOption(displayStringForOption(option)),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(hintText: hintText),
          onSubmitted: (value) => onFieldSubmitted(),
        );
      },
      onSelected: onSelected,
    );
  }
}
