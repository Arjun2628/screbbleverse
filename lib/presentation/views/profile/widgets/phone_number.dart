import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/domain/provider/profile/add_profile_provider.dart';
import 'package:scribbleverse/util/constants/constants.dart';

import '../../../../config/theams/colors.dart';
import '../../../../config/theams/fonts.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({
    super.key,
    required this.tittle,
  });
  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 20),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Phone number :',
                style: normal,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(23),
          child: Consumer<AddProfileProvider>(
            builder: (context, addProfile, child) => GestureDetector(
              onTap: () {},
              child: Form(
                key: tittle == 'Add'
                    ? addProfile.phoneKey
                    : addProfile.phoneEditKey,
                child: IntlPhoneField(
                  validator: (value) {
                    if (value == null) {
                      return 'Enter valid number';
                    }
                    return null;
                  },
                  controller: addProfile.phoneController,
                  style: buttonTextDark,
                  dropdownTextStyle: buttonTextDark,
                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: black,
                  ),
                  decoration: InputDecoration(
                    errorStyle: Constants.error,
                    filled: true,
                    fillColor: white,
                    counterStyle: buttonText,
                    // labelText: 'Phone Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: white)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(width: 1)),
                    // suffixIcon: addProfile.phoneInfo == false
                    //     ? Icon(
                    //         Icons.info_outline,
                    //         color: Color.fromARGB(255, 216, 20, 6),
                    //       )
                    //     : Container()
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    if (addProfile.phoneKey.currentState!.validate()) {
                      addProfile.validateSuffixIcon('phoneNumber');
                    }
                    // else {
                    //   addProfile.validateSuffixIcon('phoneNumber');
                    // }
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
