import 'dart:async';
import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _eastCoastParkPosition = CameraPosition(
    target: LatLng(1.3039560, 103.9263730),
    zoom: 15,
  );

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
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _eastCoastParkPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImages,
        tooltip: 'Pick',
        child: const Icon(Icons.add),
      ),
    );
  }
}
