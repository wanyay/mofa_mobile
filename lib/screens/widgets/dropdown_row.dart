import 'package:flutter/material.dart';

class DropdownRow<T> extends StatelessWidget {
  final String label;
  final String hintText;
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;
  final String Function(T) getLabel;
  final bool isLast;

  const DropdownRow({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.getLabel,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<T>(
                  value: selectedValue,
                  items: items.map((T item) {
                    return DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        getLabel(item),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  isExpanded: true,
                  alignment: AlignmentDirectional.centerEnd,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none, // No underline
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.normal,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(color: Colors.grey[200], height: 1),
      ],
    );
  }
}
