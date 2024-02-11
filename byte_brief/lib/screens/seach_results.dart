import 'package:byte_brief/screens/tapped_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  final String text;
  const SearchScreen({super.key, required this.text});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

Map<String, dynamic> data = {};
List<dynamic> apiData = [];

class _SearchScreenState extends State<SearchScreen> {
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
      appBar: AppBar(),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 12, vertical: size.height * 0.04),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    onFieldSubmitted: (query) {
                      print(query);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(text: query),
                        ),
                      );
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search for News,Topics',
                      contentPadding: EdgeInsets.all(-7),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                height: size.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView.builder(
                      itemCount: apiData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TappedSearch(
                                  querySearched: apiData[index]['title'],
                                  imageUrl: apiData[index]['url_to_image'],
                                  des: apiData[index]['description'],
                                  category: apiData[index]['category'],
                                  pageNum: index,
                                  text: widget.text,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              ListTile(
                                leading: Image.network(
                                  apiData[index]['url_to_image'],
                                  height: 200,
                                  width: 200,
                                ),
                                title: Text(
                                  apiData[index]['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // Divider(
                              //   color: Colors.white,
                              //   thickness: 1,
                              // )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
