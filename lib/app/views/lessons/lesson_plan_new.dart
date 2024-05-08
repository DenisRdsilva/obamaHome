import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obamahome/components/navMenu.dart';
import 'package:obamahome/components/topbar.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

import '../../../utils/app_theme.dart';
import '../../controllers/search_controller.dart';
import '../../models/search_models.dart';
import 'components/initialText.dart';
import 'components/textEditorClass.dart';

class NewLessonPlan extends ConsumerStatefulWidget {
  const NewLessonPlan({super.key});

  @override
  _NewLessonPlanState createState() => _NewLessonPlanState();
}

class _NewLessonPlanState extends ConsumerState<NewLessonPlan> {
  QuillController _controller = QuillController.basic();

  String imageUrl = "";
  List<SearchModel?> searchData = [];

  @override
  void initState() {
    super.initState();
    getData();
    // _initController(_controller);
    // print(_controller.document.toDelta().toHtml());
  }

  void getData() async {
    dynamic fetchedData = await fetchDataAndUpdateState("", ref);
    // final fetchedData = ref.watch(searchPagination);
    // searchData = [...fetchedData];
    SearchResponse pagination = fetchedData.$1;
    List<SearchModel?> newPagination = pagination!.content;
    setState(() {
      searchData = newPagination;
    });
  }

  // Future<void> savePDF() async {
  //   var archive = _controller.document;
  //   var deltaToPDF = await _controller.document.toDelta().toPdf();
  //   var pdfHeight = archive.length.toDouble();

  //   if (pdfHeight > 1200) {
  //     archive.queryChild(0);
  //   }

  // }

  void _pickImageURL() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text("Cole abaixo o link da sua imagem"),
                ),
                TextField(
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: secondary),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 20),
                        hintText: "Link da imagem",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: secondary,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondary))),
                    onChanged: (value) => setState(() {
                          imageUrl = value;
                        }),
                    onSubmitted: (value) {
                      setState(() {
                        imageUrl = value;
                      });
                    }),
                SizedBox(height: 15),
                TextButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(250, 50))),
                    child: Text("Enviar url", style: textTheme.displaySmall),
                    onPressed: () {
                      setState(() {
                        imageUrl = imageUrl;
                      });
                      Navigator.of(context).pop();
                      sendImageURL();
                    }),
              ]));
        });
  }

  void sendImageURL() {
    _controller.insertImageBlock(
      imageSource: imageUrl,
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final String imagePath = pickedImage.path;
      final File file = File(imagePath);
      // print(" imagePath => $imagePath");

      if (kIsWeb) {
        _controller.insertImageBlock(
          imageSource: imagePath,
        );
      } else {
        _controller.insertImageBlock(
          imageSource: file.path.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double logoWidth = 250;

    if (swidth < 700) {
      logoWidth = 180;
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          TopBar(swidth),
          Container(
            margin: EdgeInsets.symmetric(horizontal: swidth * .1),
            padding: const EdgeInsets.only(top: 35, bottom: 15),
            constraints: BoxConstraints(maxWidth: 1200),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Material(
                  //   child: TextButton(
                  //       onPressed: () => Navigator.of(context).pop(),
                  //       child: Row(
                  //         children: [
                  //           Icon(Icons.arrow_back, size: 16),
                  //           if (swidth > 800) ...{Text("Voltar")}
                  //         ],
                  //       )),
                  // ),
                  Image.asset("assets/images/logo.png", width: logoWidth),
                  NavMenu(swidth: swidth, heightBtn: 50, itemValues: editorValues, searchAvailable: false,)
                  // TextButton(
                  //     onPressed: () async {
                  //       // savePDF();
                  //       var doc = _controller.document
                  //           .toDelta()
                  //           .toHtml(); //salvar como html
                  //       // print("archive => ${doc}");
                  //     },
                  //     child: Row(
                  //       children: [
                  //         Icon(Icons.save_as, size: 16),
                  //         if (swidth > 800) ...{
                  //           SizedBox(width: 5),
                  //           Text("Salvar")
                  //         } 
                  //       ],
                  //     ))
                ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Divider(thickness: 1, color: secondary),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: swidth * .1),
            child: QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                showAlignmentButtons: true,
                showHeaderStyle: false,
                showIndent: false,
                showListCheck: false,
                showQuote: false,
                showInlineCode: false,
                showCodeBlock: false,
                controller: _controller,
                sharedConfigurations: QuillSharedConfigurations(
                  locale: Locale('pt', 'BR'),
                ),
                customButtons: [
                  QuillToolbarCustomButtonOptions(
                    tooltip: "Inserir imagem",
                    icon: const Icon(Icons.image),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 20),
                                    child: Text(
                                        "Insira imagens do seu dispositivo ou da internet"),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStatePropertyAll(
                                            Size(250, 50))),
                                    child: Text("Inserir imagem da sua galeria",
                                        style: textTheme.displaySmall),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _pickImage();
                                    },
                                  ),
                                  SizedBox(height: 15),
                                  TextButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStatePropertyAll(
                                            Size(250, 50))),
                                    child: Text("Inserir link da internet",
                                        style: textTheme.displaySmall),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _pickImageURL();
                                    },
                                  )
                                ]));
                          });

                    },
                  ),
                  QuillToolbarCustomButtonOptions(
                    icon: Icon(Icons.games),
                    onPressed: () {
                      // showDialog(context: context, builder:(context) {
                      //   return AlertDialog(
                      //     content: Column(children: [
                            for (var search in searchData){
                              debugPrint(search!.nome);
                              // Text(search!.nome),
                            }
                      //     ]),
                      //   );
                      // });
                    },
                  )               
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 30),
            child: Divider(thickness: 1, color: secondary),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 80),
            padding: EdgeInsets.symmetric(vertical: 72, horizontal: 91),
            decoration: BoxDecoration(color: background, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.8,
                blurRadius: 5.0,
                offset: Offset(0.0, 3.0),
              ),
            ]),
            constraints: BoxConstraints(maxWidth: 900),
            child: Expanded(
              child: QuillEditor.basic(
                scrollController: ScrollController(),
                configurations: QuillEditorConfigurations(
                  controller: _controller,
                  placeholder: initText(_controller),
                  customStyles: DefaultStyles(
                    paragraph: DefaultTextBlockStyle(TextStyle(color: onPrimary, fontSize: 14), VerticalSpacing(0, 0), VerticalSpacing(0, 0), BoxDecoration()),
                  ),
                  minHeight: 1200,
                  sharedConfigurations: QuillSharedConfigurations(
                    locale: Locale('pt', 'BR'),
                  ),
                  embedBuilders: kIsWeb
                      ? FlutterQuillEmbeds.editorWebBuilders()
                      : FlutterQuillEmbeds.editorBuilders(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// String _initController(QuillController controller) {
//   return initText(controller);
// }
