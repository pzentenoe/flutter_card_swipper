import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FormWidget extends StatelessWidget {
  final String label;

  final Widget child;

  FormWidget({this.label, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Text(label, style: const TextStyle(fontSize: 14.0)),
            Expanded(
                child: Align(alignment: Alignment.centerRight, child: child))
          ],
        ));
  }
}

class FormSelect<T> extends StatefulWidget {
  final String placeholder;
  final ValueChanged<T> valueChanged;
  final List<dynamic> values;
  final dynamic value;

  FormSelect({this.placeholder, this.valueChanged, this.value, this.values});

  @override
  State<StatefulWidget> createState() {
    return _FormSelectState();
  }
}

class _FormSelectState extends State<FormSelect> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // ignore: prefer_final_locals
    for (int i = 0, c = widget.values.length; i < c; ++i) {
      if (widget.values[i] == widget.value) {
        _selectedIndex = i;
        break;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String placeholder = widget.placeholder;
    final List<dynamic> values = widget.values;

    return Container(
      child: InkWell(
        child: Text(_selectedIndex < 0
            ? placeholder
            : values[_selectedIndex].toString()),
        onTap: () {
          _selectedIndex = 0;
          showBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: values.length * 30.0 + 200.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: values.length * 30.0 + 70.0,
                        child: CupertinoPicker(
                          itemExtent: 30.0,
                          children: values.map((dynamic value) {
                            return Text(value.toString());
                          }).toList(),
                          onSelectedItemChanged: (int index) {
                            _selectedIndex = index;
                          },
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedIndex >= 0) {
                              widget
                                  .valueChanged(widget.values[_selectedIndex]);
                            }
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: Text('ok'),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}

class NumberPad extends StatelessWidget {
  final num number;
  final num step;
  final num max;
  final num min;
  final ValueChanged<num> onChangeValue;

  NumberPad({this.number, this.step, this.onChangeValue, this.max, this.min});

  void onAdd() {
    onChangeValue(number + step > max ? max : number + step);
  }

  void onSub() {
    onChangeValue(number - step < min ? min : number - step);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(icon: Icon(Icons.exposure_neg_1), onPressed: onSub),
        Text(
          number is int ? number.toString() : number.toStringAsFixed(1),
          style: TextStyle(fontSize: 14.0),
        ),
        IconButton(icon: Icon(Icons.exposure_plus_1), onPressed: onAdd)
      ],
    );
  }
}
