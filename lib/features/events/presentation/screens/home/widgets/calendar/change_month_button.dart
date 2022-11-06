import 'package:flutter/material.dart';

class ChangeMonthButton extends StatelessWidget {
  const ChangeMonthButton({Key? key, required this.onTap, required this.icon})
      : super(key: key);
  final Function() onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.0),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            child: Container(
              height: 32.0,
              width: 32.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.2),
              ),
              child: Icon(
                icon,
                size: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
