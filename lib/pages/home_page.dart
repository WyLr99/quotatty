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
  String quote = "Your quote will appear here";
  String author = "";
  String category = "";

  Future<void> fetchQuote() async {
    var client = http.Client();
    try {
      setState(() {
        isLoading = true;
      });
      final response = await client.get(
        Uri.parse(
            'https://api.api-ninjas.com/v1/quotes?category=$category'),
        headers: {
          'X-Api-Key': 'AMKC1GJg3X+FQTASMoFHjg==XtZC6sOWAJ7Y9voE',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          quote = jsonResponse[0]["quote"];
          author = jsonResponse[0]["author"];
        });
      } else {
        setState(() {
          quote = "Failed to load quote.Try Refreshing Your Internet";
          author = "";
        });
      }
    } catch (e) {
      print('Exception occurred: $e');
      setState(() {
        quote = "An error occurred.";
        author = "";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          'Quotatty',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: isLoading ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
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
                        DropdownButton<String>(
                          value: category.isEmpty ? "random" : category,
                          items: const [
                            DropdownMenuItem(
                              value: "random",
                              child: Text('Random'),
                            ),
                            DropdownMenuItem(
                              value: "alone",
                              child: Text('Alone'),
                            ),
                            DropdownMenuItem(
                              value: "amazing",
                              child: Text('Amazing'),
                            ),
                            DropdownMenuItem(
                              value: "art",
                              child: Text('Art'),
                            ),
                            DropdownMenuItem(
                              value: "attitude",
                              child: Text('Attitude'),
                            ),
                            DropdownMenuItem(
                              value: "beauty",
                              child: Text('Beauty'),
                            ),
                            DropdownMenuItem(
                              value: "birthday",
                              child: Text('Birthday'),
                            ),
                            DropdownMenuItem(
                              value: "change",
                              child: Text('Change'),
                            ),
                            DropdownMenuItem(
                              value: "dreams",
                              child: Text('Dreams'),
                            ),
                            DropdownMenuItem(
                              value: "education",
                              child: Text('Education'),
                            ),
                            DropdownMenuItem(
                              value: "failure",
                              child: Text('Failure'),
                            ),
                            DropdownMenuItem(
                              value: "friendship",
                              child: Text('Friendship'),
                            ),
                            DropdownMenuItem(
                              value: "graduation",
                              child: Text('Graduation'),
                            ),
                            DropdownMenuItem(
                              value: "great",
                              child: Text('Great'),
                            ),
                            DropdownMenuItem(
                              value: "happiness",
                              child: Text('Happiness'),
                            ),
                            DropdownMenuItem(
                              value: "humor",
                              child: Text('Humor'),
                            ),
                            DropdownMenuItem(
                              value: "imagination",
                              child: Text('Imagination'),
                            ),
                            DropdownMenuItem(
                              value: "inspirational",
                              child: Text('Inspirational'),
                            ),
                            DropdownMenuItem(
                              value: "love",
                              child: Text('Love'),
                            ),
                            DropdownMenuItem(
                              value: "success",
                              child: Text('Success'),
                            ),
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              if (value == "random") {
                                category = "";
                              } else {
                                category = value!;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              '"$quote"',
                              style: const TextStyle(
                                fontSize: 16,
                                
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "- $author",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        fetchQuote();
                      },
                      child: const Text('Get Quote'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
