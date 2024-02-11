import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  final String title;
  const NewsPage({super.key, required this.title});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

Map<String, dynamic> data = {};
List<dynamic> apiData = [];
bool isLoading = true;
int count = 0;

class _NewsPageState extends State<NewsPage> {
  Future<void> fetchPost() async {
    try {
      final uri = Uri.parse('http://10.0.2.2:5000/all');
      final response = await http.get(
        uri,
        // body: ({"query": "sport"}),
        // headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          apiData = data['output'];
          isLoading = false;
        });
      } else {
        throw Exception('Loading failed');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isLoading
              ? 'fetching-Info....'
              : apiData[count]['category'].toString(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        apiData[count]['title'].toString(),
                        style: const TextStyle(fontSize: 35),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Image.network(apiData[count]['url_to_image']),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          apiData[count]['description'].toString(),
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Uri apiUrl = Uri.parse(apiData[0]['url'].toString());
                  launchUrl(apiUrl);
                },
                child: const Text(
                  'http://Get-Me-Full-Info',
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.withOpacity(0.1),
                ),
                onPressed: () {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text("Work is in Progress"),
                  //   ),
                  // );
                  setState(() {
                    count = count + 1;
                  });
                },
                child: Text('next-Article'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
