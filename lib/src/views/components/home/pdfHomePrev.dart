import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:onax_app/src/controllers/ticketsSignatureController.dart';
import 'package:onax_app/src/repositories/models/ticketModel.dart';
import 'package:onax_app/src/utils/sharePrefs/accountPrefs.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../utils/urlApi/globalApi.dart';

class PDFTicketPrevHome extends StatefulWidget {
  final int workerOrderID;
  //final dynamic parentController;
  PDFTicketPrevHome({
    Key? key,
    required this.workerOrderID,
    // required this.parentController,
  });

  @override
  _PDFTicketPrevHomeState createState() => _PDFTicketPrevHomeState();
}

class _PDFTicketPrevHomeState extends State<PDFTicketPrevHome> {
  // late WebViewController _viewController = WebViewController();
  final GlobalApi api = GlobalApi();
  late double w, h;
  int page = 0;
  int currentPage = 0;
  int totalPages = 0;
  bool isReady = false;
  bool loaded = true;
  bool exists = true;
  String errorMessage = '';
  String pathPDF = '', urlPagePDF = '';
  PDFViewController? _pdfViewController;
  // GlobalKey<SfSignaturePadState>? keyPad;
  late Uri? newUri;
  String? urlData;
  String? signaturePic;
  //=======
  //late InAppWebViewController _webViewController;
  //late Uri url;
  int progress = 0;
  late var currentUrl;
  late String webTok;
  //WebViewPlusController? _controllerWebPlus; //= WebViewPlusController();
  late final WebViewController _webViewController;
  var bytesUt8;
  String? pdfFile;
  String? pdfPath;

  @override
  void initState() {
    super.initState();
    webTok = '';
    urlData = '';
    newUri = null;
    signaturePic = '';
    progress = 0;
    //keyPad = GlobalKey();
    // String url =
    //     apiRoutes["downloadPDF"].toString() + "?id=${widget.workerOrderID}";
    // Uri uri = Uri.parse(url);
    //print(widget.pdfFile + 'pdf file?%%%%%%%%%%%');
    //print(url.toString() + 'final URI &&&&&&&&&&');
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
            PlatformWebViewControllerCreationParams());
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..setBackgroundColor(Colors.red)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progressCome) {
            // setState(() {
            //   progress = progressCome;
            // });
          },
          onPageStarted: (String url) {
            // setState(() {
            //   progress = 0;
            // });
          },
          onPageFinished: (String url) {
            setState(() {
              progress = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            /*if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }*/
            return NavigationDecision.navigate;
          },
        ),
      )
      ..scrollBy(100, 100);
    /*..loadRequest(uri);*/

    _webViewController = controller;

    downloadPDF().then((value) {
      setState(() {
        progress = 100;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future downloadPDF() async {
    try {
      final String urlApi =
          '${api.api}/${api.pdfSign}/${widget.workerOrderID}/1';
      //print(urlApi);
      final header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${AccountPrefs.token}',
      };
      final response = await http.get(Uri.parse(urlApi), headers: header);
      await _webViewController.loadHtmlString(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed('/pages');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ticket #${widget.workerOrderID}'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                //
                Get.offNamed('/pages');
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: //webViewInternal(context),

            _content(context),
        //     SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
        //   child: SizedBox(
        //     height: h * 1,
        //     child: _content(context),
        //   ),
        // ),
      ),
    );
  }

  _content(BuildContext context) {
    return Column(
      children: [
        //pdf
        //viewPDF(),
        Expanded(
          flex: 8,
          child: progress == 100
              ? webViewInternal(context)
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),

        // _signature(),
        // SizedBox(
        //   height: h * 0.01,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     _btnClearPad(),
        //     SizedBox(
        //       width: w * 0.03,
        //     ),
        //     _btnSave(),
        //   ],
        // ),
        // Spacer(),
        //_btnSave(),
      ],
    );
  }

//WEBVIEW
  webViewInternal(BuildContext context) {
    return WebViewWidget(
      controller: _webViewController,
      //layoutDirection: TextDirection.rtl,
    );
    // return WebViewPlus(
    //   zoomEnabled: true,
    //   //initialUrl: widget.pdfFile,
    //   javascriptMode: JavascriptMode.unrestricted,
    //   onPageStarted: (url) {
    //     print('Start => $url');
    //     setState(() {
    //       progress = 0;
    //     });
    //   },
    //   onPageFinished: (url) {
    //     print('Finished => $url');
    //     setState(() {
    //       progress = 100;
    //     });
    //   },
    //   onProgress: (progress) {
    //     if (progress < 100) {
    //       CircularProgressIndicator();
    //     }
    //   },
    //   onWebViewCreated: (WebViewPlusController controllerPlus) async {
    //     _controllerWebPlus = controllerPlus;

    //     _controllerWebPlus!.loadUrl('' + widget.pdfFile.toString());
    //     // _controllerWebPlus!.loadUrl(Uri.dataFromString(html,
    //     //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
    //     //     .toString());
    //     //..webViewController.clearCache();
    //     //https://docs.google.com/gview?embedded=true&url=
    //   },
    //   onWebResourceError: (error) {
    //     print(error);
    //   },
    // );
  }

  //PDF
  viewPDF() {
    //return Text('ddd');

    if (loaded) {
      return Container(
        width: w * 0.85,
        height: h * 0.7,
        child: PDFView(
          filePath: pdfPath,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          pageSnap: true,
          nightMode: false,
          fitEachPage: true,
          preventLinkNavigation: false,
          onRender: (pages) {
            setState(() {
              totalPages = pages!;
              isReady = true;
            });
          },
          onLinkHandler: (uri) {
            print('go to to uri: $uri');
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onViewCreated: (controller) {
            _pdfViewController = controller;
          },
          onPageChanged: (page, total) {
            setState(() {
              currentPage = page!;
            });
          },
        ),
      );
      // ignore: unnecessary_null_comparison
    } else if (exists && pdfPath != null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center(
        child: Text('The PDF can\'t be downloaded from the url'),
      );
    }
  }

  // _signature() {
  //   return Container(
  //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //     height: h * 0.15,
  //     width: w * 0.8,
  //     child: PhysicalModel(
  //       color: Colors.white,
  //       elevation: 2,
  //       borderRadius: BorderRadius.circular(10),
  //       child: HandSignature(
  //         control: widget.parentController.singnature1Control,
  //         color: Colors.blueGrey,
  //         width: 1.0,
  //         maxWidth: 2.5,
  //         type: SignatureDrawType.shape,
  //       ),
  //     ),
  //   );
  // }

  // _btnSave() {
  //   return RoundedLoadingButton(
  //     width: w * 0.3,
  //     color: Colors.blue,
  //     controller: widget.parentController.btnSignature,
  //     onPressed: () async {
  //       await widget.parentController.saveSignature(widget.workerOrderID);
  //       widget.parentController.btnSignature.reset();
  //       // await controller.updateFinishedTimeTicket();
  //     },
  //     borderRadius: 15,
  //     child: Text(
  //       'Save',
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   );
  // }

  // _btnClearPad() {
  //   return Container(
  //     width: w * 0.3,
  //     height: h * 0.06,
  //     decoration: BoxDecoration(
  //         color: Colors.black, borderRadius: BorderRadius.circular(15)),
  //     child: TextButton(
  //         onPressed: () {
  //           widget.parentController.clearPad();
  //           //function to clean de pad bat still in the pad
  //           // setState(() {
  //           //   keyPad?.currentState?.clear();
  //           //   signaturePic = '';
  //           // });
  //         },
  //         child: Text(
  //           'Clean Pad',
  //           style: TextStyle(color: Colors.white),
  //         )),
  //   );
  // }
}
