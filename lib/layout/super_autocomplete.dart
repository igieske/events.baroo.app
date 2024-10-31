import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/artist.dart';


class SuperAutocomplete<T extends Object> extends StatefulWidget {
  final List<T> options;
  final T? initialValue;
  final double maxWidth;
  final String hintText;
  final String Function(T) displayStringForOption;
  final void Function(T) onSelected;
  final void Function() onCleared;

  const SuperAutocomplete({
    super.key,
    required this.options,
    this.initialValue,
    required this.maxWidth,
    required this.hintText,
    required this.displayStringForOption,
    required this.onSelected,
    required this.onCleared,
  });

  @override
  State<SuperAutocomplete<T>> createState() => _SuperAutocompleteState<T>();
}

class _SuperAutocompleteState<T extends Object> extends State<SuperAutocomplete<T>> {
  TextEditingController _controller = TextEditingController();
  late bool _controllerIsSet;
  T? value;

  void _clear(TextEditingController? controller) {
    _controller.clear();
    setState(() => value = null);
    widget.onCleared();
  }

  @override
  void initState() {
    super.initState();
    _controllerIsSet = false;
    value = widget.initialValue;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value != null;
    return Autocomplete<T>(
      // todo
      // initialValue: ,
      displayStringForOption: widget.displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.length < 2) {
          return Iterable<T>.empty();
        }
        return widget.options.where((T option) => widget.displayStringForOption(option)
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<T> onSelected,
          Iterable<T> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widget.maxWidth),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final T option = options.elementAt(index);
                  return InkWell(
                    // тап опции → передаём в onSelected
                    onTap: () => onSelected(option),
                    child: Builder(
                      builder: (BuildContext context) {
                        // todo: hover цвет не делать для мобилы
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
                            RawAutocomplete.defaultStringForOption(widget.displayStringForOption(option)),
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
        if (!_controllerIsSet) {
          _controller = controller;
          _controllerIsSet = true;
        }
        return TextField(
          controller: _controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: widget.hintText,

            floatingLabelBehavior: hasValue
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,

            // аватарка
            prefixIcon: !hasValue ? null : Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                // todo: аватарка
                color: Colors.green,
                width: 48,
                height: 48,
              ),
            ),

            // выбранное
            prefix: !hasValue ? null : Row(
              children: [
                Icon(
                  value is Fella ? Icons.person : Icons.group,
                  size: 18,
                  color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                ),
                const SizedBox(width: 4),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  child: Text(widget.displayStringForOption(value!)),
                ),
              ],
            ),

            // крестик
            suffixIcon: !hasValue ? null : IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _clear(_controller),
            ),

          ),
          readOnly: value != null,
          // нажатие enter
          onSubmitted: (value) => onFieldSubmitted(),
        );
      },
      onSelected: (T selectedValue) {
        setState(() => value = selectedValue);
        _controller.clear();
        widget.onSelected(selectedValue);
      },
    );
  }
}
