import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final Function(String? value) onChanged;
  final String labelText;
  final String? selectedValue;
  final List<String> dropDownOptions;

  const CustomDropDown({
    Key? key,
    required this.onChanged,
    required this.selectedValue,
    required this.dropDownOptions,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final leftPadding =
    //     selectedValue?.length != null ? selectedValue!.length * 6.0 : 12;
    return Card(
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade400, width: 0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                // suffixIcon: const Icon(
                //   Icons.sort,
                //   color: Colors.black,
                // ),
                suffix: const Icon(
                  Icons.sort,
                  color: Colors.black,
                ),
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontSize: 14.0,
                  letterSpacing: 1.0,
                ),
                hintText: 'Search your nearby',
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              //textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              isEmpty: selectedValue == '',
              child: Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                    //  alignment: Alignment.center,
                    // value: _currentSelectedValue,
                    value: selectedValue,
                    dropdownColor: Colors.white,
                    icon: const SizedBox.shrink(),
                    //  const Icon(
                    //   Icons.arrow_drop_down,
                    //   color: Colors.white,
                    // ),
                    isDense: true,
                    onChanged: onChanged,

                    items: dropDownOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        alignment: Alignment.center,
                        value: value,
                        child: Text(
                          //' ${value.toUpperCase()}',
                          value.toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
