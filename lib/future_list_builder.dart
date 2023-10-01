import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:future_list/util.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class FutureListBuilderT<T> extends StatefulWidget {
  const FutureListBuilderT({
    super.key,
    required this.url,
    required this.httpMethod,
    this.header,
    this.body,
    this.dataGetter,
    this.countGetter,
    required this.converter,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.shimmerBuilder,
    this.shimmerCardsCount = 3,
    this.onError,
    this.callBack,
    this.pagination = false,
    this.skipKey = "skip",
    this.limitKey = "limit",
    this.skip = 1,
    this.limit = 6,
    this.successStatusCode = 200,
    required this.dataPath,
    this.countPath,
    this.scrollPhysics = const BouncingScrollPhysics(),
  });

  //Futures
  final String url;
  final HttpMethod httpMethod;
  final Map<String, String>? header;
  final Map<String, dynamic>? body;
  final int? successStatusCode;

  //Response
  final List<Map>? Function(Map)? dataGetter;
  final int? Function(Map)? countGetter;

  //Converter
  final T Function(Map<String, dynamic>) converter;
  final List<String> dataPath;
  final List<String>? countPath;
  final Widget Function(T data) itemBuilder;

  //List attributes
  final Axis scrollDirection;
  final ScrollPhysics scrollPhysics;

  //Simmer
  final Widget Function()? shimmerBuilder;
  final int shimmerCardsCount;

  //Call back..
  final Widget? Function(String?)? onError;
  final void Function(List<T>)? callBack;

  //Pagination
  final bool pagination;
  final String skipKey;
  final String limitKey;
  final int skip;
  final int limit;

  @override
  State<FutureListBuilderT<T>> createState() => _FutureListBuilderState<T>();
}

class _FutureListBuilderState<T> extends State<FutureListBuilderT<T>> {
  List<T> items = [];
  int? totalCount;
  int page = 1;
  bool _loading = false;
  var scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(pagination);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isNotEmpty && widget.callBack != null) widget.callBack!(items);
    return FutureBuilder(
        future: getResponse(),
        builder: (context, snapshot) {
          // done
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data?.statusCode ==
                (widget.successStatusCode ?? 200)) {
              //Success
              convertData(snapshot);
              return createList();
            }
          }
          if (items.isNotEmpty) {
            return createList();
          }

          // loading
          if (loading(snapshot) != null) return loading(snapshot)!;
          _loading = snapshot.connectionState == ConnectionState.waiting;

          //Error
          if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data?.statusCode != (widget.successStatusCode ?? 200)) {
            if (widget.onError != null) {
              return widget.onError!(
                      snapshot.data?.toString() ?? snapshot.error.toString()) ??
                  const SizedBox();
            }
          }

          return const SizedBox();
        });
  }

  convertData(AsyncSnapshot<dynamic> snapshot) {
    List<dynamic>? data = widget.dataGetter != null
        ? widget.dataGetter!(snapshot.data?.body)
        : getValueFromJson(jsonDecode(snapshot.data?.body), widget.dataPath);

    if (widget.countPath != null) {
      totalCount = widget.countGetter != null
          ? widget.countGetter!(snapshot.data?.body)
          : getValueFromJson(
              jsonDecode(snapshot.data?.body), widget.countPath!);
    }

    items.addAll(data?.map((e) => widget.converter(e)).toList() ?? []);
  }

  Widget _listBuilder(
      {required int itemCount,
      required Widget? Function(BuildContext, int) itemBuilder}) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      scrollDirection: widget.scrollDirection,
      physics: widget.scrollPhysics,
      controller: scrollController,
    );
  }

  Widget createList() {
    if (widget.pagination && widget.shimmerBuilder != null) {
      return listWithPagination();
    }
    return _listBuilder(
        itemCount: items.length,
        itemBuilder: (context, index) => widget.itemBuilder(items[index]));
  }

  Widget listWithPagination() {
    if (totalCount != null) {
      return _listBuilder(
          itemCount: page * widget.limit <= totalCount!
              ? items.length + 4
              : items.length,
          itemBuilder: (context, index) {
            if (index >= items.length) {
              return widget.shimmerBuilder!();
            } else {
              return widget.itemBuilder(items[index]);
            }
          });
    } else {
      return _listBuilder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return widget.itemBuilder(items[index]);
          });
    }
  }

  Widget? loading(AsyncSnapshot<dynamic> snapshot) {
    if (items.isEmpty && snapshot.connectionState == ConnectionState.waiting) {
      //No data loader
      return loader();
    } else if (items.isNotEmpty) {
      return createList();
    }
    return null;
  }

  Widget loader() {
    if (widget.shimmerBuilder != null) {
      return _listBuilder(
        itemCount: widget.shimmerCardsCount,
        itemBuilder: (context, index) => widget.shimmerBuilder!(),
      );
    } else {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      );
    }
  }

  Future<Response> getResponse() {
    if (widget.httpMethod == HttpMethod.get) {
      return _get();
    } else if (widget.httpMethod == HttpMethod.post) {
      return _post();
    } else {
      return _getWithBody();
    }
  }

  Future<Response> _get() {
    print("get url ${getUrl()}");
    return http.get(
      Uri.parse(getUrl()),
      headers: widget.header,
    );
  }

  Future<Response> _getWithBody() async {
    print("get with body url ${getUrl()}");
    var request = http.Request('GET', Uri.parse(getUrl()));
    request.body = jsonEncode(widget.body);
    if (widget.header != null) request.headers.addAll(widget.header!);
    request.headers['Content-Type'] = 'application/json';
    return http.Response.fromStream(await request.send());
  }

  Future<Response> _post() {
    print("post url ${getUrl()}");
    return http.post(Uri.parse(getUrl()),
        headers: widget.header, body: widget.body);
  }

  String getUrl() {
    var url = widget.url;
    if (url.contains('?')) {
      url = '$url&${widget.skipKey}=$page&${widget.limitKey}=${widget.limit}';
    } else {
      url = '$url?${widget.skipKey}=$page&${widget.limitKey}=${widget.limit}';
    }
    return url;
  }

  void pagination() {
    if ((scrollController.position.pixels ==
        scrollController.position.maxScrollExtent)) {
      if (totalCount != null) {
        if (page * widget.limit <= totalCount!) {
          setState(() {
            page += 1;
          });
        }
      } else if (!_loading) {
        setState(() {
          page += 1;
        });
      }
    }
  }
}

dynamic getValueFromJson(dynamic jsonObject, List<String> propertyPath) {
  dynamic value = jsonObject;

  for (var property in propertyPath) {
    if (value is Map && value.containsKey(property)) {
      value = value[property];
    } else {
      return null;
    }
  }

  return value;
}

enum HttpMethod { get, post, getWithBody }
