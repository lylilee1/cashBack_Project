

import 'package:flutter/material.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(width: 4),
        ),
      ),
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Search...',
            style: Theme.of(context).textTheme.headline2?.apply(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          const Icon(
            Icons.mic,
            size: 25,
          )
        ],
      ),
    );
  }
}