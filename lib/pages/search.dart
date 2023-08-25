import 'package:desktop_app/Repository/sql_helper.dart';
import 'package:desktop_app/models/doc_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<DocumentModel>? tempList = [];

  TextEditingController searchController = TextEditingController();

  void filteredSearchQuery(String searchText) async {
    List<DocumentModel>? filteredList = await SqlHelper.getAllDocumnets();
    if (filteredList == null) return;
    tempList = filteredList.where((element) => element.description.contains(searchText)).toList();
    filteredList = [];
    setState(() {});
  }

  final style = TextStyle(fontSize: 12, color: Colors.grey[100]);
  final styleHeader = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .50,
                margin: const EdgeInsets.only(right: 5),
                child: TextBox(
                  controller: searchController,
                  placeholder: 'بحث في معاملات الصادرة',
                  foregroundDecoration: const BoxDecoration(border: Border.fromBorderSide(BorderSide.none)),
                  decoration: BoxDecoration(color: Colors.grey[30]),
                  prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FluentIcons.search,
                      color: Colors.grey[130],
                    ),
                  ),
                  onChanged: (value) {
                    filteredSearchQuery(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Table(
            columnWidths: const {
              0: FractionColumnWidth(0.05),
              1: FractionColumnWidth(0.50),
              4: FractionColumnWidth(0.10),
              5: FractionColumnWidth(0.07)
            },
            border: TableBorder.symmetric(
              outside: BorderSide.none,
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey[80],
                  ),
                  children: [
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          '-',
                          style: styleHeader,
                        )),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: Text(
                          'الموضوع',
                          style: styleHeader,
                        ))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: Text(
                          'الجهة المعدة',
                          style: styleHeader,
                        ))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: Text(
                          'صادر للجهة ',
                          style: styleHeader,
                        ))),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(
                            child: Text(
                          'بتاريخ',
                          style: styleHeader,
                        ))),
                    const TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Center(child: Icon(FluentIcons.button_control))),
                  ]),
              if (tempList != null && tempList!.isNotEmpty && searchController.text != '')
                ...List.generate(tempList!.length, (index) {
                  final doc = tempList![index];
                  return TableRow(
                    decoration: BoxDecoration(color: index.isEven ? Colors.grey[20] : Colors.white),
                    children: [
                      TableCell(
                          child: Text(
                        doc.id.toString(),
                        style: const TextStyle(fontSize: 10),
                      )),
                      TableCell(
                          child: Text(
                        doc.description,
                        style: const TextStyle(fontSize: 14),
                      )),
                      TableCell(
                          child: Center(
                        child: Text(
                          doc.from,
                          style: style,
                        ),
                      )),
                      TableCell(child: Center(child: Text(doc.to, style: style))),
                      TableCell(
                          child:
                              Center(child: Text(DateFormat('yyyy/MM/dd', 'ar').format(doc.createdAt), style: style))),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(icon: const Icon(FluentIcons.edit), onPressed: () {}),
                            IconButton(
                                icon: Icon(
                                  FluentIcons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  final result = await SqlHelper.deleteDocument(doc);
                                  if (result != 0) {
                                    tempList = await SqlHelper.getAllDocumnets();
                                    setState(() {});
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  );
                })
            ],
          ),
        ]),
      ),
    );
  }
}
