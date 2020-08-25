import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData.dark(),
    ));

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  File _pickedImage = null;
  List _output = [];
  int result;
  double confidencePercent;
  bool potHoleFound = false;

  final values = [ImageSource.camera, ImageSource.gallery];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel(); //loading the model as soon as the app starts
  }

  loadModel() async {
    String res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
    print("Model load status " + res);
  }

  Future runModel(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    result = recognitions[0]['index'];
    print(recognitions);
    confidencePercent = recognitions[0]['confidence'];

    if (result == 1) {
      setState(() {
        potHoleFound = true;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getImage() async {
    setState(() {
      isLoading = true;
    });
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);

        print("Image Loaded");
      });
      runModel(_pickedImage);
    } else {
      print("Image Load Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(potHoleFound);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pot-hole Detector'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _pickedImage != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: Image.file(
                            _pickedImage,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        result == 1
                            ? Text(
                                "Pothole Found",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "Pothole Not Found",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        result == 1
                            ? Icon(
                                Icons.done_outline,
                                color: Colors.greenAccent,
                              )
                            : Icon(
                                Icons.not_interested,
                                color: Colors.redAccent,
                              )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Confidence : ' +
                          (confidencePercent * 100).floor().toString() +
                          "%",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                )
              : Center(
                  child: Text(
                    'Pick an Image',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
