import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticlePage({super.key, required this.article});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Не удалось открыть ссылку: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article['source']?['name'] ?? 'Статья')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(article['urlToImage']),
              ),
            const SizedBox(height: 16),
            Text(
              article['title'] ?? 'Без заголовка',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (article['author'] != null)
              Text(
                'Автор: ${article['author']}',
                style: const TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 16),
            Text(article['content'] ?? ''),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (article['url'] != null) {
                    _launchUrl(article['url']);
                  }
                },
                child: const Text('Читать полностью'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
