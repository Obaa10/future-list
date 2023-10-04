import 'package:flutter/material.dart';
import 'package:future_list/future_list_builder.dart';
import 'package:future_list/shimmer_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureListBuilder<Art>(
            url: "https://api.artic.edu/api/v1/artworks",
            httpMethod: HttpMethod. get,
            converter: Art.fromJson,
            itemBuilder: (data) => ArtCard(art: data),
            dataPath: const ['data'],
            countPath: const ['pagination', 'total'],
            skipKey: 'page',
            pagination: true,
            shimmerBuilder: () =>
                const ShimmerCard(width: 1, height: 150, fillWidth: true),
            onError: (error) {
              return const Text("Some thing get wrong!");
            },
          )),
    );
  }
}

class ArtCard extends StatelessWidget {
  const ArtCard({super.key, required this.art});

  final Art art;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.black12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(art.title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("id: ${art.id.toString()}", style: const TextStyle(fontSize: 12)),
              Text("disable data: ${art.dateDisplay}",
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 15),
              const Text("artist display:",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.brown)),
              const SizedBox(height: 3),
              Text(art.artistDisplay, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}

class Art {
  int id;
  String apiModel;
  String apiLink;
  bool isBoosted;
  String title;
  String dateDisplay;
  String artistDisplay;

  Art({
    required this.id,
    required this.apiModel,
    required this.apiLink,
    required this.isBoosted,
    required this.title,
    required this.dateDisplay,
    required this.artistDisplay,
  });

  factory Art.fromJson(Map<String, dynamic> json) => Art(
        id: json["id"],
        apiModel: json["api_model"],
        apiLink: json["api_link"],
        isBoosted: json["is_boosted"],
        title: json["title"],
        dateDisplay: json["date_display"],
        artistDisplay: json["artist_display"],
      );
}
