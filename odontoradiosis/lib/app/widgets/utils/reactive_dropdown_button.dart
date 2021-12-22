import 'package:flutter/material.dart';

class ReactiveDropdownButton<E> extends StatefulWidget {
  final E? initialValue;
  final List<E> items;
  final Widget Function(E)? childBuilder;
  final void Function(E?) onChanged;
  final String? Function(E?)? validator;
  final InputDecoration? decoration;

  const ReactiveDropdownButton({
    Key? key,
    this.initialValue,
    required this.items,
    this.childBuilder,
    required this.onChanged,
    this.validator,
    this.decoration,
  }) : super(key: key);

  @override
  _ReactiveDropdownButtonState<E> createState() =>
      _ReactiveDropdownButtonState<E>(initialValue);
}

class _ReactiveDropdownButtonState<E> extends State<ReactiveDropdownButton<E>> {
  E? value;

  _ReactiveDropdownButtonState(this.value);

  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  Widget _buildChild(E element) {
    if (widget.childBuilder != null) {
      return widget.childBuilder!(element);
    }
    return Text(
      element.toString(),
      overflow: TextOverflow.fade,
    );
  }

  void _onChanged(E? newValue) {
    setState(() {
      value = newValue;
      widget.onChanged(newValue);
    });
  }

  List<DropdownMenuItem<E>> _buildItems() {
    return [
      for (final element in widget.items)
        DropdownMenuItem<E>(
          value: element,
          child: _buildChild(element),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.validator != null || widget.decoration != null) {
      return DropdownButtonFormField<E>(
        isExpanded: true,
        value: value,
        onChanged: _onChanged,
        validator: widget.validator,
        decoration: widget.decoration,
        items: _buildItems(),
      );
    }
    return DropdownButton<E>(
      isExpanded: true,
      value: value,
      onChanged: _onChanged,
      items: _buildItems(),
    );
  }
}
