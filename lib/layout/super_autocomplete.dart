import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class SuperAutocomplete<T extends Object> extends StatefulWidget {
  final TextEditingController? controller;
  final List<T> options;
  final T? initialValue;
  final double maxWidth;
  final String hintText;
  final String Function(T) displayStringForOption;
  final void Function(T) onSelected;
  final void Function() onCleared;

  const SuperAutocomplete({
    super.key,
    this.controller,
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
  late TextEditingController _controller;
  late bool _isSelected;

  void _clear(TextEditingController? controller) {
    (controller ?? _controller).clear();
    setState(() => _isSelected = false);
    widget.onCleared();
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isSelected = widget.initialValue != null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    onTap: () {
                      print('onTap!');
                      // _controller.text = widget.displayStringForOption(option);

                      // передаём в onSelected
                      onSelected(option);

                    },
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
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: widget.hintText,
            prefix: _isSelected ? Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              child: Text(controller.text),
            ) : null,
            suffixIcon: _isSelected
              ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _clear(controller),
              )
              : null,
          ),
          readOnly: _isSelected,
          onSubmitted: (value) {
            print('onSubmitted: $value');

            // if (!widget.options.any((T option) => widget.displayStringForOption(option) == value)) {
            //   // controller.clear();
            //   widget.onCleared();
            // }

            // при нажатии Enter – происходит сабмит
            // если опция выбрана - кидает в onSelect
            onFieldSubmitted();
          },
        );
      },
      onSelected: (T selectedValue) {


        _controller.clear();
        _controller.text = '';


        _controller.value = const TextEditingValue(text: '');
        print('onSelected! ${selectedValue.toString()}');
        widget.onSelected(selectedValue);

        setState(() => _isSelected = true);
      },
    );
  }
}
