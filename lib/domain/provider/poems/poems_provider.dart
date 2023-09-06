import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/models/user_moder.dart';
import 'package:uuid/uuid.dart';

class AddPoemProvider extends ChangeNotifier {
  TextEditingController addPoemController = TextEditingController();
  TextEditingController addPoemHeadController = TextEditingController();
  TextEditingController addPoemFinalController = TextEditingController();
  TextEditingController addPoemHeadFinalController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  TextAlign textAlign = TextAlign.center;
  TextAlign textAlignHead = TextAlign.center;
  dynamic selectionarea;
  String template = 'lib/data/datasources/local/images/Screenshot (81).png';
  String? pickTemplate;

  List<String> templateList = [
    'lib/data/datasources/local/images/Screenshot (81).png',
    'lib/data/datasources/local/images/Screenshot (83).png',
    'lib/data/datasources/local/images/Screenshot (85).png',
    'lib/data/datasources/local/images/Screenshot (87).png',
    'lib/data/datasources/local/images/picture-icon-vector-35103829.jpg'
  ];
  int templateIndex = 0;
  int startSelection = -1;
  int endSelection = -1;
  Color headingColor = Colors.black;
  Color contentColor = Colors.black;
  String imageUri = '';
  File? photo;
  String image = '';
  String selectedFont = "Roboto";
  TextStyle? selectedFontTextStyle =
      TextStyle(fontFamily: 'Lato-Regular').copyWith(
    color: black,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    fontSize: 20,
    fontStyle: FontStyle.normal,
  );
  TextStyle? selectedFontTextStyleHeading =
      const TextStyle(fontFamily: 'Lato-Regular').copyWith(
    color: black,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    fontSize: 20,
    fontStyle: FontStyle.normal,
  );
  String currentFont = 'Lato-Regular';
  String currentFontHeading = 'Lato-Regular';

  PickerFont? fontStyle;
  TextStyle? styleFont = const TextStyle(fontFamily: 'Lato-Regular');
  TextStyle? styleFontHeading = const TextStyle(fontFamily: 'Lato-Regular');
  bool italic = false;
  bool underline = false;
  bool bold = false;
  bool headingItalic = false;
  bool headingUnderline = false;
  bool headingBold = false;
  String fontSize = '20';
  int fontSizeCount = 20;
  String fontSizeHead = '20';
  int fontSizeCountHead = 20;
  double sliderValue = 80;
  double backgroundOpacity = 0.8;
  FocusNode headingFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();
  bool focusHead = false;
  bool focusContent = false;

  final List<String> myGoogleFonts = [
    "Abril Fatface",
    "Aclonica",
    "Alegreya Sans",
    "Architects Daughter",
    "Archivo",
    "Archivo Narrow",
    "Bebas Neue",
    "Bitter",
    "Bree Serif",
    "Bungee",
    "Cabin",
    "Cairo",
    "Coda",
    "Comfortaa",
    "Comic Neue",
    "Cousine",
    "Croissant One",
    "Faster One",
    "Forum",
    "Great Vibes",
    "Heebo",
    "Inconsolata",
    "Josefin Slab",
    "Lato",
    "Libre Baskerville",
    "Lobster",
    "Lora",
    "Merriweather",
    "Montserrat",
    "Mukta",
    "Nunito",
    "Offside",
    "Open Sans",
    "Oswald",
    "Overlock",
    "Pacifico",
    "Playfair Display",
    "Poppins",
    "Raleway",
    "Roboto",
    "Roboto Mono",
    "Source Sans Pro",
    "Space Mono",
    "Spicy Rice",
    "Squada One",
    "Sue Ellen Francisco",
    "Trade Winds",
    "Ubuntu",
    "Varela",
    "Vollkorn",
    "Work Sans",
    "Zilla Slab",
  ];
  List<String> fontList = <String>['One', 'Two', 'Three', 'Four'];

  Future<void> selectionHandling(
    int start,
    int end,
  ) async {
    startSelection = start;
    endSelection = end;
    String text = addPoemController.text;

    addPoemController.text.substring(
      startSelection,
      endSelection,
    );

    final String text1 = addPoemController.text;
    final TextSpan newText = TextSpan(
      children: [
        TextSpan(text: text.substring(0, startSelection)),
        TextSpan(
          text: text.substring(startSelection, endSelection),
          style: TextStyle(color: Colors.amber), // Apply selected text color
        ),
        TextSpan(text: text.substring(endSelection)),
      ],
    );

    addPoemController.value = TextEditingValue(
      text: newText.toPlainText(),
      selection: TextSelection.collapsed(offset: endSelection),
    );

    notifyListeners();
  }

  finalOutText() {
    addPoemFinalController.text = addPoemController.text;
    addPoemHeadFinalController.text = addPoemHeadController.text;
    notifyListeners();
  }

  focus(String value) {
    if (value == 'heading') {
      focusHead = true;
      focusContent = false;
    } else {
      focusHead = false;
      focusContent = true;
    }
    notifyListeners();
  }

  Future<int> getLike(String docId) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('posts')
        .doc(docId)
        .collection('likes')
        .get();

    return snapshot.docs.length;
  }

  void colorArea(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select Area'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    openColorPicker(context, 'heading');
                    // Navigator.pop(context);
                  },
                  child: const Text('Heading')),
              ElevatedButton(
                  onPressed: () {
                    openColorPicker(context, 'content');
                    // Navigator.pop(context);
                  },
                  child: const Text('Content'))
            ],
          );
        });
    notifyListeners();
  }

  void openColorPicker(BuildContext context, String area) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: area == 'heading' ? headingColor : contentColor,
              onColorChanged: (color) {
                if (area == 'heading') {
                  headingColor = color;
                  selectedFontTextStyleHeading = styleFont!.copyWith(
                    color: headingColor,
                  );
                  notifyListeners();
                } else {
                  contentColor = color;
                  selectedFontTextStyle = styleFont!.copyWith(
                    color: contentColor,
                  );

                  notifyListeners();
                }
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    notifyListeners();
  }

  Future<void> pickFont(BuildContext context, String area) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Consumer<AddPoemProvider>(
                builder: (context, value, child) => area == 'content'
                    ? FontPicker(
                        showInDialog: true,
                        initialFontFamily: 'Anton',
                        onFontChanged: (font) {
                          selectedFont = font.fontFamily;
                          styleFont = font.toTextStyle();
                          selectedFontTextStyle = styleFont!.copyWith(
                            color: value.contentColor,
                          );
                          currentFont =
                              selectedFontTextStyle!.fontFamily.toString();
                          fontStyle = font;
                          debugPrint(
                            "${font.fontFamily} with font weight ${font.fontWeight} and font style ${font.fontStyle}. FontSpec: ${font.toFontSpec()}",
                          );
                          notifyListeners();
                        },
                        googleFonts: myGoogleFonts,
                      )
                    : FontPicker(
                        showInDialog: true,
                        initialFontFamily: 'Anton',
                        onFontChanged: (font) {
                          selectedFont = font.fontFamily;
                          styleFontHeading = font.toTextStyle();
                          selectedFontTextStyleHeading =
                              styleFontHeading!.copyWith(
                            color: value.headingColor,
                          );
                          currentFontHeading =
                              selectedFontTextStyle!.fontFamily.toString();
                          fontStyle = font;
                          debugPrint(
                            "${font.fontFamily} with font weight ${font.fontWeight} and font style ${font.fontStyle}. FontSpec: ${font.toFontSpec()}",
                          );
                          notifyListeners();
                        },
                        googleFonts: myGoogleFonts,
                      ),
              ),
            ),
          ),
        );
      },
    );
    notifyListeners();
  }

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      final phototemp = File(image.path);

      photo = phototemp;
      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> templateSelection(int index) async {
    if (index == 0) {
      template = 'lib/data/datasources/local/images/Screenshot (81).png';
      templateIndex = 0;
    } else if (index == 1) {
      template = 'lib/data/datasources/local/images/Screenshot (83).png';
      templateIndex = 1;
    } else if (index == 2) {
      template = 'lib/data/datasources/local/images/Screenshot (85).png';
      templateIndex = 2;
    } else if (index == 3) {
      template = 'lib/data/datasources/local/images/Screenshot (87).png';
      templateIndex = 3;
    } else if (index == 4) {
      templateIndex = 4;
      await getImage(ImageSource.gallery);
    }
    notifyListeners();
  }

  Future<void> bottomSheetIconSelection(String selected, String area) async {
    if (selected == 'center') {
      await textAlignment(selected, area);
    } else if (selected == 'normal') {
      await textAlignment(selected, area);
    } else if (selected == 'left') {
      await textAlignment(selected, area);
    } else if (selected == 'right') {
      await textAlignment(selected, area);
    }
    notifyListeners();
  }

  Future<void> bottomSheetIconSelectionStyling(
      String selected, String area) async {
    if (selected == 'bold') {
      await boldText(area);
    } else if (selected == 'italic') {
      await fonttItalic(area);
    } else if (selected == 'underline') {
      await underlineText(area);
    } else if (selected == 'color') {}

    notifyListeners();
  }

  Future<void> textAlignment(String alignment, String area) async {
    if (area == 'heading') {
      if (alignment == 'center') {
        textAlignHead = TextAlign.center;
      } else if (alignment == 'normal') {
        textAlignHead = TextAlign.start;
      } else if (alignment == 'left') {
        textAlignHead = TextAlign.left;
      } else if (alignment == 'right') {
        textAlignHead = TextAlign.right;
      }
    } else {
      if (alignment == 'center') {
        textAlign = TextAlign.center;
      } else if (alignment == 'normal') {
        textAlign = TextAlign.start;
      } else if (alignment == 'left') {
        textAlign = TextAlign.left;
      } else if (alignment == 'right') {
        textAlign = TextAlign.right;
      }
    }
    notifyListeners();
  }

  //! font styling

  // font italic
  fonttItalic(String area) {
    if (area == 'heading') {
      if (headingItalic == false) {
        selectedFontTextStyleHeading = styleFontHeading!.copyWith(
            color: headingColor,
            fontSize: fontSizeCountHead.toDouble(),
            fontWeight:
                headingBold == false ? FontWeight.normal : FontWeight.bold,
            decoration: headingUnderline == false
                ? TextDecoration.none
                : TextDecoration.underline,
            fontStyle: FontStyle.italic);
        headingItalic = true;
        notifyListeners();
      } else {
        selectedFontTextStyleHeading = styleFontHeading!.copyWith(
          color: headingColor,
          fontWeight:
              headingBold == false ? FontWeight.normal : FontWeight.bold,
          decoration: headingUnderline == false
              ? TextDecoration.none
              : TextDecoration.underline,
          fontSize: fontSizeCountHead.toDouble(),
          fontStyle: FontStyle.normal,
        );
        headingItalic = false;
        notifyListeners();
      }
    } else {
      if (italic == false) {
        selectedFontTextStyle = styleFont!.copyWith(
            color: contentColor,
            fontSize: fontSizeCount.toDouble(),
            fontWeight: bold == false ? FontWeight.normal : FontWeight.bold,
            decoration: underline == false
                ? TextDecoration.none
                : TextDecoration.underline,
            fontStyle: FontStyle.italic);
        italic = true;
        notifyListeners();
      } else {
        selectedFontTextStyle = styleFont!.copyWith(
          color: contentColor,
          fontWeight: bold == false ? FontWeight.normal : FontWeight.bold,
          decoration: underline == false
              ? TextDecoration.none
              : TextDecoration.underline,
          fontSize: fontSizeCount.toDouble(),
          fontStyle: FontStyle.normal,
        );
        italic = false;
        notifyListeners();
      }
    }
  }

  String colorToString(Color color) {
    return "Color(0x${color.value.toRadixString(16).padLeft(8, '0')})";
  }

  // text underline

  underlineText(String area) {
    if (area == 'heading') {
      if (headingUnderline == false) {
        selectedFontTextStyleHeading = styleFontHeading!.copyWith(
          color: headingColor,
          fontStyle:
              headingItalic == false ? FontStyle.normal : FontStyle.italic,
          fontSize: fontSizeCountHead.toDouble(),
          fontWeight:
              headingBold == false ? FontWeight.normal : FontWeight.bold,
          decoration: TextDecoration.underline,
        );
        headingUnderline = true;
        notifyListeners();
      } else {
        selectedFontTextStyleHeading = styleFontHeading!.copyWith(
          color: headingColor,
          fontStyle:
              headingItalic == false ? FontStyle.normal : FontStyle.italic,
          fontSize: fontSizeCountHead.toDouble(),
          fontWeight:
              headingBold == false ? FontWeight.normal : FontWeight.bold,
        );
        headingUnderline = false;
        notifyListeners();
      }
    } else {
      if (underline == false) {
        selectedFontTextStyle = styleFont!.copyWith(
          color: contentColor,
          fontStyle: italic == false ? FontStyle.normal : FontStyle.italic,
          fontSize: fontSizeCount.toDouble(),
          fontWeight: bold == false ? FontWeight.normal : FontWeight.bold,
          decoration: TextDecoration.underline,
        );
        underline = true;
        notifyListeners();
      } else {
        selectedFontTextStyle = styleFont!.copyWith(
          color: contentColor,
          fontStyle: italic == false ? FontStyle.normal : FontStyle.italic,
          fontSize: fontSizeCount.toDouble(),
          fontWeight: bold == false ? FontWeight.normal : FontWeight.bold,
        );
        underline = false;
        notifyListeners();
      }
    }
  }

  // bold text

  boldText(String area) {
    if (area == 'heading') {
      if (headingBold == false) {
        selectedFontTextStyleHeading = styleFontHeading!.copyWith(
            color: headingColor,
            fontStyle:
                headingItalic == false ? FontStyle.normal : FontStyle.italic,
            decoration: headingUnderline == false
                ? TextDecoration.none
                : TextDecoration.underline,
            fontSize: fontSizeCountHead.toDouble(),
            fontWeight: FontWeight.bold);
        headingBold = true;
        notifyListeners();
      } else {
        selectedFontTextStyleHeading = styleFontHeading!.copyWith(
          color: headingColor,
          fontStyle:
              headingItalic == false ? FontStyle.normal : FontStyle.italic,
          decoration: headingUnderline == false
              ? TextDecoration.none
              : TextDecoration.underline,
          fontSize: fontSizeCountHead.toDouble(),
          fontWeight: FontWeight.normal,
        );
        headingBold = false;
        notifyListeners();
      }
    } else {
      if (bold == false) {
        selectedFontTextStyle = styleFont!.copyWith(
            color: contentColor,
            fontStyle: italic == false ? FontStyle.normal : FontStyle.italic,
            decoration: underline == false
                ? TextDecoration.none
                : TextDecoration.underline,
            fontSize: fontSizeCount.toDouble(),
            fontWeight: FontWeight.bold);
        bold = true;
        notifyListeners();
      } else {
        selectedFontTextStyle = styleFont!.copyWith(
          color: contentColor,
          fontStyle: italic == false ? FontStyle.normal : FontStyle.italic,
          decoration: underline == false
              ? TextDecoration.none
              : TextDecoration.underline,
          fontSize: fontSizeCount.toDouble(),
          fontWeight: FontWeight.normal,
        );
        bold = false;
        notifyListeners();
      }
    }
  }

  // font size
  selectFontSize(String type, String area) {
    if (area == 'heading') {
      if (type == 'add') {
        if (fontSizeCountHead != 50) {
          fontSizeCountHead++;
          fontSizeHead = fontSizeCountHead.toString();
        } else {
          fontSizeCountHead = 50;
          fontSizeHead = fontSizeCountHead.toString();
        }
      } else {
        if (fontSizeCountHead != 0) {
          fontSizeCountHead--;
          fontSizeHead = fontSizeCountHead.toString();
        } else {
          fontSizeCountHead = 0;
          fontSizeHead = fontSizeCountHead.toString();
        }
      }
      selectedFontTextStyleHeading = styleFontHeading!.copyWith(
          color: headingColor,
          fontStyle: italic == false ? FontStyle.normal : FontStyle.italic,
          decoration: underline == false
              ? TextDecoration.none
              : TextDecoration.underline,
          fontWeight: bold == false ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSizeCountHead.toDouble());
      notifyListeners();
    } else {
      if (type == 'add') {
        if (fontSizeCount != 50) {
          fontSizeCount++;
          fontSize = fontSizeCount.toString();
        } else {
          fontSizeCount = 50;
          fontSize = fontSizeCount.toString();
        }
      } else {
        if (fontSizeCount != 0) {
          fontSizeCount--;
          fontSize = fontSizeCount.toString();
        } else {
          fontSizeCount = 0;
          fontSize = fontSizeCount.toString();
          notifyListeners();
        }
      }
      selectedFontTextStyle = styleFont!.copyWith(
          color: contentColor,
          fontStyle: italic == false ? FontStyle.normal : FontStyle.italic,
          decoration: underline == false
              ? TextDecoration.none
              : TextDecoration.underline,
          fontWeight: bold == false ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSizeCount.toDouble());
      notifyListeners();
    }
  }

  // slider

  selectSlider(double value) {
    sliderValue = value;
    backgroundOpacity = value / 100;
    notifyListeners();
  }

  // get_photo

  Future<void> cloudAdd(File file) async {
    final Reference storageref = FirebaseStorage.instance
        .ref()
        .child('userProfiles/${DateTime.now().millisecondsSinceEpoch}');

    final UploadTask uploadTask = storageref.putFile(file);
    TaskSnapshot snap = await uploadTask;

    final String downloadUrl = await snap.ref.getDownloadURL();
    imageUri = downloadUrl;
    notifyListeners();
  }

  String poemTimeDifference(Duration duration) {
    if (duration.inHours < 1) {
      // Within 1 hour, show minutes
      return '${duration.inMinutes} minutes ago';
    } else if (duration.inHours < 24) {
      // Within 24 hours, show hours
      if (duration.inHours < 2) {
        return '${duration.inHours} hour ago';
      }
      return '${duration.inHours} hours ago';
    } else {
      // More than 24 hours, show days
      return '${duration.inDays} days ago';
    }
  }

  Future<void> addPoem(UserModel? user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (templateIndex == 4) {
      if (photo != null) {
        await cloudAdd(photo!);
      }
    }
    String uuid = Uuid().v1();
    DateTime poemAddingTime = DateTime.now();
    String colorHeading = colorToString(headingColor);
    String colorContent = colorToString(contentColor);
    Map<String, dynamic> data = {
      'heading': addPoemHeadController.text,
      'content': addPoemController.text,
      'heading_fontsize': fontSizeCountHead,
      'content_fontsize': fontSizeCount,
      'heading_fontfamily': currentFontHeading,
      'content_fontfamily': currentFont,
      'heading_bold': headingBold,
      'content_bold': bold,
      'heading_italic': headingItalic,
      'content_italic': italic,
      'heading_underline': headingUnderline,
      'content_underline': underline,
      'heading_color': colorHeading,
      'content_color': colorContent,
      'heading_alignment': textAlignHead.toString(),
      'content_alignment': textAlign.toString(),
      'background_opacity': sliderValue,
      'template_index': templateIndex,
      'background_image': imageUri,
      'caption': captionController.text,
      'date_and_time': poemAddingTime,
      'user_profile_image': user!.profileImage,
      'user_name': user.userName,
      'user_about': user.about,
      'user_id': auth.currentUser!.uid,
      'poem_id': uuid,
      'number_of_likes': 0
    };
    Map<String, dynamic> poemsData = {
      'number_of_poems': 0,
      'number_of_comments': 0,
      'number_of_likes': 0
    };

    await FirebaseFirestore.instance.collection('poems').doc(uuid).set(data);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('posts')
        .doc('poems')
        .collection('poems')
        .doc(uuid)
        .set(data);
    // .add(data);
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(auth.currentUser!.uid)
    //     .collection('posts')
    //     .doc('poems')
    //     .set(poemsData);

    print('success');
  }
}
