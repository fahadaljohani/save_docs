import 'package:desktop_app/Repository/sql_helper.dart';
import 'package:desktop_app/models/doc_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class AddDocument extends StatefulWidget {
  const AddDocument({super.key});

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  late TextEditingController attachNumberController;
  late TextEditingController descriptionController;
  List<String> allSections = [
    'ادارة العمليات',
    'ادارة السلامة',
    'ادارة الشوون الادارية',
    'شعبة الموارد البشرية',
    'شعبة الشوون الفنية',
    'شعبة التميز الموسسي',
    'شعبة المراجعة الداخلية ',
    'شعبة الإعلام والإتصال الموسسي ',
    'شعبة الإتصالات وتقنية المعلومات',
  ];
  String? toSectionSelected;
  String fromSectionSelected = 'شعبة الإتصالات وتقنية المعلومات';

  @override
  void initState() {
    super.initState();
    attachNumberController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    // titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ContentDialog(
        title: const Text('صادر جديد'),
        content: ListView(shrinkWrap: true, children: [
          ComboBox<String>(
            value: fromSectionSelected,
            items: allSections.map<ComboBoxItem<String>>((e) {
              return ComboBoxItem<String>(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => fromSectionSelected = value!);
            },
            placeholder: const Text('الجهة المعدة'),
            autofocus: false,
          ),
          const SizedBox(height: 20),
          ComboBox<String>(
            value: toSectionSelected,
            items: allSections.map<ComboBoxItem<String>>((e) {
              return ComboBoxItem<String>(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => toSectionSelected = value);
            },
            placeholder: const Text('صادر الى الجهة'),
            autofocus: true,
          ),
          const SizedBox(height: 20),
          TextBox(
            autocorrect: false,
            // autofillHints: true,
            autofocus: true,
            controller: descriptionController,
            foregroundDecoration: const BoxDecoration(border: Border.fromBorderSide(BorderSide.none)),
            placeholder: 'الموضوع',
            minLines: 8,
            maxLines: 10,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 15),
          TextBox(
            autocorrect: false,
            // autofillHints: true,
            autofocus: false,
            keyboardType: TextInputType.number,
            controller: attachNumberController,
            foregroundDecoration: const BoxDecoration(border: Border.fromBorderSide(BorderSide.none)),
            placeholder: 'عدد المرفقات',
            textInputAction: TextInputAction.done,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ]),
        actions: [
          Button(
            child: const Text('الغاء'),
            onPressed: () => Navigator.pop(context, false),
          ),
          FilledButton(
              child: const Text('حفظ'),
              onPressed: () async {
                if (toSectionSelected == null || descriptionController.text.isEmpty) return;
                if (toSectionSelected == null || descriptionController.text.isEmpty) return;
                final documentModel = DocumentModel(
                    id: null,
                    to: toSectionSelected!,
                    from: fromSectionSelected,
                    description: descriptionController.text,
                    attachNumber: attachNumberController.text.isNotEmpty ? int.parse(attachNumberController.text) : 0,
                    createdAt: DateTime.now());
                final result = await SqlHelper.addDocument(documentModel);
                print("result is $result");
                if (!mounted) return;
                Navigator.pop(context, true);
              }),
        ],
      ),
    );
  }
}
