import 'package:flutter/material.dart';

class MyRankCategory extends StatelessWidget {
  final String categoryName;
  final bool isSelected;
  final Function()? onTap;

  const MyRankCategory(
      {super.key,
      required this.categoryName,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          splashColor: Colors.blue[100],
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blueAccent[100] : Colors.grey[500],
              borderRadius: const BorderRadius.all(Radius.circular(48.0)),
            ),
            child: Text(
              categoryName,
              style: const TextStyle(
                  color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(width: 2,)
      ],
    );
  }
}
