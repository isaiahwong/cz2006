import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';

class NumberScroller extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final int minValue;
  final double width;
  final double height;
  final double itemExtent;
  final double fontSize;
  final BoxDecoration? decoration;
  final bool twoDP;
  final ValueChanged<int>? onChanged;

  const NumberScroller({
    Key? key,
    required this.initialValue,
    required this.maxValue,
    this.minValue = 0,
    this.width = 50,
    this.height = 32,
    this.itemExtent = 18,
    this.twoDP = false,
    this.fontSize = 18,
    this.decoration,
    this.onChanged,
  })  : assert(minValue <= initialValue),
        assert(initialValue <= maxValue),
        super(key: key);

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberScroller> {
  late FixedExtentScrollController _controller;

  late List<int> _items = [];
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.maxValue - widget.minValue; i++)
      _items.add(i + widget.minValue);

    _selected = widget.initialValue;
    _controller = FixedExtentScrollController(
        initialItem: widget.initialValue - widget.minValue);
  }

  Widget _item(int index) {
    final text = widget.twoDP && index < 10 ? "0$index" : "$index";
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
          color:
              index == _selected ? primaryColor : primaryColor.withAlpha(100),
        ),
      ),
    );
  }

  ValueChanged<int>? onChanged(int index) {
    final i = index + widget.minValue;
    setState(() => _selected = i);
    if (widget.onChanged != null) widget.onChanged!(i);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration,
      child: ListWheelScrollView(
        controller: _controller,
        physics: FixedExtentScrollPhysics(),
        children: _items.map<Widget>((i) => _item(i)).toList(),
        itemExtent: widget.itemExtent,
        onSelectedItemChanged: onChanged,
        diameterRatio: 1.3,
        squeeze: 1.3,
      ),
    );
  }
}
