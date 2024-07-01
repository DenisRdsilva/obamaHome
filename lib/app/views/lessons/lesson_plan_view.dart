import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obamahome/app/controllers/lessons_controller.dart';
import 'package:obamahome/app/models/lesson_plan_models.dart';
import 'package:obamahome/templates/template_basic_col.dart';
import 'package:obamahome/utils/app_padding.dart';
import 'package:obamahome/utils/app_theme.dart';

class ListLessonPlan extends ConsumerStatefulWidget {
  const ListLessonPlan({super.key});

  @override
  _ListLessonPlanState createState() => _ListLessonPlanState();
}

class _ListLessonPlanState extends ConsumerState<ListLessonPlan> {
  String searchTerm = "";
  int _currentPage = 0;
  int _itemsPerPage = 10;

  List<LessonPlan> _pagedItems(List<LessonPlan> data) {
    int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (endIndex > data.length) {
      endIndex = data.length;
    }
    return data.sublist(startIndex, endIndex);
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: randomName(searchTerm, ref),
      builder: (context, snapshot) {
        final lessonsData = ref.watch(lessons);
        List<LessonPlan> data = [...lessonsData];
        return TemplateColumn(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 1200),
              color: borderInput,
              margin: paddingValues("carouselTop", context),
              padding: paddingValues("sideMainPadding", context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                    child: TextField(
                      decoration: InputDecoration(
                          constraints: BoxConstraints(
                              maxWidth: 600, minWidth: 200, maxHeight: 39),
                          filled: true,
                          fillColor: background,
                          hintText: "Busca",
                          hintStyle: textTheme.bodySmall,
                          border: InputBorder.none,
                          suffixIcon: Icon(CupertinoIcons.search,
                              color: secondary, size: 16)),
                      onChanged: (value) {
                        setState(() {
                          searchTerm = value;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          searchTerm = value;
                        });
                      },
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: (_pagedItems(data).length ~/ _itemsPerPage) + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildHeader();
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _pagedItems(data).length,
                          itemBuilder: (context, index) {
                            final lessonPlan = _pagedItems(data)[index];
                            return _buildRow(
                              lessonPlan.titulo,
                              lessonPlan.autor,
                              lessonPlan.dataPublicacao.toString(),
                            );
                          },
                        );
                      }
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(10.0),
                        child: Scrollbar(
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                10,
                                (index) => Container(
                                  width: 20,
                                  padding: EdgeInsets.all(0.0),
                                  margin: EdgeInsets.all(0.0),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all<
                                          EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                          horizontal: 0.0,
                                        ),
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          side: BorderSide.none,
                                        ),
                                      ),
                                      overlayColor: WidgetStatePropertyAll(
                                        Color(0x00000000),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                        Color(0x00000000),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          _currentPage = index;
                                        },
                                      );
                                    },
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Material(
      child: Container(
        color: borderInput,
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(0.0),
        child: const Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.0,
                ),
                child: Text(
                  'Título',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Autor',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Data de Publicação',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String author, String date) {
    return Material(
      child: InkWell(
        hoverColor: const Color(0x00000001),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.black87,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(author),
                ),
                Expanded(
                  flex: 1,
                  child: Text(date),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
