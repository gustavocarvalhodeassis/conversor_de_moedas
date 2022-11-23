import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.preText,
    this.icon,
    this.controller,
    this.onChanged,
  });

  final String label;
  final String preText;
  final Widget? icon;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  InputBorder customInputBorder(Color borderColor) {
    borderColor = Colors.blue;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 1.5,
        color: borderColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text(label),
              prefixText: '$preText ',
              suffixIcon: icon,
              enabledBorder: customInputBorder(
                Colors.blue,
              ),
              border: customInputBorder(
                Colors.black45,
              ),
              focusedBorder: customInputBorder(
                Colors.blue,
              ),
              errorBorder: customInputBorder(
                Colors.red,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              controller?.clear();
            },
            icon: const Icon(
              Icons.cached,
              color: Colors.blue,
            ))
      ],
    );
  }
}
