//import 'dart:io';
//import 'dart:math';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:call_log/call_log.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:whatsappdm/directWhatsapp.dart';
//import 'package:whatsappdm/ad_helper.dart';

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
      title: 'WhatsappDM',
      theme: ThemeData(
          primarySwatch: Colors.green, scaffoldBackgroundColor: Colors.white),
      home: const DirectWhatsAppMsg(title: "WhatsappDM"),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // late Iterable<CallLogEntry> entries;
//   // int callLogsTill = 5;
//   // bool? fetching = true;
//   // BannerAd? _bannerAd;
//   // final _refreshKey = GlobalKey<RefreshIndicatorState>();

//   // void _printCallLogs(Iterable<CallLogEntry> entry) {
//   //   if (kDebugMode) {
//   //     print('Queried call log entries');
//   //     for (CallLogEntry entry in entries) {
//   //       print('-------------------------------------');
//   //       print('F. NUMBER  : ${entry.formattedNumber}');
//   //       print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
//   //       print('NUMBER     : ${entry.number}');
//   //       print('NAME       : ${entry.name}');
//   //       print('TYPE       : ${entry.callType}');
//   //       print(
//   //           'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}');
//   //       print('DURATION   : ${entry.duration}');
//   //       print('ACCOUNT ID : ${entry.phoneAccountId}');
//   //       print('SIM NAME   : ${entry.simDisplayName}');
//   //       print('-------------------------------------');
//   //     }
//   //   }
//   // }

//   // Future<void> _getCalllogs() async {
//   //   setState(() {
//   //     fetching = true;
//   //   });
//   //   var now = DateTime.now();
//   //   int from =
//   //       now.subtract(Duration(days: callLogsTill)).millisecondsSinceEpoch;
//   //   int to = now.millisecondsSinceEpoch;
//   //   entries = await CallLog.query(dateFrom: from, dateTo: to);
//   //   _printCallLogs(entries);
//   //   setState(() {
//   //     fetching = false;
//   //   });
//   // }

//   @override
//   void initState() {
//     //_getCalllogs();
//     _initGoogleMobileAds();

//     // BannerAd(
//     //   adUnitId: AdHelper.bannerAdUnitId,
//     //   request: AdRequest(),
//     //   size: AdSize.banner,
//     //   listener: BannerAdListener(
//     //     onAdLoaded: (ad) {
//     //       setState(() {
//     //         _bannerAd = ad as BannerAd;
//     //       });
//     //     },
//     //     onAdFailedToLoad: (ad, err) {
//     //       print('Failed to load a banner ad: ${err.message}');
//     //       ad.dispose();
//     //     },
//     //   ),
//     // ).load();
//     super.initState();
//   }

//   Future<InitializationStatus> _initGoogleMobileAds() {
//     // TODO: Initialize Google Mobile Ads SDK
//     return MobileAds.instance.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Column(
//         children: [
//           if (_bannerAd != null)
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 width: _bannerAd!.size.width.toDouble(),
//                 height: _bannerAd!.size.height.toDouble(),
//                 child: AdWidget(ad: _bannerAd!),
//               ),
//             ),
//           entries.toList().isEmpty
//               ? fetching!
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Container()
//               : Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
//                     child: SizedBox(
//                       height: 200.0,
//                       child: RefreshIndicator(
//                         key: _refreshKey,
//                         onRefresh: () async {
//                           await _getCalllogs();
//                         },
//                         child: ListView.builder(
//                             itemCount: entries.length,
//                             itemBuilder: (_, index) {
//                               return ContactCard(
//                                   fnumber: entries
//                                       .elementAt(index)
//                                       .formattedNumber
//                                       .toString(),
//                                   cmnumber: entries
//                                       .elementAt(index)
//                                       .cachedMatchedNumber
//                                       .toString(),
//                                   number: entries
//                                       .elementAt(index)
//                                       .number
//                                       .toString(),
//                                   name:
//                                       entries.elementAt(index).name.toString(),
//                                   type: entries
//                                       .elementAt(index)
//                                       .callType
//                                       .toString(),
//                                   date: entries
//                                       .elementAt(index)
//                                       .timestamp
//                                       .toString(),
//                                   duration: entries
//                                       .elementAt(index)
//                                       .duration
//                                       .toString(),
//                                   accountid: entries
//                                       .elementAt(index)
//                                       .phoneAccountId
//                                       .toString(),
//                                   simname: entries
//                                       .elementAt(index)
//                                       .simDisplayName
//                                       .toString());
//                             }),
//                       ),
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     const DirectWhatsAppMsg(title: "WhatsappDM")),
//           );
//         },
//         tooltip: 'Send',
//         child: const Icon(Icons.whatsapp_sharp),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

// class ContactCard extends StatefulWidget {
//   ContactCard(
//       {Key? key,
//       required this.fnumber,
//       required this.cmnumber,
//       required this.number,
//       required this.name,
//       required this.type,
//       required this.date,
//       required this.duration,
//       required this.accountid,
//       required this.simname})
//       : super(key: key);

//   String fnumber;
//   String cmnumber;
//   String number;
//   String name;
//   String type;
//   String date;
//   String duration;
//   String accountid;
//   String simname;

//   @override
//   State<ContactCard> createState() => _ContactCardState();
// }

// class _ContactCardState extends State<ContactCard> {
//   static Color randomOpaqueColor() {
//     return Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
//   }

//   String returnFirstNameChar(String name) {
//     return name.isEmpty ? 'U' : name[0];
//   }

//   static String dateTimeFormater(int epochTimestamp) {
//     DateTime dt = DateTime.fromMillisecondsSinceEpoch(epochTimestamp);
//     String formattedDate = DateFormat('E d MMM hh:mm:ss').format(dt);
//     return formattedDate;
//   }

//   String url(String phone, String text) {
//     if (Platform.isAndroid) {
//       return "whatsapp://send?phone=$phone/text=$text}"; // new line
//     } else {
//       return "https://api.whatsapp.com/send?phone=$phone}"; // new line
//     }
//   }

//   _launchWhatsapp(String number) async {
//     var whatsapp = number;
//     var whatsappAndroid = Uri.parse(url(whatsapp, ""));
//     await launchUrl(whatsappAndroid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(2, 0, 5, 0),
//       child: Card(
//         elevation: 0,
//         child: InkWell(
//           onTap: (() => {_launchWhatsapp(widget.number)}),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20.0),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.green[
//                           ((returnFirstNameChar(widget.name).codeUnitAt(0)) %
//                                   Colors.primaries.length) *
//                               100],
//                       radius: 26,
//                       child: Text(
//                         returnFirstNameChar(widget.name),
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                     child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AutoSizeText(
//                       widget.name.isEmpty ? widget.number : widget.name,
//                       style: const TextStyle(color: Colors.black, fontSize: 18),
//                       maxLines: 1,
//                       minFontSize: 18,
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           (widget.type == "CallType.incoming"
//                               ? Icons.call_received
//                               : Icons.call_made),
//                           size: 16,
//                         ),
//                         AutoSizeText(
//                           "• ${dateTimeFormater(int.parse(widget.date))}",
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 16),
//                           maxLines: 1,
//                           minFontSize: 16,
//                         )
//                       ],
//                     )
//                   ],
//                 ))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
