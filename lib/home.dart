import 'dart:convert';

import 'package:episode_api/constant_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
//Mode Specific Function for get API is at the end of this file
var todo = [];
Future<List<dynamic>> getDataFromApi(String apiUrl) async {
  try {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData is List) {
        todo = jsonData;
        return todo;
      } else if (jsonData.containsKey("todos")) {
        todo = jsonData["todos"] as List<dynamic>;
        return todo;
      } else {
        throw Exception("API response format is not recognized");
      }
    } else {
      throw Exception("API request failed with status ${response.statusCode}");
    }
  } catch (e) {
    print("An error occurred: $e");
    throw Exception("An error occurred: $e");
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Red With Sharjeel"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                getDataFromApi(APILinks.todo);
              },
              child: Text("Get")),
          Text(todo.length.toString()),
          Expanded(
            child: ListView.builder(
              itemCount: todo.length,
              itemBuilder: (context, i) {
                {
                  return ListTile(
                    title: Text(todo[i]['email'].toString()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Mode Specific Function for get API
// List<TodoModel> todo = [];
// Future getDataFromApi(String apiUrl) async {
//   try {
//     var url = Uri.parse(apiUrl);
//     var response = await http.get(url);
//     print("API Response Status Code: ${response.statusCode}");
//     print("API Response Body: ${response.body}");
//     if (response.statusCode == 200) {
//       List<dynamic> jsonData = json.decode(response.body);
//       if (jsonData is List) {
//           todo= jsonData.map((e) => TodoModel.fromJson(e)).toList();
//         return todo;
//       } else {
//         throw Exception("API response format is not recognized");
//       }
//     } else {
//       throw Exception("API request failed with status ${response.statusCode}");
//     }
//   } catch (e) {
//     print("An error occurred: $e");
//     throw Exception("An error occurred: $e");
//   }
// }