# Future List

Future List is a powerful Flutter package that simplifies the process of displaying dynamic lists in
your Flutter applications. With Future List, you can effortlessly generate list views from a single
URL, complete with automatic pagination, shimmer effects, and a range of advanced features.


## Live demo

<div   style="text-align:center">
  <video height="350" src="https://github-production-user-asset-6210df.s3.amazonaws.com/70761777/273432578-8731a2aa-11fb-4997-8045-09e43d676de7.mp4"></video>
</div>

## Features

- **Effortless Pagination**: Future List takes care of pagination for you, automatically fetching
  and displaying new data as the user scrolls, ensuring a seamless browsing experience.

- **Shimmer Effects**: Enhance the visual appeal of your list views with built-in shimmer effects,
  making the loading process more engaging and user-friendly.

- **Customizable**: Future List provides a range of options to customize the appearance and behavior
  of your list views, allowing you to tailor them to fit your app's unique design and requirements.

- **Error Handling**: Handle errors and fallback scenarios gracefully with Future List's error
  handling capabilities, providing a smooth user experience even in case of network or data issues.

- **Flexible Integration**: Integrate Future List into your existing Flutter projects with ease,
  thanks to its intuitive and straightforward API.

## How to use

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  future_list: ^1.0.5
```

```dart
import 'package:future_list/future_list_builder.dart';
```

## Examples

### Simple example

```dart
  FutureListBuilder<Book>(
    url: "https://example.com/get/data",
    httpMethod: HttpMethod.get,
    converter: (json) {
     //Function to convert from json to Book Object.
    },
    itemBuilder: (data) {
     //Function to return card widget for the data Book.
    },
    dataPath: ['data'],  //The data path in the json response body.
    shimmerBuilder: () => ShimmerCard(width: 200, height: 100),
  )
```

In this example we get data from https://example.com/get/data
with Http get method. <br>
and we user the build in ShimmerCard you can read more about it in the docs, <br>
In this example the response body should be

```json
{
  "data": ["item1", "item2"]
}
```

### Full example

In this example we will get a list of locations we will use: location object, shimmer effect and
pagination <br>

- The location object class

```dart
class Location {
  String textLocation;
  String id;

  Location({
    required this.textLocation,
    required this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(
        textLocation: json["text_location"],
        id: json["_id"],
      );
}
```

- The Location card widget

```dart
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
```

- The FutureList widget

```dart
  FutureListBuilder<Location>
(
url: "https://example.com/get/locations",
httpMethod: HttpMethod.get,
converter: Location.fromJson,
itemBuilder: LocationCard,
dataPath: ['data'], //The data path in the json response body.
countPath: ['total_count'], //The total count path in the json response body.
shimmerBuilder: () => ShimmerCard(width: 1,height:100,fillWidth: true),
pagination: true,
onError: (errorMessage){
print("Error: $errorMessage");
},
)
```

In this example the response body should be

```json
{
  "data": ["item1", "item2"],
  "total_count": 20
}
```

## Properties

### FutureListBuilder

| property                    | description                                                            | default                 |
| --------------------------- | ---------------------------------------------------------------------- | ----------------------- |
| url                         | the url of the data                                                    | required                |
| httpMethod                  | http request method instance of HttpMethod                             | required                |
| converter                   | function to convert from json to object                                | required                |
| itemBuilder                 | function to get card widget from object                                | required                |
| dataPath                    | path of the data list in the response body                             | required                |
| itemBuilder                 | function to get card widget from object                                | required                |
| header                      | json object                                                            | null                    |
| body                        | json object will use only with getWithBody and post HttpMethod         | null                    |
| scrollDirection             | instance of Axis                                                       | Axis.vertical           |
| shimmerBuilder              | function return the shimmer card                                       | null                    |
| shimmerCardsCount           | number of shimmer card when loading                                    | 3                       |
| paginationShimmerCardsCount | number of shimmer card with pagination                                 | 3                       |
| onError                     | callback function with error message <br> (String) => void             | null                    |
| callBack                    | callback function with list of object responses <br> (List<T>) => void | null                    |
| pagination                  | support pagination                                                     | false                   |
| skipKey                     | the skip key which will be use in the header                           | skip                    |
| limitKey                    | the limit key which will be use in the header                          | limit                   |
| skip                        | the skip value which will be use in the header                         | 1                       |
| limit                       | the limit value which will be use in the header                        | 6                       |
| successStatusCode           | the success status code in the response                                | 200                     |
| countPath                   | path of the total count number in the response body                    | null                    |
| scrollPhysics               | scroll physics for list the list view                                  | BouncingScrollPhysics() |

### ShimmerCard

| property       | description                                              | default        |
| -------------- | -------------------------------------------------------- | -------------- |
| width          | shimmer card width                                       | required       |
| height         | shimmer card height                                      | required       |
| fillWidth      | if set true shimmer card will expand to fit screen width | false          |
| baseColor      | base color                                               | Colors.grey    |
| highlightColor | highlight color                                          | Colors.black12 |

## Screenshots

<p float="left">
<figure>
<img src="https://raw.githubusercontent.com/Obaa10/future-list/main/media/screenshot_1.png" width="200">
<figcaption>Fig.1 - Shimmer effect while get data.</figcaption>
</figure>
<figure>
<img src="https://raw.githubusercontent.com/Obaa10/future-list/main/media/screenshot_2.png" width="200">
<figcaption>Fig.2 - Show result After get data.</figcaption>
</figure>
<figure>
<img src="https://raw.githubusercontent.com/Obaa10/future-list/main/media/screenshot_3.png" width="200">
<figcaption>Fig.3 - Shimmer effect while pagination.</figcaption>
</figure>
</p>

## Suggestions and Feedback

We value your suggestions and feedback to enhance this project.</br>
If you have any ideas, feature requests, bug reports, or general feedback, we would love to hear from you. Your input is important to us, and it helps us improve the project for everyone.
