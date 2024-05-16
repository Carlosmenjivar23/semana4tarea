import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> _newsData = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey = 'f9a54af9ab0e4038afe7774f4524fde2';
    final url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _newsData = jsonData['articles'];
      });
    } else {
      print('no cargo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HCH App'),
      ),
      body: _newsData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _newsData.length,
              itemBuilder: (context, index) {
                final article = _newsData[index];
                return ListTile(
                  title: Text(article['title']),
                  subtitle: Text(article['description'] ?? ''),
                  onTap: () {
                    
                  },
                );
              },
            ),
    );
  }
}
