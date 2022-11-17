import 'dart:math';

import 'package:call_log/call_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp Direct',
      theme: ThemeData(
          primarySwatch: Colors.green, scaffoldBackgroundColor: Colors.white),
      home: const MyHomePage(title: 'Whatsapp Direct'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Iterable<CallLogEntry> entries;
  int callLogsTill = 5;
  bool? fetching = true;
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  void _printCallLogs(Iterable<CallLogEntry> entry) {
    if (kDebugMode) {
      print('Queried call log entries');
      for (CallLogEntry entry in entries) {
        print('-------------------------------------');
        print('F. NUMBER  : ${entry.formattedNumber}');
        print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
        print('NUMBER     : ${entry.number}');
        print('NAME       : ${entry.name}');
        print('TYPE       : ${entry.callType}');
        print(
            'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}');
        print('DURATION   : ${entry.duration}');
        print('ACCOUNT ID : ${entry.phoneAccountId}');
        print('SIM NAME   : ${entry.simDisplayName}');
        print('-------------------------------------');
      }
    }
  }

  Future<void> _getCalllogs() async {
    setState(() {
      fetching = true;
    });
    var now = DateTime.now();
    int from =
        now.subtract(Duration(days: callLogsTill)).millisecondsSinceEpoch;
    int to = now.millisecondsSinceEpoch;
    entries = await CallLog.query(dateFrom: from, dateTo: to);
    _printCallLogs(entries);
    setState(() {
      fetching = false;
    });
  }

  @override
  void initState() {
    _getCalllogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          entries.toList().isEmpty
              ? fetching!
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                    child: SizedBox(
                      height: 200.0,
                      child: RefreshIndicator(
                        key: _refreshKey,
                        onRefresh: () async {
                          await _getCalllogs();
                        },
                        child: ListView.builder(
                            itemCount: entries.length,
                            itemBuilder: (_, index) {
                              return ContactCard(
                                  fnumber: entries
                                      .elementAt(index)
                                      .formattedNumber
                                      .toString(),
                                  cmnumber: entries
                                      .elementAt(index)
                                      .cachedMatchedNumber
                                      .toString(),
                                  number: entries
                                      .elementAt(index)
                                      .number
                                      .toString(),
                                  name:
                                      entries.elementAt(index).name.toString(),
                                  type: entries
                                      .elementAt(index)
                                      .callType
                                      .toString(),
                                  date: entries
                                      .elementAt(index)
                                      .timestamp
                                      .toString(),
                                  duration: entries
                                      .elementAt(index)
                                      .duration
                                      .toString(),
                                  accountid: entries
                                      .elementAt(index)
                                      .phoneAccountId
                                      .toString(),
                                  simname: entries
                                      .elementAt(index)
                                      .simDisplayName
                                      .toString());
                            }),
                      ),
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCalllogs,
        tooltip: 'Send',
        child: const Icon(Icons.whatsapp_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ContactCard extends StatefulWidget {
  ContactCard(
      {Key? key,
      required this.fnumber,
      required this.cmnumber,
      required this.number,
      required this.name,
      required this.type,
      required this.date,
      required this.duration,
      required this.accountid,
      required this.simname})
      : super(key: key);

  String fnumber;
  String cmnumber;
  String number;
  String name;
  String type;
  String date;
  String duration;
  String accountid;
  String simname;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  static Color randomOpaqueColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
  }

  String returnFirstNameChar(String name) {
    return name.isEmpty ? 'U' : name[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Card(
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Colors.green[
                  ((returnFirstNameChar(widget.name).codeUnitAt(0)) %
                          Colors.primaries.length) *
                      100],
              radius: 28,
              child: Text(
                returnFirstNameChar(widget.name),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
