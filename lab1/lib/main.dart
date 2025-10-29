import 'screens/article.dart';
import 'package:flutter/material.dart';
import 'servises/API_serv.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {  
  final TextEditingController searchController = TextEditingController();
  bool isDarkMode = false; 
  final ApiService apiService = ApiService();
  List<dynamic> articles = [];
  bool isLoading = true;

 @override
void initState() {
  super.initState();
  loadNews();
}

Future<void> loadNews() async {
  try {
    final data = await apiService.fetchTeslaNews();
    setState(() {
      articles = data;
      isLoading = false;
    });
  } catch (e) {
    print("Ошибка: $e");
    setState(() => isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(width: 10,),
            SvgPicture.asset(
              'assets/logo/logo.svg',
              height: 30,
            ),
          ],
        ),
        actions: [            
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all( // Рамка (граница)
                color: Colors.white, 
              ),  
              boxShadow: [ 
              BoxShadow(
                color: Colors.black,
                blurRadius: 4, 
                offset: Offset(0, 2), 
              ),
            ],
            ),
            child: Icon(Icons.notifications_none_outlined),
          )
        ],
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Column(
          children: [
            Container(
              // height:40,
              // width:200,
              decoration: BoxDecoration(
                
              ),
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SearchBar(
                  controller: searchController,
                  backgroundColor: WidgetStatePropertyAll( isDarkMode ? Colors.grey[900] : Colors.white,),
                  hintText: 'Search...',
                  side: WidgetStatePropertyAll(
                    BorderSide(
                      color: isDarkMode ? Colors.greenAccent : const Color(0xFF4E4B66),
                      width: 1,
                    ),
                  ),
                  elevation:const WidgetStatePropertyAll(0),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  leading: Icon(
                    Icons.search,
                    color: isDarkMode ? Colors.greenAccent : Colors.grey[700],
                  ),
                  hintStyle: const WidgetStatePropertyAll(
                    TextStyle(color: Colors.green,),
                  ),
                  textStyle: const WidgetStatePropertyAll(
                    TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  onChanged: (text) {
                    // ignore: avoid_print
                    print('Поиск: $text');
                  },
                  trailing: <Widget>[
                    Tooltip(
                      message: 'Настройки',
                      child: IconButton(
                        isSelected: isDarkMode,
                        onPressed: () {
                          setState(() {
                            isDarkMode = !isDarkMode;
                          });
                        },
                        icon: const Icon(Icons.wb_sunny_outlined),
                        selectedIcon:
                          const Icon(Icons.brightness_2_outlined, color: Colors.green),
                      )
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              height: 30,
              width: screenWidth,
              child: Row(children: [
                SizedBox(width: 24,),
                Text("Trending",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    letterSpacing: 0.12,
                  )
                ),
                SizedBox(width: 200,),
                Text('See All')

              ],),
            ),
            


            isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              shrinkWrap: true, // ✅ важно
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: article['urlToImage'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              article['urlToImage'],
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.image_not_supported),
                    title: Text(
                      article['title'] ?? 'Без заголовка',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      article['description'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticlePage(article: article),
                        ),
                      );
                    },

                  ),
                );
              },
            ),
            
            
          ]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home_mini), label: 'Not Home'),
        ],
      ),
    );
  }
}
