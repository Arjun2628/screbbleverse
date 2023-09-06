import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/theams/colors.dart';
import '../../../../config/theams/fonts.dart';
import '../../../../domain/provider/profile/add_profile_provider.dart';

class Gender extends StatelessWidget {
  const Gender({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gender :',
                style: normal,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Consumer<AddProfileProvider>(
            builder: (context, addProfile, child) => Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    // color: Colors.amber,
                    width: double.infinity,
                    child: Theme(
                      data: ThemeData(unselectedWidgetColor: white),
                      child: RadioListTile(
                        activeColor: white,
                        title: Text(
                          "Male",
                          style: normal,
                        ),
                        value: true,
                        groupValue: addProfile.male,
                        onChanged: (value) {
                          addProfile.genderSelection("male");
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: Theme(
                      data: ThemeData(unselectedWidgetColor: white),
                      child: RadioListTile(
                        activeColor: white,
                        title: Text(
                          "Female",
                          style: normal,
                        ),
                        value: true,
                        groupValue: addProfile.female,
                        onChanged: (value) {
                          addProfile.genderSelection("female");
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Consumer<AddProfileProvider>(
          builder: (context, addProfile, child) => SizedBox(
            width: double.infinity,
            child: Theme(
              data: ThemeData(unselectedWidgetColor: white),
              child: RadioListTile(
                activeColor: white,
                title: Text(
                  "Others",
                  style: normal,
                ),
                value: true,
                groupValue: addProfile.others,
                onChanged: (value) {
                  addProfile.genderSelection("others");
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
