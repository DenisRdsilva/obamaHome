import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:obamahome/app/models/study_level.dart';

import '../models/pagination_model.dart';
import '../models/search_models.dart';

PaginationResponse filtrarOA(PaginationResponse jsonData, String searchTerm) {
  if (searchTerm.isEmpty) {
    return jsonData;
  }

  List<Content> comparingData = jsonData.content.where((item) {
    var nome = item.nome.toLowerCase();

    return nome.contains(searchTerm.toLowerCase());
  }).toList();

  jsonData.content = comparingData;

  if (comparingData.isEmpty) {
    return jsonData;
  } else {
    return jsonData;
  }
}

Future<void> fetchData(String searchTerm, ref, page) async {
  var apiUrl = 'http://hobama.imd.ufrn.br/v1/oa?page=${page}&size=12&sort=id';

  final response = await http.get(Uri.parse(apiUrl), headers: {
    HttpHeaders.accessControlAllowOriginHeader: 'http://hobama.imd.ufrn.br/'
  });

  if (response.statusCode == 200) {
    // final jsonData = filtrarOA(jsonDecode(response.body), searchTerm);
    final jsonData = jsonDecode(response.body);

    PaginationResponse paginationResponse =
        PaginationResponse.fromJson(jsonData as Map<String, dynamic>);

    ref.read(searchPagination.notifier).state = paginationResponse;
  } else {
    print('Failed to load data. Status code: ${response.statusCode}');
    ref.read(searchPagination.notifier).state = null;
  }
}

final searchPagination = StateProvider<PaginationResponse?>((ref) {
  return null;
});

class StudyLevelsNotifier extends StateNotifier<List<String>> {
  StudyLevelsNotifier() : super([]);

  void setLevels(List<String> newLevels) {
    state = newLevels;
  }

  void addLevel(String level) {
    if (!state.contains(level)) {
      state = [...state, level];
    }
  }

  void clearLevels() {
    state = [];
  }
}

final studyLevelsProvider =
    StateNotifierProvider<StudyLevelsNotifier, List<String>>((ref) {
  return StudyLevelsNotifier();
});

Future<void> fetchLevels(WidgetRef ref) async {
  const apiUrl = 'http://hobama.imd.ufrn.br/v1/nivelensino';
  try {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      HttpHeaders.accessControlAllowOriginHeader: 'http://hobama.imd.ufrn.br/'
    });

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<String> setLevels =
          jsonData.map((level) => level["nome"] as String).toList();

      ref.read(studyLevelsProvider.notifier).setLevels(setLevels);
    } else {
      throw Exception(
          'Failed to fetch API data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
    throw Exception('Failed to fetch API data.');
  }
}


// Future<List<StudyLevelModel>> fetchLevels() async {
//   final response =
//       await http.get(Uri.parse(apiUrl));

//   if (response.statusCode == 200) {
//     final jsonData = jsonDecode(response.body);
//     final posts = jsonData
//         .map<StudyLevelModel>((item) => StudyLevelModel(
//               id: item['id'],
//               nome: item['nome'],
//             ))
//         .toList() as List<StudyLevelModel>;

//     print("nivel => $posts");

//     return posts;
//   } else {
//     return [];
//   }
// }
