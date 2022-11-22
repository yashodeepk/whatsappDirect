import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectWhatsAppMsg extends StatefulWidget {
  const DirectWhatsAppMsg({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DirectWhatsAppMsgState createState() => _DirectWhatsAppMsgState();
}

class _DirectWhatsAppMsgState extends State<DirectWhatsAppMsg> {
  final GlobalKey<FormState> messageformkey = GlobalKey<FormState>();

  late String phone;
  late String message = "";

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String url(String phone, String text) {
    if (Platform.isAndroid) {
      return "whatsapp://send?phone=$phone&text=$text"; // new line
    } else {
      return "https://api.whatsapp.com/send?phone=$phone&text=$text"; // new line
    }
  }

  _launchWhatsapp(String number, String message) async {
    var whatsapp = number;
    var whatsappAndroid = Uri.parse(url(whatsapp, message));
    await launchUrl(whatsappAndroid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // physics: const ClampingScrollPhysics(
        //     parent: NeverScrollableScrollPhysics()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: messageformkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          AutoSizeText(
                            'Send Direct!',
                            style: TextStyle(
                                fontSize: 34, fontWeight: FontWeight.w600),
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            'Enter the Whatsapp Number',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    IntlPhoneField(
                      // ignore: valid_regexps
                      onChanged: (input) => phone = input.completeNumber,
                      initialCountryCode: 'IN',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        labelText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (value) {
                        return null;
                      },
                      onChanged: (input) => message = input,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        labelText: 'Message (Optional)',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                        ),
                        onPressed: () {
                          if (messageformkey.currentState!.validate()) {
                            print("Message is $message");
                            _launchWhatsapp(phone, message);
                          }
                        },
                        child: const AutoSizeText(
                          'Send',
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
