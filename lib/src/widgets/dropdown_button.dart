import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:trip_tales/src/constants/color.dart';

class CustomDropdownButton extends StatefulWidget {
  final String label;
  final List<String> items;
  final Function(String?) onValueChanged;
  String? selectedValue;
  final IconData icon;
  final bool readOnly;

  CustomDropdownButton({
    super.key,
    required this.selectedValue,
    required this.label,
    required this.items,
    required this.onValueChanged,
    this.icon = Icons.list,
    this.readOnly = false,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {


  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Icon(
              widget.icon,
              size: 24,
              color: AppColors.main1,
              //shadows: [Shadow(color: Colors.grey, offset: Offset(-2, 2))]
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                widget.label,
                style: const TextStyle(
                  color: AppColors.text3,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(
                        widget.icon,
                        size: 24,
                        color: AppColors.main1,
                        //shadows: [Shadow(color: Colors.grey, offset: Offset(0, 3))]
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        item,
                        style: const TextStyle(
                          color: AppColors.text1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ))
            .toList(),
        value: widget.selectedValue,
        onChanged: (String? value) {
          setState(() {
            if(!widget.readOnly){
              widget.selectedValue = value;
              widget.onValueChanged(value);
            }
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 300,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.main1,
            ),
            color: Colors.transparent,
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: AppColors.text3,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            border: Border.all(
              color: AppColors.main1,
            ),
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
