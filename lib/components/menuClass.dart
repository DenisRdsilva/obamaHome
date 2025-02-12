import 'package:flutter/material.dart';
import 'package:obamahome/app/models/lesson_plan_models.dart';
import 'package:obamahome/auth/controller.dart';

class ItemValue {
  List<String?> subItems;
  final List<bool> subItemHover;
  bool itemHover;
  final String name;
  final List<String> path;
  final Function? action;

  ItemValue(
      {required this.subItems,
      required this.subItemHover,
      required this.name,
      required this.itemHover,
      required this.path,
      this.action = null});
}

List<ItemValue> getItemValues() {
  return [
    ItemValue(
      name: "Início",
      path: ['/'],
      subItems: [],
      itemHover: false,
      subItemHover: List.generate(1, (index) => false),
    ),
    ItemValue(
      name: "Sobre",
      path: ['/sobre'],
      subItems: [],
      itemHover: false,
      subItemHover: List.generate(1, (index) => false),
    ),
    ItemValue(
      name: "Serviços",
      path: ['/objetos-aprendizagem', '/trilhas', '/manuais'],
      subItems: ["OA", "Trilhas", "Manuais"],
      itemHover: false,
      subItemHover: List.generate(3, (index) => false),
    ),
    // ItemValue(
    //   name: "Publicações",
    //   path: ['/blog', '/blog-detalhes'],
    //   subItems: ["Lista de Posts", "Último post"],
    //   itemHover: false,
    //   subItemHover: List.generate(2, (index) => false),
    // ),
    ItemValue(
      name: "Formações",
      path: ['/formacoes'],
      subItems: [],
      itemHover: false,
      subItemHover: List.generate(1, (index) => false),
    ),
    hasUserSession
        ? ItemValue(
            name: "Planos de Aula",
            path: ['/planos-aulas/lista', '/planos-aulas/criar'],
            subItems: ['Lista', 'Criar um novo'],
            itemHover: false,
            subItemHover: List.generate(2, (index) => false),
          )
        : null
  ]
      .where((e) => e != null) // removendo os itens nulos
      .map((item) => item!)
      .toList();
}
