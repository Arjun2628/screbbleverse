import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/domain/provider/search/user_search_provider.dart';

class SearchUsers extends StatelessWidget {
  const SearchUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(); // Show a loading indicator.
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              // Process the data from the Firestore collection.
              final data = snapshot.data!.docs;

              return YourSearchWidget(data); // Replace with your search widget.
            },
          ),
        ),
      ),
    );
  }
}

class YourSearchWidget extends StatefulWidget {
  final List<QueryDocumentSnapshot> data;

  YourSearchWidget(this.data);

  @override
  _YourSearchWidgetState createState() => _YourSearchWidgetState();
}

class _YourSearchWidgetState extends State<YourSearchWidget> {
  String query = ''; // User input

  List<QueryDocumentSnapshot> get filteredData {
    // Filter the data based on the user input (query).
    return widget.data.where((doc) {
      final title =
          doc['userName'] as String; // Adjust this to your data structure.
      return title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              query = value; // Update the query as the user types.
            });
          },
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final title = filteredData[index]['userName'] as String;

              return ListTile(
                title: Text(title),

                // Implement action when a search result is tapped.
                onTap: () {
                  // Handle the tap event (e.g., navigate to details).
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
