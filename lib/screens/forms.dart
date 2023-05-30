import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/screens/form.model.dart';

class FormBuilder extends StatefulWidget {
  const FormBuilder({super.key});

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  List<FormModel> formList = [];
  Map<String, dynamic> controller = {};

  bool _isLoading = true;

  loadData() async {
    var jsonObj = await rootBundle.loadString('form_data.json');
    var response = json.decode(jsonObj);

    response.forEach((item) {
      formList.add(FormModel.fromJson(item));
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: formList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [Text(formList[index].title), myForm(index)],
              );
            },
          ),
          ElevatedButton(
              onPressed: () {
                inspect(controller);
              },
              child: Text("data")),
        ],
      ),
    );
  }

  ListView myForm(int index) {
    for (var element in formList[index].fields) {
      controller.addAll({element.label: TextEditingController()});
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, idx) => const SizedBox(
        height: 10.0,
      ),
      itemCount: formList[index].fields.length,
      itemBuilder: (context, idx) {
        switch (formList[index].fields[idx].fieldType) {
          case "TextInput":
            return TextField(
              controller: controller[formList[index].fields[idx].label],
            );
          case "DatetimePicker":
            return TextField(
              controller: controller[formList[index].fields[idx].label],
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2050),
                );
                if (pickedDate != null) {
                  controller[formList[index].fields[idx].label].text =
                      pickedDate.toIso8601String();
                }
              },
            );
          // case "SelectList":
          //   return Selection(
          //     // controller: controller[formList[index].fields[idx].label],
          //     value: ,
              
          //   );

          default:
            return Text(formList[index].fields[idx].fieldType);
        }
      },
    );
  }
}
