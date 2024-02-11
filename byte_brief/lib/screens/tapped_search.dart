import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class TappedSearch extends StatefulWidget {
  final String querySearched;
  final String imageUrl;
  final String fullContent;
  final String category;

  final String url;
  const TappedSearch(
      {super.key,
      required this.querySearched,
      required this.imageUrl,
      required this.fullContent,
      required this.category,
      required this.url});

  @override
  State<TappedSearch> createState() => _TappedSearchState();
}

Map<String, dynamic> data = {};
String apiSummary = "";
bool isLoading = true;

class _TappedSearchState extends State<TappedSearch> {
  Future<void> fetchPost() async {
    try {
      final uri = Uri.parse('http://10.0.2.2:5000/summary');
      final Map<String, dynamic> body = {"bigText": widget.fullContent};

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',

          // Set Content-Type header
        },
        body: json.encode(body), // Encode the body as JSON
      );

      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          apiSummary = data['output'];
          isLoading = false;
        });
      }
      print(data['output']);
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
        title: Text(widget.category),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.querySearched,
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
                child: Image.network(widget.imageUrl),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        data['output'],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Uri apiUrl = Uri.parse(widget.url.toString());
                launchUrl(apiUrl);
              },
              child: const Text(
                'http://Get-Me-More-Info',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
