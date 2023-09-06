
// class SearchWidget extends SearchDelegate {
//   @override
//   String get searchFieldLabel => "Search products,category";

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: carditems,
//       builder:
//           ((BuildContext context, List<UserModel> studentList, Widget? child) {
//         List<UserModel> searchItems = [];

//         for (var element in studentList) {
//           if (element.userName!.toLowerCase().contains(query.toLowerCase().trim()) 
//               ) {
//             searchItems.add(element);
//           }
//         }
//         return searchItems.isNotEmpty
//             ? ListView.separated(
//                 itemBuilder: itemBuilder,
//                 separatorBuilder: separatorBuilder,
//                 itemCount: itemCount,
//               )
//             : const Center(
//                 child: Text('No data'),
//               );
//       }),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: carditems,
//       builder:
//           ((BuildContext context, List<UserModel> studentList, Widget? child) {
//         List<UserModel> searchItems = [];

//         for (var element in studentList) {
//           if (element.userName!.toLowerCase().contains(query.toLowerCase().trim())) {
//             searchItems.add(element);
//           }
//         }
//         return searchItems.isNotEmpty
//             ? 
//             : const Center(
//                 child: Text('No data'),
//               );

//         // ListModel();
//       }),
//     );
//   }
// }
