import 'package:flutter/material.dart';
import 'package:wmbt/common/style/common_style.dart';

class LanguageSelector extends StatefulWidget {
  final List<Language> languages;
  final Function(Language) onLanguageChanged;

  LanguageSelector({required this.languages, required this.onLanguageChanged});

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  Language? _selectedLanguage;

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language', style: CommonStyle.text_12_white,),
          contentPadding: EdgeInsets.only(top: 12.0),
          content: SingleChildScrollView(
            child: ListBody(

              children: widget.languages
                  .map((language) => ListTile(
                leading: Image.asset(language.flag),
                title: Text(language.name, style: TextStyle(color: Colors.white),),
                textColor: Colors.red,
                onTap: () {
                  setState(() {
                    _selectedLanguage = language;
                  });
                  widget.onLanguageChanged(language);
                  Navigator.pop(context);
                },
                selected: _selectedLanguage == language,
              ))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () => _showLanguageDialog(context),
          icon: Image.asset(_selectedLanguage?.flag ?? widget.languages[0].flag),
          label: Text(_selectedLanguage?.name ?? widget.languages[0].name, style: TextStyle(color: Colors.white),),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff251e2c)),
          ),
        ),
      ],
    );
  }
}

class Language {
  final String name;
  final String flag;

  Language({required this.name, required this.flag});
}
