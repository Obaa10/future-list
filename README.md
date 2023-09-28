# Future List

Future List is a powerful Flutter package that simplifies the process of displaying dynamic lists in your Flutter applications. With Future List, you can effortlessly generate list views from a single URL, complete with automatic pagination, shimmer effects, and a range of advanced features.

## Features

- **Effortless Pagination**: Future List takes care of pagination for you, automatically fetching and displaying new data as the user scrolls, ensuring a seamless browsing experience.

- **Shimmer Effects**: Enhance the visual appeal of your list views with built-in shimmer effects, making the loading process more engaging and user-friendly.

- **Customizable**: Future List provides a range of options to customize the appearance and behavior of your list views, allowing you to tailor them to fit your app's unique design and requirements.

- **Error Handling**: Handle errors and fallback scenarios gracefully with Future List's error handling capabilities, providing a smooth user experience even in case of network or data issues.

- **Flexible Integration**: Integrate Future List into your existing Flutter projects with ease, thanks to its intuitive and straightforward API.


## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## How to use

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  future_list: ^1.0.0
```


```dart
import 'package:fluttertoast/fluttertoast.dart';
```

## Example

```dart
  FutureListBuilder<RealEstate>(
    url: "https://example.com/get/data",
    httpMethod: HttpMethod.get,
    converter: (json) {
     //Function to convert from json to RealEstate Object.
    },
    itemBuilder: (data) {
      //Function to return card widget for the data RealEstate.
    },
    dataPath: ['data'], //The data path in the json response body.
  )
```
In this example we get data from https://example.com/get/data url 
with Http get method. <br>
In this example the response body should be 
```json
{
  "data": [
    "item1",
    "item2"
  ]
}
```
## Properties

| property | description | default
|----------| ----------- | -------
| url  | the url of the data | required
| httpMethod | http request method instance of HttpMethod | required
| converter | function to convert from json to object | required
| itemBuilder | function to get card widget from object | required
| dataPath | path of the data list in the response body | required
| itemBuilder | function to get card widget from object | required| 
| header | json object | null| 
| body | json object will use only with getWithBody and post HttpMethod  | null| 
| scrollDirection | instance of Axis | Axis.vertical | 
| shimmerBuilder | function return the shimmer card | null | 
| shimmerCardsCount | number of shimmer card when loading | 3 | 
| onError | callback function with error message <br> (String) => void | null | 
| callBack | callback function with list of object responses  <br> (List<T>) => void | null | 
| pagination | support pagination  | false | 
| skipKey | the skip key which will be use in the header  | skip | 
| limitKey | the limit key which will be use in the header  | limit | 
| skip | the skip value which will be use in the header  | 1 | 
| limit | the limit value which will be use in the header  | 6 | 
| successStatusCode | the success status code in the response  | 200 | 
| countPath | path of the total count number in the response body | null
| scrollPhysics | scroll physics for list the list view | BouncingScrollPhysics()


## If you need any features suggest #
...