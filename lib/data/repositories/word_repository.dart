import 'dart:convert';

import 'package:scribbleverse/data/datasources/remote/dictionart_api.dart';

import '../../domain/models/word_response.dart';

// class WordRepository {
//   Future<List<WordDefinition>> getWordFromDictionary(String query) async {
//     final response = await HttpService.getRequest("en/$query");

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       final List<WordDefinition> words = [];
//       WordDefinition? word;
//       for (final jsonItem in jsonList) {
//         print(jsonItem['']);
//         final word = WordDefinition.fromJson(jsonItem);
//         final word1 = Meaning.fromJson(jsonItem);
//         words.add(word);
//       }

//       return words;
//     } else {
//       throw Exception('Failed to load word definitions');
//     }
//   }
// }
class WordRepository {
  Future<String> getWordFromDictionary(String query) async {
    final response = await HttpService.getRequest("en/$query");

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<WordDefinition> words = [];

      for (final jsonItem in jsonList) {
        final word = WordDefinition.fromJson(jsonItem);

        // Check if 'meanings' exists and is a list
        if (jsonItem['meanings'] is List<dynamic>) {
          final meaningsList = jsonItem['meanings'] as List<dynamic>;
          for (final meaningItem in meaningsList) {
            final meaning = Meaning.fromJson(meaningItem);

            // Check if 'definitions' exists and is a list
            if (meaningItem['definitions'] is List<dynamic>) {
              final definitionsList =
                  meaningItem['definitions'] as List<dynamic>;

              // Check if there is at least one definition
              if (definitionsList.isNotEmpty) {
                final definition = definitionsList[0];
                // Check if 'definition' is a string
                print(definition['definition']);
                return definition['definition'];
                print('Definition: $definition');
                if (definition is String) {
                  print('Definition: $definition');
                }
              }
            }

            words.add(word);
          }
        }
      }

      return 'no data';
    } else {
      throw Exception('Failed to load word definitions');
    }
  }
}
