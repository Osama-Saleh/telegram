import 'dart:isolate';

import 'package:flutter/material.dart';

class CustomDownload extends StatefulWidget {
  const CustomDownload({super.key});

  @override
  State<CustomDownload> createState() => _CustomDownloadState();
}

class _CustomDownloadState extends State<CustomDownload> {
  ReceivePort port = ReceivePort();
  bool? isLoading;
  bool? permissionReady;
  String? localPath;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
