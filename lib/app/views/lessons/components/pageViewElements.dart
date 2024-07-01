import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obamahome/utils/cores_personalizadas.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/app_theme.dart';
import '../../../controllers/search_controller.dart';
import '../../../models/search_models.dart';
import 'initialText.dart';

List<String> pageHints = [
  'Qual o nome da instituição a que se destina esse plano de aula?*',
  'Escreva uma frase curta que defina sua aula.*',
  'A qual ano de ensino esta proposta de aula melhor se aplica?*',
  'Quanto tempo (em minutos) você acha necessário para a aplicação deste plano de aula?*'
];
List<String> options = <String>['Todos'];

List<Widget> paveViewContent = [
  PageViewFirst(),
  PageViewSecond(),
  PageViewThird(),
];

class PageViewFirst extends StatefulWidget {
  const PageViewFirst({super.key});

  @override
  State<PageViewFirst> createState() => _PageViewFirstState();
}

class _PageViewFirstState extends State<PageViewFirst> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        constraints: BoxConstraints(maxWidth: 1200),
        child: Column(children: [
          for (var i = 0; i < pageHints.length; i++) ...{
            if (i == 2) ...{
              Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 4),
                  child: DropdownButton<String>(
                      value: options.first,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 5,
                      style: textTheme.bodySmall,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        // setState(() {
                        //   dropdownValue = value!;
                        // });
                      },
                      items:
                          options.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(child: Text(value)),
                        );
                      }).toList())),
            } else ...{
              Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                      onSubmitted: (value) async {
                        // updateData(value);
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                        hintText: pageHints[i],
                        hintStyle: textTheme.bodySmall,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        filled: true,
                        // fillColor: Colors.grey.shade100
                      ))),
            }
          },
        ]));
  }
}

class PageViewThird extends ConsumerStatefulWidget {
  const PageViewThird({super.key});

  @override
  _PageViewThirdState createState() => _PageViewThirdState();
}

class _PageViewThirdState extends ConsumerState<PageViewThird> {
  List<SearchModel?> searchData = [];
  List<String> selectedOA = [];
  List<String>? cachedObjects = [];

  @override
  void initState() {
    getData();
    getObjects();
    super.initState();
  }

  void getData() async {
    SearchResponse fetchedData = await fetchDataAndUpdateState("", ref);
    SearchResponse pagination = fetchedData;
    List<SearchModel?> newPagination = pagination.content;
    setState(() {
      searchData = newPagination;
    });
  }

  void getObjects() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList('objects');
    setState(() {
      selectedOA = items!;
      cachedObjects = items;
    });
    // listOAText(_controller);
  }

  List<String> listOAText(QuillController _controller) {
    List<String> allSelectedOA = [];

    for (var selected in selectedOA) {
      try {
        var mainList = new Delta()
          ..insert(selected)
          ..insert("\n", {"list": "bullet"});

        _controller.compose(
            mainList,
            TextSelection.collapsed(offset: mainList.length),
            ChangeSource.local);

        String plainText = _controller.document.toPlainText();
        allSelectedOA.add(plainText);
      } catch (err, st) {
        print('Cannot read welcome.json: $err\n$st');
        _controller = _controller;
        return [];
      }
    }
    return allSelectedOA;
  }

  void addObjects() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('objects', selectedOA);
    getObjects();
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: background,
      ),
      constraints: BoxConstraints(maxWidth: 1200, maxHeight: 600),
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Wrap(
        children: [
          Container(
            width: swidth > 1200 ? 1200 * .6 : swidth * .6,
            child: Column(children: [
              Text("Escolha os OA"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: Colors.black38),
              ),
              for (var i = 0; i < searchData.length; i++) ...{
                // print(search?.nome);
                Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    color: i % 2 == 0 ? Colors.white : Colors.black12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(searchData[i]!.nome),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  bool itemExists =
                                      selectedOA.contains(searchData[i]!.nome);
                                  if (!itemExists) {
                                    selectedOA.add(searchData[i]!.nome);
                                    addObjects();
                                  }
                                },
                                child: Icon(Icons.add_circle,
                                    color: CoresPersonalizadas.azulObama)),
                            InkWell(
                                onTap: () {
                                  selectedOA.remove(searchData[i]!.nome);
                                  addObjects();
                                },
                                child: Icon(Icons.remove_circle,
                                    color: CoresPersonalizadas.azulObama)),
                          ],
                        ),
                      ],
                    )),
              }
            ]),
          ),
          Container(
            width: swidth > 1200 ? 1200 * .4 : swidth * .4,
            child: Column(children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("OA selecionados"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      cachedObjects == null || cachedObjects!.isEmpty
                          ? SizedBox()
                          : Tooltip(
                              message: "Remover tudo",
                              child: InkWell(
                                onTap: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.remove('objects');
                                  setState(() {
                                    selectedOA = [];
                                    cachedObjects = [];
                                  });
                                },
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                      child: Icon(Icons.clear,
                                          size: 18, color: onError)),
                                ),
                              )),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: Colors.black38),
              ),
              if (cachedObjects == null || cachedObjects!.isEmpty) ...{
                Text("Sua lista de OA está vazia")
              } else ...{
                for (var cacheObject in cachedObjects!) ...{Text(cacheObject)}
              }
            ]),
          )
        ],
      ),
    );
  }
}

class PageViewSecond extends ConsumerStatefulWidget {
  const PageViewSecond({super.key});

  @override
  _PageViewSecondState createState() => _PageViewSecondState();
}

class _PageViewSecondState extends ConsumerState<PageViewSecond> {
  QuillController _controller = QuillController.basic();
  String imageUrl = "";
  List<SearchModel?> searchData = [];

  @override
  void initState() {
    getData();
    _initController(_controller);
    super.initState();
  }

  void getData() async {
    SearchResponse fetchedData = await fetchDataAndUpdateState("", ref);
    SearchResponse pagination = fetchedData;
    List<SearchModel?> newPagination = pagination.content;
    setState(() {
      searchData = newPagination;
    });
  }

  void _pickImageURL() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
            constraints: BoxConstraints(maxWidth: 450, maxHeight: 400),
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Cole abaixo o link da sua imagem"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(color: Colors.black38),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
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
                  ),
                  SizedBox(height: 15),
                  TextButton(
                      style: ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(250, 50))),
                      child: Text("Enviar url", style: textTheme.displaySmall),
                      onPressed: () {
                        setState(() {
                          imageUrl = imageUrl;
                        });
                        Navigator.of(context).pop();
                        sendImageURL();
                      }),
                ]),
          ));
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
    return Column(
      children: [
        Container(
          //Barra de edição
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
              // buttonOptions: QuillSimpleToolbarButtonOptions(
              //   fontSize: QuillToolbarFontSizeButtonOptions(
              //     childBuilder: (options, extraOptions) {
              //       return Column(children: [
              //         Text("10"),
              //         Text("12"),
              //         Text("14"),
              //         Text("16"),
              //       ]);
              //     },
              //   )
              // ),
              customButtons: [
                QuillToolbarCustomButtonOptions(
                  tooltip: "Inserir imagem",
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: background,
                            ),
                            constraints:
                                BoxConstraints(maxWidth: 450, maxHeight: 400),
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "Insira imagens do seu dispositivo ou da internet"),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Divider(color: Colors.black38),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        fixedSize: WidgetStatePropertyAll(
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
                                        fixedSize: WidgetStatePropertyAll(
                                            Size(250, 50))),
                                    child: Text("Inserir link da internet",
                                        style: textTheme.displaySmall),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _pickImageURL();
                                    },
                                  )
                                ]),
                          ));
                        });
                  },
                ),
                QuillToolbarCustomButtonOptions(
                  tooltip: "Adicionar Objetos de Aprendizagem",
                  icon: Icon(Icons.gamepad),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: background,
                              ),
                              constraints:
                                  BoxConstraints(maxWidth: 900, maxHeight: 600),
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: Column(children: [
                                Text("Escolha os OAs"),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(color: Colors.black38),
                                ),
                                for (var i = 0; i < searchData.length; i++) ...{
                                  // print(search?.nome);
                                  Container(
                                      height: 40,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      color: i % 2 == 0
                                          ? Colors.white
                                          : Colors.black12,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(searchData[i]!.nome),
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {},
                                                  child: Icon(Icons.add_circle,
                                                      color: CoresPersonalizadas
                                                          .azulObama)),
                                              InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                      Icons.remove_circle,
                                                      color: CoresPersonalizadas
                                                          .azulObama)),
                                            ],
                                          ),
                                        ],
                                      )),
                                }
                              ]),
                            ),
                          );
                        });
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
          //Folha do texto
          margin: EdgeInsets.only(bottom: 50),
          height: 1200,
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
          child: QuillEditor.basic(
            scrollController: ScrollController(),
            configurations: QuillEditorConfigurations(
              controller: _controller,
              // placeholder: initText(_controller),
              customStyles: DefaultStyles(
                paragraph: DefaultTextBlockStyle(
                    TextStyle(color: onPrimary, fontSize: 14),
                    VerticalSpacing(0, 0),
                    VerticalSpacing(0, 0),
                    BoxDecoration()),
              ),
              sharedConfigurations: QuillSharedConfigurations(
                locale: Locale('pt', 'BR'),
              ),
              embedBuilders: kIsWeb
                  ? FlutterQuillEmbeds.editorWebBuilders()
                  : FlutterQuillEmbeds.editorBuilders(),
            ),
          ),
        )
      ],
    );
  }
}

void _initController(QuillController controller) {
  initText(controller);
}