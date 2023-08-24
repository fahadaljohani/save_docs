import 'package:desktop_app/Repository/sql_helper.dart';
import 'package:desktop_app/models/doc_model.dart';
import 'package:desktop_app/pages/documents.dart';
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
      appBar: NavigationAppBar(
        title: const Text(
          'متابعة المعاملات الواردة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        actions: Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          child: OutlinedButton(
            onPressed: () async {
              final result = await showDialog(
                  context: context,
                  builder: (context) {
                    return const AddDocument();
                  });
              if (result == true) {
                // listOfAllDocuments = await SqlHelper.getAllDocumnets();
                setState(() {});
              }
            },
            // onPressed: () => SqlHelper.dropTable(),
            style: ButtonStyle(shape: ButtonState.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
            child: const Text('صادر جديد'),
          ),
        ),
      ),
      pane: NavigationPane(
          displayMode: PaneDisplayMode.open,
          selected: curIndex,
          size: const NavigationPaneSize(
            openMaxWidth: 200,
            openMinWidth: 100,
          ),
          onChanged: (value) {
            setState(() {
              curIndex = value;
            });
          },
          items: <NavigationPaneItem>[
            PaneItem(
              icon: const Icon(FluentIcons.document_management),
              title: const Text('عرض المستندات'),
              body: const ShowDocuments(),
            ),
            PaneItem(
                icon: const Icon(FluentIcons.search),
                title: const Text('البحث'),
                body: const Center(child: Text('البحث'))),
            PaneItem(
                icon: const Icon(FluentIcons.sign_out),
                title: const Text('خروج'),
                body: const Center(child: Text('خروج'))),
          ]),
    );
  }
}
