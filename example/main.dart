import 'package:flutter/material.dart';
import 'package:future_list/future_list_builder.dart';
import 'package:future_list/shimmer_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureListBuilder<Location>(
      url: "https://example.com/get/locations",
      httpMethod: HttpMethod.get,
      converter: Location.fromJson,
      itemBuilder: LocationCard,
      dataPath: const ['data'],
      //The data path in the json response body.
      countPath: const ['total_count'],
      //The total count path in the json response body.
      shimmerBuilder: () =>
          const ShimmerCard(width: 1, height: 100, fillWidth: true),
      pagination: true,
      onError: (errorMessage) {
        print("Error: $errorMessage");
      },
    ));
  }

  Widget LocationCard(Location location) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: [
          Text(location.textLocation),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}

class Location {
  String textLocation;
  String id;

  Location({
    required this.textLocation,
    required this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        textLocation: json["text_location"],
        id: json["_id"],
      );
}
