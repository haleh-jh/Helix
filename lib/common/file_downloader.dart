import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as universal_html;

Future<void> downloadFile(
    {required String url,
    required String fileName,
    required String dataType}) async {
  try {
    // first we make a request to the url like you did
    // in the android and ios version
    final http.Response r = await http.get(
      Uri.parse(url),
    );

    // we get the bytes from the body
    final data = r.bodyBytes;
    // and encode them to base64
    final base64data = base64Encode(data);

    // then we create and AnchorElement with the html package
    final a =
        universal_html.AnchorElement(href: '$dataType;base64,$base64data');

    // set the name of the file we want the image to get
    // downloaded to
    a.download = fileName;

    // and we click the AnchorElement which downloads the image
    a.click();
    // finally we remove the AnchorElement
    a.remove();
  } catch (e) {
    print(e);
  }
}
