


// class EditProfileProvider extends ChangeNotifier {
//   bool male = false;
//   bool female = false;
//   bool others = false;
//   String? genderName;
//   String imageUri = '';
//   File? photo;
//   String formateDate = 'Month / Day / Year';
//   bool errorImage = false;
//   // final userKey = GlobalKey<FormState>();
//   // final aboutKey = GlobalKey<FormState>();
//   // final phoneKey = GlobalKey<FormState>();
//   bool userNameInfo = false;
//   bool phoneInfo = false;
//   bool aboutInfo = false;
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController aboutController = TextEditingController();

//   // profile adding section

//   dateTimeSelection(String date) {
//     formateDate = date;
//     notifyListeners();
//   }

//   genderSelection(String gender) {
//     if (gender == 'male') {
//       male = true;
//       female = false;
//       others = false;
//       genderName = 'male';
//     } else if (gender == 'female') {
//       male = false;
//       female = true;
//       others = false;
//       genderName = 'female';
//     } else {
//       male = false;
//       female = false;
//       others = true;
//       genderName = 'other';
//     }
//     notifyListeners();
//   }

//   Future<void> selectDate(BuildContext context) async {
//     DateTime selectedDate = DateTime.now();
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null && picked != selectedDate) {
//       selectedDate = picked;
//       String formattedDate = DateFormat.yMd().format(selectedDate);
//       dateTimeSelection(formattedDate);
//     }

//     notifyListeners();
//   }

//   Future<void> addProfile(Map<String, dynamic> data) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(auth.currentUser!.uid)
//         .set(data);
//   }

//   //image selection section

//   Future getImage(ImageSource source) async {
//     final image = await ImagePicker().pickImage(source: source);
//     if (image != null) {
//       final phototemp = File(image.path);

//       photo = phototemp;
//       notifyListeners();
//     } else {
//       return;
//     }
//   }

//   Future<void> cloudAdd(File file) async {
//     final Reference storageref = FirebaseStorage.instance
//         .ref()
//         .child('userProfiles/${DateTime.now().millisecondsSinceEpoch}');

//     final UploadTask uploadTask = storageref.putFile(file);
//     TaskSnapshot snap = await uploadTask;

//     final String downloadUrl = await snap.ref.getDownloadURL();
//     imageUri = downloadUrl;
//     notifyListeners();
//   }

//   Future<dynamic> selectPhoto(BuildContext context) async {
//     await showModalBottomSheet(
//         backgroundColor: black,
//         context: context,
//         builder: ((context) => BottomSheet(
//             elevation: 0.5,
//             backgroundColor: Colors.black26,
//             onClosing: () {},
//             builder: ((context) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ListTile(
//                     leading: const Icon(
//                       Icons.camera,
//                       color: white,
//                     ),
//                     title: Text(
//                       'Camara',
//                       style: normal,
//                     ),
//                     onTap: () async {
//                       Navigator.of(context).pop();
//                       getImage(ImageSource.camera);
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.filter,
//                       color: white,
//                     ),
//                     title: Text(
//                       'Gallery',
//                       style: normal,
//                     ),
//                     onTap: () async {
//                       Navigator.of(context).pop();
//                       getImage(ImageSource.gallery);
//                     },
//                   )
//                 ],
//               );
//             }))));
//     notifyListeners();
//   }

//   bool a = false;
//   Future<void> validate() async {
//     if (photo == null) {
//     } else if (genderName != null) {
//     } else {}
//   }
//   // validation section

//   validationImage(String value) {
//     if (value == 'true') {
//       errorImage = true;
//     } else {
//       errorImage = false;
//     }

//     notifyListeners();
//   }

//   validateSuffixIcon(String fieldType) {
//     if (fieldType == 'userName') {
//       userNameInfo = !userNameInfo;
//       phoneInfo = false;
//       aboutInfo = false;
//     } else if (fieldType == 'phoneNumber') {
//       userNameInfo = false;
//       phoneInfo = !phoneInfo;
//       aboutInfo = false;
//     } else {
//       userNameInfo = false;
//       phoneInfo = false;
//       aboutInfo = !aboutInfo;
//     }
//     notifyListeners();
//   }
// }
