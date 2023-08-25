import 'package:desktop_app/Repository/sql_helper.dart';
import 'package:desktop_app/models/doc_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

class ShowDocuments extends StatefulWidget {
  const ShowDocuments({super.key});

  @override
  State<ShowDocuments> createState() => _ShowDocumentsState();
}

class _ShowDocumentsState extends State<ShowDocuments> {
  List<DocumentModel>? tempList = [];
  @override
  void initState() {
    getDocuments();
    super.initState();
  }

  getDocuments() async {
    tempList = await SqlHelper.getAllDocumnets();
    if (!mounted) return;
    setState(() {});
  }

  final style = TextStyle(fontSize: 12, color: Colors.grey[100]);
  final styleHeader = const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    getDocuments();
    return tempList != null && tempList!.isNotEmpty
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Table(
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
                        const TableCell(
                            child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            FluentIcons.numbered_list,
                            size: 10,
                          ),
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
                            child: Text(
                              'الجهة المعدة',
                              style: styleHeader,
                            )),
                        TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Text(
                              'صادر للجهة ',
                              style: styleHeader,
                            )),
                        TableCell(
                            verticalAlignment: TableCellVerticalAlignment.middle,
                            child: Text(
                              'بتاريخ',
                              style: styleHeader,
                            )),
                        const TableCell(verticalAlignment: TableCellVerticalAlignment.middle, child: Text('')),
                      ]),
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
                              child: Center(
                                  child: Text(DateFormat('yyyy/MM/dd', 'ar').format(doc.createdAt), style: style))),
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
                          )),
                        ]);
                  }),
                ],
              ),
            ),
          )
        : const Center(child: Text('لا يوجد بيانات'));
  }
}
