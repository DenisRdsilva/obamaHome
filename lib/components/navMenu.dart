import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

class ItemValue {
  final List<String> subItems;
  final List<bool> subItemHover;
  bool itemHover;
  final String name;
  final List<String> path;

  ItemValue(
      {required this.subItems,
      required this.subItemHover,
      required this.name,
      required this.itemHover,
      required this.path});
}

final List<ItemValue> itemValues = [
  ItemValue(
    name: "HOME",
    path: ['/', '/'],
    subItems: ["Item 1", "Item 2"],
    itemHover: false,
    subItemHover: List.generate(2, (index) => false),
  ),
  ItemValue(
    name: "SOBRE",
    path: ['/sobre'],
    subItems: ["Sobre"],
    itemHover: false,
    subItemHover: List.generate(1, (index) => false),
  ),
  ItemValue(
    name: "SERVIÇOS",
    path: ['/servicos', '/trilhas', '/manuais'],
    subItems: ["OA", "Trilhas", "Manuais"],
    itemHover: false,
    subItemHover: List.generate(3, (index) => false),
  ),
  ItemValue(
    name: "PUBLICAÇÕES",
    path: ['/blog', 'blog-details'],
    subItems: ["Lista de Posts", "Último post"],
    itemHover: false,
    subItemHover: List.generate(2, (index) => false),
  ),
  ItemValue(
    name: "FORMAÇÕES",
    path: ['/formacoes', '/formacoes'],
    subItems: ["Item 1", "Item 2"],
    itemHover: false,
    subItemHover: List.generate(2, (index) => false),
  ),
  ItemValue(
    name: "PLANOS DE AULA",
    path: ['/loja', '/loja'],
    subItems: ["Item 1", "Item 2"],
    itemHover: false,
    subItemHover: List.generate(2, (index) => false),
  ),
];

class NavMenu extends StatefulWidget {
  final double swidth;
  final double heightBtn;

  const NavMenu({
    required this.swidth,
    required this.heightBtn,
  });

  @override
  State<NavMenu> createState() => _NavMenuState();
}

String searchText = '';

Future searchObject(context, String value) async {
  Navigator.pushNamed(context, '/servicos', arguments: value);
}

class _NavMenuState extends State<NavMenu> {
  bool isHovered = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    double swidth = MediaQuery.of(context).size.width;

    return MenuBar(children: [
      for (int i = 0; i < itemValues.length; i++) ...{
        Padding(
            padding: EdgeInsets.only(left: 18),
            child: SubmenuButton(
              onHover: (value) {
                setState(() {
                  itemValues[i].itemHover = value;
                });
              },
              menuStyle: MenuStyle(
                backgroundColor: MaterialStateProperty.all(background),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(background),
                foregroundColor: MaterialStateProperty.all(
                    itemValues[i].path.contains(currentRoute)
                        ? primary
                        : itemValues[i].itemHover
                            ? primary
                            : onPrimary),
                textStyle: MaterialStateProperty.all(textTheme.headlineSmall),
              ),
              menuChildren: <Widget>[
                if (i >= 0 && i < itemValues.length) ...{
                  for (var j = 0; j < itemValues[i].subItems.length; j++) ...{
                    Container(
                      decoration: BoxDecoration(
                          // color: background,
                          border: j == 0
                              ? Border(
                                  top: BorderSide(color: surface, width: 3))
                              : Border(top: BorderSide.none)),
                      child: MenuItemButton(
                        onHover: (value) {
                          setState(() {
                            itemValues[i].itemHover = value;
                            itemValues[i].subItemHover[j] = value;
                          });
                        },
                        style: ButtonStyle(
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 20)),
                          minimumSize: MaterialStatePropertyAll(Size(250, 44)),
                          backgroundColor:
                              MaterialStateProperty.all(background),
                          overlayColor: MaterialStateProperty.all(primary),
                          foregroundColor: MaterialStateProperty.all(
                              itemValues[i].subItemHover[j]
                                  ? background
                                  : onPrimary),
                          textStyle:
                              MaterialStateProperty.all(textTheme.displaySmall),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, itemValues[i].path[j],
                              arguments: '');
                        },
                        child: MenuAcceleratorLabel(itemValues[i].subItems[j]),
                      ),
                    )
                  }
                }
              ],
              child: MenuAcceleratorLabel(itemValues[i].name),
            )),
      },
      MenuItemButton(
          onHover: (value) {
            setState(() {
              isHovered = value;
            });
          },
          style: ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size(40, 40)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Icon(CupertinoIcons.search,
                size: 20, color: isHovered ? primary : onPrimary),
          ),
          onPressed: () => showDialog<String>(
                barrierColor: modalBackground,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  backgroundColor: onSecondary,
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        padding: EdgeInsets.only(left: 20),
                        width: swidth * .7,
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: swidth * .6,
                              child: TextField(
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      color: background),
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 20),
                                      hintText: "Busca de OA",
                                      hintStyle: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: background,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: secondary))),
                                  onChanged: (value) => setState(() {
                                        searchText = value;
                                      }),
                                  onSubmitted: (value) {
                                    searchObject(context, value);
                                  }),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              child: IconButton(
                                hoverColor: null,
                                highlightColor: null,
                                icon: Icon(CupertinoIcons.search,
                                    color: secondary, size: 80),
                                onPressed: () {
                                  searchObject(context, searchText);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 25),
                            child: Text(
                                "Consulte os OA disponíveis no nosso catálogo",
                                style: textTheme.displaySmall),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
    ]);
  }
}
