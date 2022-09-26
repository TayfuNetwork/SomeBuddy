// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';

class language extends StatefulWidget {
  language({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _languageState createState() => _languageState();
}

class _languageState extends State<language> {
  Language _selectedDropdownLanguage = Languages.korean;
  Language _selectedDialogLanguage = Languages.korean;

  // It's sample code of Dropdown Item.
  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }

  // It's sample code of Dialog Item.
  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: LanguagePickerDropdown(
                    initialValue: Languages.korean,
                    itemBuilder: _buildDropdownItem,
                    onValuePicked: (Language language) {
                      _selectedDropdownLanguage = language;
                      print(_selectedDropdownLanguage.name);
                      print(_selectedDropdownLanguage.isoCode);
                    },
                  ),
                ),
              ),
            ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your language'),
                onValuePicked: (Language language) => setState(() {
                      _selectedDialogLanguage = language;
                      print(_selectedDialogLanguage.name);
                      print(_selectedDialogLanguage.isoCode);
                    }),
                itemBuilder: _buildDialogItem)),
      );

  // It's sample code of Cupertino Item.

}
