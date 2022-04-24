import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final Function(String? value) onChanged;

  final String? selectedValue;
  final List<String> dropDownOptions;

  const SortButton(
      {Key? key,
      required this.onChanged,
      required this.selectedValue,
      required this.dropDownOptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        //  padding: const EdgeInsets.all(20),
        child: DropdownButtonHideUnderline(
      child: DropdownButton(
        // value: _value,
        items: dropDownOptions.map((String item) {
          return DropdownMenuItem<String>(
            child: Text(item),
            value: item,
          );
        }).toList(),
        onChanged: onChanged,
        hint: Text(selectedValue?.toUpperCase() ?? 'Choose your category'),
        // disabledHint: Text('Disabled'),
        elevation: 8,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        icon: const Icon(Icons.sort),
        //  Icon(Icons.arrow_drop_down_circle),
        // iconDisabledColor: Colors.red,
        // iconEnabledColor: Colors.green,
        isExpanded: true,
        //dropdownColor: Colors.deepOrange,
      ),
    ));
  }
}
