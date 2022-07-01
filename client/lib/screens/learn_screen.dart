import 'package:flutter/material.dart';

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
                      ResourceItem(title: 'Measuring sound', source: 'sciencelearn.org.nz', thumbnail: Image.network('https://static.sciencelearn.org.nz/images/images/000/000/605/original/Graphs-of-sound-waves20151209_v2.jpg?1568601846', scale: 1.8)),
                      ResourceItem(title: "What's the science of sound?", source: 'NASA', thumbnail: Image.network('https://i.ytimg.com/vi/G-KGTambZtI/maxresdefault.jpg')),
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
  final String title;
  final String source;
  final Image thumbnail;
  const ResourceItem({Key? key, required this.title, required this.source, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
