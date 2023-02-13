

import 'package:cashback/src/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search...',
        /*  hintStyle: TextStyle(
          color: Colors.grey,
        ),*/
        fillColor: CbColors.cbWhiteColor,
        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.search,
            //color: Colors.grey,
          ),
        ),
        /*suffixIcon: MaterialButton(
          minWidth: 10,
          onPressed: () {},
          color: CbColors.cbPrimaryColor2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(Icons.mic),
        ),*/
        suffixIcon: const Icon(
          Icons.mic,
          size: 25,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
      ),
    );
  }
}