import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final Color? textColor;
  final void Function()? onTap;
  const RoundedButton({
    Key? key,
    required this.label,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 1 == 1
        ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,

              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(label),
            ),
          )
        : InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: textColor ?? Theme.of(context).cardColor,
                ),
              ),
            ),
          );
  }
}
