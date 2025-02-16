import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TripPage extends StatefulWidget {
  const TripPage({super.key, required this.title});

  final String title;

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  List<File> files = [];
  List<Map<String, IfdTag>> tags = [];

  Future<List<File>?> _pickImages() async {
    try {
      final List<XFile> images = await ImagePicker().pickMultiImage();
      List<File> files = images.map((XFile image) => File(image.path)).toList();
      List<Map<String, IfdTag>> tags = [];
      for (XFile image in images) {
        final bytes = await image.readAsBytes();
        final tag = await readExifFromBytes(bytes);
        tags.add(tag);
      }
      setState(() {
        this.files = files;
        this.tags = tags;
      });
    } on PlatformException catch (_) {
      // TODO(prakharrathi): Handle error.
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have selected these many images:'),
            Text(
              '${files.length}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(tags.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImages,
        tooltip: 'Pick',
        child: const Icon(Icons.add),
      ),
    );
  }
}
