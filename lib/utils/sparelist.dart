import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';


class Extra {
  headlineText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 23.0,
          color: Color(0xFF212121),
          fontWeight: FontWeight.bold),
    );
  }

  iconViewer(IconData icon) {
    return Icon(icon, color: Colors.black, size: 30);
  }

  titleViewer(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  subViewer(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14.0, color: Colors.grey),
    );
  }

  smallViewer({String? text, IconData? icon}) {
    return Wrap(
      children: [
        Icon(icon, color: Colors.grey, size: 19),
        Text(
          text!,
          style: const TextStyle(fontSize: 15.0, color: Colors.grey),
        ),
      ],
    );
  }

  moneyViewer(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14.0, color: Colors.grey),
    );
  }

  divide() {
    return const Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Divider(
        color: Colors.grey,
        thickness: 1.0,
      ),
    );
  }

  containerView({double? height, Widget? child}) {
    return Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: child);
  }

  listTileView() {
    return ListTile(
      title: Extra().titleViewer('Mobile order'),
      subtitle: Extra().subViewer('10/03/2020'),
      trailing: Extra().moneyViewer("\u{20B9} 300"),
    );
  }

  bannerView() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Extra().titleViewer('Motor Details'),
          divide(),
          Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  insideWrapView(
                      text1: Statics().motorText, text2: Statics().text1),
                  const SizedBox(
                    height: 5,
                  ),
                  insideWrapView(
                      text1: Statics().motorText, text2: Statics().text1),
                  const SizedBox(
                    height: 5,
                  ),
                  insideWrapView(
                      text1: Statics().motorText, text2: Statics().text1)
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              SizedBox(height: 120, child: VerticalDivider(color: Colors.red)),
              const SizedBox(
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  insideWrapView(
                      text1: Statics().motorText, text2: Statics().text1),
                  const SizedBox(
                    height: 5,
                  ),
                  insideWrapView(
                      text1: Statics().motorText, text2: Statics().text1),
                  const SizedBox(
                    height: 5,
                  ),
                  insideWrapView(
                      text1: Statics().motorText, text2: Statics().text1)
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  insideWrapView({String? text1, String? text2}) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        Text(
          text1!,
          style: const TextStyle(fontSize: 13.0, color: Colors.grey),
        ),
        Text(
          text2!,
          style: const TextStyle(fontSize: 13.0, color: Colors.black),
        ),
      ],
    );
  }

//https://www.princexml.com/howcome/2016/samples/invoice/index.pdf
}

// class NavigationRoute {
//   navigation(BuildContext context) {
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => const SpareDetailsScreen()));
//   }
// }

class Statics {
  String motorText = 'Motor No';
  String text1 = 'TN 45 E 8756';
}

class pdfViewer {
  late String _localPath;

  pdfBannerViewer() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 20,
            children: [
              Extra().titleViewer('Motor Details'),
              InkWell(
                onTap: () async {
                  await _prepareSaveDir();
                  print("Downloading");
                  try {
                    await Dio().download("https://www.princexml.com/howcome/2016/samples/invoice/index.pdf",
                        "$_localPath/filename.pdf");
                    print("Download Completed.");
                  } catch (e) {
                    print("Download Failed.\n\n$e");
                  }
                },
                child: Extra()
                    .smallViewer(icon: Icons.download, text: 'Download pdf'),
              ),
              Extra().smallViewer(icon: Icons.print, text: 'print')
            ],
          ),
          SizedBox(
            height: 200,
            width: 400,
            child: const PDF().cachedFromUrl(
              'https://www.princexml.com/howcome/2016/samples/invoice/index.pdf',
              placeholder: (double progress) =>
                  Center(child: Text('$progress %')),
              errorWidget: (dynamic error) =>
                  Center(child: Text(error.toString())),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _prepareSaveDir() async {


    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    return "/sdcard/download/";
  }
}
