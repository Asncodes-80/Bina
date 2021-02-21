import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_native_resizer/image_native_resizer.dart';

class ImgManipulate {
  File imgS = null;

// Image for Pick
  // Future galleryViewer(ImageSource changeType) async {
  //   final image = await ImagePicker.pickImage(source: changeType);
  //   imgS = image;
  // }

  Future<String> img2Base64({img}) async {
    try {
      if (img != null) {
        // Ready for resize image to low and middle quality
        final reSizeImgPath = await ImageNativeResizer.resize(
          imagePath: img.path,
          maxWidth: 512,
          maxHeight: 512,
          quality: 50,
        );
        // Ready to convert Img uri path to Image File
        File resizedImgFile = File(reSizeImgPath);
        // Ready to convert image file to byte code
        final byteImg = resizedImgFile.readAsBytesSync();
        String _img64 = base64Encode(byteImg);

        return _img64;
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }
}
