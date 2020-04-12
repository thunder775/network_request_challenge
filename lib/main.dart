import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String code;
  bool isLoading = false;
  String text = "Welcome";
  Future<void> f1;

  Future<void> getNetworkResponse() async {
    print("function called");
    Response response = await get(
        "http://slowwly.robertomurray.co.uk/delay/8000/url/http://www.google.co.uk");
    code = "status code: " + response.statusCode.toString();
  }

  @override
  void initState() {
    f1 = getNetworkResponse();
    super.initState();
  }

  void resolveFuture() async {
    setState(() {
      isLoading = true;
    });
    await f1;
    setState(() {
      isLoading = false;
    });
    print(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!isLoading) Text(code ?? text),
            if (isLoading) CircularProgressIndicator()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading
            ? null
            : () {
                resolveFuture();
              },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
