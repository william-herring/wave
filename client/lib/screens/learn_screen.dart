import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Learn'),
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Resources', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 32.0)),
                const SizedBox(height: 16.0),
                Expanded(
                  child: ListView(
                    children: [
                      ResourceItem(url: 'https://www.sciencelearn.org.nz/resources/573-measuring-sound', title: 'Measuring sound', source: 'sciencelearn.org.nz', thumbnail: Image.network('https://static.sciencelearn.org.nz/images/images/000/000/605/original/Graphs-of-sound-waves20151209_v2.jpg?1568601846', scale: 1.8)),
                      ResourceItem(url: 'https://www.nasa.gov/specials/X59/science-of-sound.html', title: "What's the science of sound?", source: 'NASA', thumbnail: Image.network('https://i.ytimg.com/vi/G-KGTambZtI/maxresdefault.jpg')),
                      ResourceItem(url: 'https://www.pasco.com/products/guides/sound-waves', title: "Sound waves", source: 'PASCO', thumbnail: Image.network('https://www.pasco.com/media/files/static/guides/sound-direction-of-sound-waves-01.png')),
                    ],
                  ),
                )
              ]
          ),
        )
    );
  }
}

class ResourceItem extends StatelessWidget {
  final String url;
  final String title;
  final String source;
  final Image thumbnail;
  const ResourceItem({Key? key, required this.url, required this.title, required this.source, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Text(source, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200, color: Theme.of(context).primaryColor.withOpacity(0.7))),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Center(
                    child: thumbnail
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.black.withOpacity(0.5)
        ),
      ),
    );
  }
}
