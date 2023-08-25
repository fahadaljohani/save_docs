import 'package:desktop_app/pages/documents.dart';
import 'package:desktop_app/widgets/add_doc.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AddNewDocument extends StatelessWidget {
  const AddNewDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: () async {
        final result = await showDialog(
            context: context,
            builder: (context) {
              return const AddDocument();
            });
        if (result == true) {
          // listOfAllDocuments = await SqlHelper.getAllDocumnets();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/add_doc.png'),
          const Text('صادر جديد'),
        ],
      ),
    ));
  }
}
