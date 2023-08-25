import 'package:desktop_app/Repository/sql_helper.dart';
import 'package:desktop_app/models/doc_model.dart';
import 'package:desktop_app/pages/add_new.dart';
import 'package:desktop_app/pages/documents.dart';
import 'package:desktop_app/pages/search.dart';
import 'package:desktop_app/widgets/add_doc.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DocumentModel>? listOfAllDocuments;
  @override
  void initState() {
    super.initState();
    // getAllDocs();
  }

  getAllDocs() async {
    listOfAllDocuments = await SqlHelper.getAllDocumnets();
    setState(() {});
  }

  int curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text(
          'متابعة المعاملات الواردة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        // actions: Container(
        //   margin: const EdgeInsets.only(left: 20, top: 15),
        //   child: OutlinedButton(
        //     onPressed: () async {
        //       final result = await showDialog(
        //           context: context,
        //           builder: (context) {
        //             return const AddDocument();
        //           });
        //       if (result == true) {
        //         // listOfAllDocuments = await SqlHelper.getAllDocumnets();
        //         setState(() {});
        //       }
        //     },
        //     // onPressed: () => SqlHelper.dropTable(),
        //     style: ButtonStyle(shape: ButtonState.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
        //     child: const Text('صادر جديد'),
        //   ),
        // ),
      ),
      pane: NavigationPane(
          displayMode: PaneDisplayMode.open,
          selected: curIndex,
          size: const NavigationPaneSize(
            openMaxWidth: 150,
            openMinWidth: 80,
          ),
          onChanged: (value) {
            setState(() {
              curIndex = value;
            });
          },
          items: <NavigationPaneItem>[
            PaneItem(
              icon: const Icon(FluentIcons.new_folder),
              title: const Text('جديد'),
              body: const AddNewDocument(),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.document_management),
              title: const Text('المعاملات الصادرة'),
              body: const ShowDocuments(),
            ),
            PaneItem(icon: const Icon(FluentIcons.search), title: const Text('البحث'), body: const Search()),
            PaneItem(
                icon: const Icon(FluentIcons.info),
                title: const Text('تنفيذ'),
                body: const Center(child: Text('فكرة الرئيس بندر الحافضي وتنفيذ الرائد فهد الجهني'))),
          ]),
    );
  }
}
