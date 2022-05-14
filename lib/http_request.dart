import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:http/http.dart' as http;

Future getRequest(path, qparam, headers) async {
  final response = await http
      .get(Uri.https('app.getjustdone.com', path, qparam), headers: headers);

  // debugPrint(response.body);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // print(data);
    return data;
  } else {
    print(
      path,
    );
    print(
      headers,
    );
    print(
      qparam,
    );
    print(HtmlParser.parseHTML(response.body).body.innerHtml);
    throw Exception('Failed to load data');
  }
}

Future getRequestWithoutParam(path, headers) async {
  final response = await http
      .get(Uri.https('b00d-182-48-84-100.ngrok.io', path), headers: headers);

  // debugPrint(response.body);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // print(data);
    return data;
  } else {
    print(
      path,
    );
    print(
      headers,
    );
    print(HtmlParser.parseHTML(response.body).body.innerHtml);
    throw Exception('Failed to load data');
  }
}

Future postRequest(path, headers, qparam, body) async {
  final response = await http.post(
      Uri.https('b00d-182-48-84-100.ngrok.io', path, qparam),
      headers: headers,
      body: body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    var data = json.decode(response.body);
    return data;
  } else {
    print('###DEBUG API###');
    print(
      path,
    );
    print(
      headers,
    );
    print(
      qparam,
    );
    print(body);
    print(HtmlParser.parseHTML(response.body).body.innerHtml);
    throw Exception('Failed to post data');
  }
}

Future putRequest(path, headers, qparam, body) async {
  print(path.runtimeType);
  print(headers.runtimeType);
  print(qparam.runtimeType);
  print(body.runtimeType);

  final response = await http.put(
      Uri.https('b00d-182-48-84-100.ngrok.io', path, qparam),
      headers: headers,
      body: body);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return data;
  } else {
    print(HtmlParser.parseHTML(response.body).body.innerHtml);
    throw Exception('Failed to post data');
  }
}
