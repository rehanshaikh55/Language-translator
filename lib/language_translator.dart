import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslatorPage extends StatefulWidget {
  const LanguageTranslatorPage({super.key});

  @override
  State<LanguageTranslatorPage> createState() => _LanguageTranslatorPageState();
}

class _LanguageTranslatorPageState extends State<LanguageTranslatorPage> {
  var language = ["hindi", "english", "german", "spanish", "urdu"];
  var originlanguage = "From";
  var destinationlanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();
  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == '--' || dest == '--') {
      setState(() {
        output = "failed to translate";
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == "english") {
      return "en";
    }
    if (language == "hindi") {
      return "hi";
    }
    if (language == "german") {
      return "de";
    }
    if (language == "spanish") {
      return "es";
    }
    if (language == "urdu") {
      return "ur";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 27, 67),
      appBar: AppBar(
        title: const Text("Language Translator by Rehan"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      focusColor: const Color.fromARGB(255, 55, 50, 50),
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      hint: Text(
                        originlanguage,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                      dropdownColor: const Color.fromARGB(255, 32, 29, 29),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: language.map((String dropDownStringItem) {
                        return DropdownMenuItem(
                          child: Text(
                            dropDownStringItem,
                          ),
                          value: dropDownStringItem,
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          originlanguage = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationlanguage,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                    dropdownColor: const Color.fromARGB(255, 31, 28, 28),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: language.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationlanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: "Enter your text",
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15)),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your text";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 75, 129, 222)),
                  onPressed: () {
                    translate(
                        getLanguageCode(originlanguage),
                        getLanguageCode(destinationlanguage),
                        languageController.text.toString());
                  },
                  child: const Text("Translate"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "\n$output",
                style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
