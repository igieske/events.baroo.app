import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:events_baroo_app/layout/chiper.dart';
import 'package:events_baroo_app/models/artist.dart';


class SuperAutocomplete<T extends Object> extends StatefulWidget {
  final List<T> options;
  final T? initialValue;
  final double maxWidth;
  final String hintText;
  final String Function(T) displayStringForOption;
  final String? Function(T) imageUrlForOption;
  final void Function(T) onSelected;
  final void Function() onCleared;

  const SuperAutocomplete({
    super.key,
    required this.options,
    this.initialValue,
    required this.maxWidth,
    required this.hintText,
    required this.displayStringForOption,
    required this.imageUrlForOption,
    required this.onSelected,
    required this.onCleared,
  });

  @override
  State<SuperAutocomplete<T>> createState() => _SuperAutocompleteState<T>();
}

class _SuperAutocompleteState<T extends Object> extends State<SuperAutocomplete<T>> {
  TextEditingController? _controller;
  late bool _controllerIsSet;
  T? _value;

  void _clear(TextEditingController? controller) {
    setState(() => _value = null);
    _controller?.clear();
    widget.onCleared();
  }

  @override
  void initState() {
    super.initState();
    _controllerIsSet = false;
    _value = widget.initialValue;
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue = _value != null;
    return Autocomplete<T>(
      displayStringForOption: widget.displayStringForOption,

      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.length < 2) {
          return Iterable<T>.empty();
        }
        // todo: ограничивать max кол-во в списке (перебирать не все опции)
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
        final String? imageUrl = _value != null ? widget.imageUrlForOption(_value!) : null;
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
                width: 48,
                height: 48,
                child: imageUrl != null ? Image.network(
                  'https://baroo.ru/wp-content/uploads/XlLKEPudtR8-aspect-ratio-1-1-150x150.jpg',
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    print(error.toString());
                    return Text('Error loading image');
                  },
                ) : null,
              ),
            ),

            // выбранное
            prefix: !hasValue ? null : Container(
              constraints: BoxConstraints(maxWidth: widget.maxWidth - 48 - 55),
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Row(
                children: [
                  Icon(
                    _value is Fella ? Icons.person : Icons.group,
                    size: 18,
                    color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: ChiperChip(label: widget.displayStringForOption(_value!)),
                  ),
                ],
              ),
            ),

            // крестик
            suffixIcon: !hasValue ? null : IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _clear(_controller),
            ),

          ),
          // todo: проверить, или: _value != null
          readOnly: hasValue,
          // нажатие enter
          onSubmitted: (value) => onFieldSubmitted(),
        );
      },
      onSelected: (T selectedValue) {
        setState(() => _value = selectedValue);
        _controller?.clear();
        widget.onSelected(selectedValue);
      },
    );
  }
}
