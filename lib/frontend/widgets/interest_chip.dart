import 'package:flutter/cupertino.dart';

class InterestChip extends StatelessWidget {
  final String label;

  const InterestChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: CupertinoColors.systemGrey4,
      child: Text(label, style: TextStyle(color: CupertinoColors.black)),
      onPressed: () {},
    );
  }
}
