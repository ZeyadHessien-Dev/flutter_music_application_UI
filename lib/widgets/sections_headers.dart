import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionsHeader extends StatelessWidget {
  const SectionsHeader({
    Key? key,
    required this.title,
    this.action = 'View More',
  }) : super(key: key);
  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          action,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
        ),
      ],
    );
  }
}
