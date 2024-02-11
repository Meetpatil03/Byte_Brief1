import 'package:byte_brief/screens/news_page.dart';
import 'package:byte_brief/screens/seach_results.dart';
import 'package:byte_brief/widgets/custom_font.dart';
import 'package:byte_brief/widgets/logo_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> topics = [
  'news',
  'technology',
  'coding',
  'hiking',
  'food & travels',
  'cricket',
  'football',
  'Defense'
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const CustomFont(
            text: 'ByteBrief',
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontStyle: FontStyle.italic),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Setting Work is in Progress"),
              ),
            );
          },
          icon: const Icon(
            Icons.settings_outlined,
            color: Colors.blue,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsPage(title: 'trail'),
                ),
              );
            },
            child: const Row(
              children: [
                Text(
                  'My Feed',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
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
                      if (query.isEmpty) {
                        return;
                      }
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
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Work is in Progress for News'),
                        ),
                      );
                    },
                    child: const LogoText(
                      imagePath: 'assets/images/news.png',
                      title: 'News',
                      widht: 55,
                      hieght: 55,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Work is in Progress for Recommendation"),
                        ),
                      );
                    },
                    child: const LogoText(
                      imagePath: 'assets/images/recommendation.png',
                      title: 'Recommendation',
                      widht: 55,
                      hieght: 55,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Work is Progress for Bookmarks"),
                        ),
                      );
                    },
                    child: const LogoText(
                      imagePath: 'assets/images/bookmark.png',
                      title: 'Bookmark',
                      widht: 55,
                      hieght: 55,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Topics',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'VIEW ALL',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 1,
                            crossAxisSpacing: 35,
                            mainAxisSpacing: 20),
                    itemCount: topics.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Work is in Progress for ${topics[index]}"),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            topics[index],
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
