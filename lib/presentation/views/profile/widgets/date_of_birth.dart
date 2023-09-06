import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/domain/provider/profile/add_profile_provider.dart';

import '../../../../config/theams/fonts.dart';

class DateOfBirthSelection extends StatelessWidget {
  const DateOfBirthSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Date of birth :',
                style: normal,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(23),
          child: Consumer<AddProfileProvider>(
            builder: (context, value, child) => DecoratedBox(
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: value.formateDate,
                    hintStyle: buttonTextDark,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: white)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          Provider.of<AddProfileProvider>(context,
                                  listen: false)
                              .selectDate(context);
                        },
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: black,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: white,
                          width: 1,
                        ))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
