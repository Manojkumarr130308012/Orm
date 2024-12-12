import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/contants.dart';
import '../../utils/perference_helper.dart';
import '../../utils/text_form_field_widget.dart';
import '../../utils/validate_operations.dart';

class UrlPage extends StatefulWidget {
  const UrlPage({super.key});

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _urlController =
      TextEditingController(text: "https://demoapi.orienseam.com/api");
  bool get validate => _formKey.currentState?.validate() ?? false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enter a URL'),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormFieldWidget(
                  controller: _urlController,
                  title: Constants.urlTitle,
                  hintText: Constants.urlTitle,
                  prefixIcon: Icons.person_2_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    ValidateOperations.normalValidation(value);
                  }
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _sendURLLink,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Change navigation by S
  Future<void> _sendURLLink() async {
    if (validate) {
      PreferenceHelper.setUrl(_urlController.text);
      Navigator.pop(context);
    }
  }
}
