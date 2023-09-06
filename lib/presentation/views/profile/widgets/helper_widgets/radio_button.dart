import 'package:flutter/material.dart';

class GenderRadio extends StatefulWidget {
  final String gender;

  const GenderRadio(this.gender, {super.key});

  @override
  State<GenderRadio> createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: isSelected,
            onChanged: (value) {
              setState(() {
                isSelected = value!;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Text(
              widget.gender,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
