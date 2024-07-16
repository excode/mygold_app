import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  late String labelText;
  late List<Map<String, dynamic>> items;
  late Function(Map<String, dynamic>?) onChanged;
  late Map<String, dynamic> selValue;
  late String label;
  late String value;

  DropdownField({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    required this.selValue,
    this.label = "Name",
    this.value = "Id",
  });
  @override
  Widget build(BuildContext context) {
    // Sample data for the dropdown

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearch<Map<String, dynamic>>(
          items: items,
          itemAsString: (item) => item[label] ?? '',
          selectedItem: selValue,
          onChanged: onChanged,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: labelText,
              hintText: labelText,
              filled: true,
            ),
          ),
          popupProps: const PopupPropsMultiSelection.modalBottomSheet(
            showSearchBox: true,
          ),
        ),
      ),
    );
  }
}
