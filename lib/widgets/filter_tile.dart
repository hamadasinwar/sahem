import 'package:flutter/material.dart';

class FilterTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const FilterTile({Key? key, required this.title, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      checkColor: Colors.white,
      activeColor: Theme.of(context).primaryColor,
      onChanged: (value)=> onChanged(value),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
