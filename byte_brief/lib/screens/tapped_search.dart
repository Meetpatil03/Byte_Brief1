import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TappedSearch extends StatefulWidget {
  final String querySearched;
  final String imageUrl;
  final String des;
  final String category;
  final int pageNum;
  final String text;
  const TappedSearch(
      {super.key,
      required this.querySearched,
      required this.imageUrl,
      required this.des,
      required this.category,
      required this.pageNum,
      required this.text});

  @override
  State<TappedSearch> createState() => _TappedSearchState();
}

Map<String, dynamic> data = {};
List<dynamic> apiData = [];

class _TappedSearchState extends State<TappedSearch> {
  Future<void> fetchPost() async {
    try {
      final uri = Uri.parse('http://10.0.2.2:5000/search');
      final Map<String, dynamic> body = {"query": widget.text};

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Connection': 'Keep-Alive'
          // Set Content-Type header
        },
        body: json.encode(body), // Encode the body as JSON
      );

      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          apiData = data['output'];
        });
      }

      print(apiData);
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
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.des,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(children: []),
      ),
    );
  }
}
