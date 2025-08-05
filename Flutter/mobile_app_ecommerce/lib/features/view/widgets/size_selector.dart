import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int selectedSize = 0;
  final sizes = ['S', 'M', 'L', 'XL'];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        sizes.length,
        (index)=> Padding(
          padding: EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(sizes[index]),
            selected: selectedSize == index,
            onSelected: (bool selected){
              setState(() {
                selectedSize = selected ? index : selectedSize;
              });
            },
            selectedColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(
              color: selectedSize == index ? Colors.white : Colors.black,
            ),
            ),
           ),
          ),
    );
  }
}