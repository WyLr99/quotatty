import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = false;
  Future<void> fetchQuote() async {
  var client = http.Client();
  try {
    setState(() {
      isLoading = true;
    });
    final response = await client.get(
      Uri.parse('https://api.api-ninjas.com/v1/quotes?category=$category'),
      headers: {
        'X-Api-Key': 'AMKC1GJg3X+FQTASMoFHjg==XtZC6sOWAJ7Y9voE',
      },
    );
    setState(() {
      var jsonResponse = jsonDecode(response.body);
      quote = jsonResponse[0]["quote"];
      author = jsonResponse[0]["author"];
    });

  } catch (e) {
    print('Exception occurred: $e');
  } finally {
    setState(() {
      isLoading = false;
    });
    client.close();
  }
}
  String quote = "Your quote will appear here";
  String author = "";
  String category = "";
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.blueGrey[50],
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.deepOrangeAccent,
      title: Text('Quotatty', style: TextStyle(color: Colors.white, fontSize: 24)),
    ),
    body: !isLoading ? Center( 
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Choose the category:",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              DropdownMenu(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "random", label: 'Random'),
                  DropdownMenuEntry(value: "alone", label: 'Alone'),
                  DropdownMenuEntry(value: "amazing", label: 'Amazing'),
                  DropdownMenuEntry(value: "art", label: 'Art'),
                  DropdownMenuEntry(value: "attitude", label: 'Attitude'),
                  DropdownMenuEntry(value: "beauty", label: 'Beauty'),
                  DropdownMenuEntry(value: "birthday", label: 'Birthday'),
                  DropdownMenuEntry(value: "change", label: 'Change'),
                  DropdownMenuEntry(value: "dreams", label: 'Dreams'),
                  DropdownMenuEntry(value: "education", label: 'Education'),
                  DropdownMenuEntry(value: "failure", label: 'Failure'),
                  DropdownMenuEntry(value: "friendship", label: 'Friendship'),
                  DropdownMenuEntry(value: "graduation", label: 'Graduation'),
                  DropdownMenuEntry(value: "great", label: 'Great'),
                  DropdownMenuEntry(value: "happiness", label: 'Happiness'),
                  DropdownMenuEntry(value: "humor", label: 'Humor'),
                  DropdownMenuEntry(value: "imagination", label: 'Imagination'),
                  DropdownMenuEntry(value: "inspirational", label: 'Inspirational'),
                  DropdownMenuEntry(value: "love", label: 'Love'),
                  DropdownMenuEntry(value: "success", label: 'Success'),
                ],
                initialSelection: 'random',
                onSelected: (value) {
                  setState(() {
                    if (value == "random") {
                      category = "";
                    }else category = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$quote", style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text("- $author", style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
            ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrangeAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              textStyle: const TextStyle(fontSize: 18),
            ),
            onPressed: () {
              fetchQuote();
            },
            child: const Text('Get Quote'),
          ),
        ],
      ),
    ): Center(
      child: CircularProgressIndicator(),
    ),
  );
}

}