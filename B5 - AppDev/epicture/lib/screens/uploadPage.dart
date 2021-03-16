import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_flutter/main.dart';
import 'package:imgur/imgur.dart' as imgur;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File imageFile;
  final picker = ImagePicker();
  final LinearGradient favColor =
      LinearGradient(colors: [Colors.yellowAccent[700], Colors.yellow[900]]);
  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void clear() {
    setState(() => imageFile = null);
  }

  Future<void> cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.yellow[600],
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      imageFile = cropped ?? imageFile;
    });
  }

  sendPicture() async {
    final client = imgur.Imgur(imgur.Authentication.fromToken(theAccessToken));
    final snackBar = SnackBar(content: Text("Image Uploaded ✅"));
    final uploadSnackbar =
        SnackBar(content: Text("Your image is uploading 👀"));

    Scaffold.of(context).showSnackBar(uploadSnackbar);
    await client.image
        .uploadImage(
            imagePath: imageFile.path,
            title: titleController.text,
            description: descController.text)
        .then((image) {
      print('Uploaded image to: ${image.link}');
      Scaffold.of(context).showSnackBar(snackBar);
      titleController.clear();
      descController.clear();
      clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          if (imageFile != null) ...[
            Container(
              height: screensize.height * .20,
              decoration: BoxDecoration(gradient: favColor),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12, top: screensize.height * .11),
                          child: Text(
                            "UPLOAD",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: screensize.height * .05,
                                color: Colors.white),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Image.file(imageFile),
            SizedBox(height: 20),
            Center(
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.yellow[800],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                onPressed: () => cropImage(),
                icon: Icon(
                  Icons.crop,
                  color: Colors.white,
                ),
                label: Text(
                  "Crop the Image",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextField(
                controller: titleController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  hintText: 'Enter post title',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: TextField(
                controller: descController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  hintText: 'Enter picture description',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.green[400],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                onPressed: () => sendPicture(),
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                label: Text(
                  "Upload Image",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
//            Uploader(file: imageFile)
          ] else ...[
            Container(
              height: screensize.height * .20,
              decoration: BoxDecoration(gradient: favColor),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12, top: screensize.height * .11),
                          child: Text(
                            "UPLOAD",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: screensize.height * .05,
                                color: Colors.white),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(height: screensize.height * .2),
            Center(
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.yellow[800],
                textColor: Colors.white,
                splashColor: Colors.yellowAccent[700],
                padding: EdgeInsets.symmetric(horizontal: 67, vertical: 20),
                onPressed: () => getImage(ImageSource.camera),
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                label: Text(
                  "TAKEPICTURE",
                  style: TextStyle(
                      fontSize: screensize.height * .02,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: screensize.height * .03),
            Center(child: Text("OR")),
            SizedBox(height: screensize.height * .03),
            Center(
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.yellow[900],
                textColor: Colors.white,
                splashColor: Colors.yellow[700],
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                onPressed: () => getImage(ImageSource.gallery),
                icon: Icon(
                  Icons.photo_library,
                  color: Colors.white,
                ),
                label: Text(
                  "LOAD FROM GALLERY",
                  style: TextStyle(
                      fontSize: screensize.height * .02,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
