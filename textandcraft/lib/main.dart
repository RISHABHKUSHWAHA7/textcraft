import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(randon());
}

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {

       MaterialColor customColor = MaterialColor(0xFF76885B, {
      50: Color(0xFF76885B),
      100: Color(0xFFC1C5B3),
      200: Color(0xFF9B9F86),
      300: Color(0xFF757A5A),
      400: Color(0xFF5C6145),
      500: Color(0xFF627254), // This is your hex color
      600: Color(0xFF485032),
      700: Color(0xFF3A3E28),
      800: Color(0xFF2C2F1D),
      900: Color(0xFF14160B),
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Font and Color Picker',
      theme: ThemeData(
        primarySwatch:customColor,
      ),
      home: FontAndColorPicker(),
    );
  }
}

class FontAndColorPicker extends StatefulWidget {
  @override
  _FontAndColorPickerState createState() => _FontAndColorPickerState();
}

class _FontAndColorPickerState extends State<FontAndColorPicker> {
  String selectedFont = 'Roboto';
  Color selectedColor = Colors.black;
  double fontSize = 35.0;
  TextEditingController textEditingController = TextEditingController();
  String typedText = '';
  List<String> fontList = [
    'Montserrat',
    'Roboto',
    'OpenSans',
    'RubikScribble',
    'TacOne',
    'Workbench',
    'ButterflyKids',
    'DancingScript',
    'Pacifico',
  ];
  List<String> undoStack = [];
  List<String> redoStack = [];

  void increaseFontSize() {
    setState(() {
      fontSize += 2.0;
    });
  }

  void decreaseFontSize() {
    setState(() {
      if (fontSize > 2.0) {
        fontSize -= 2.0;
      }
    });
  }

  void clearAll() {
    setState(() {
      undoStack.add(typedText); // Store current text in undoStack
      typedText = '';
      textEditingController.clear();
      redoStack.clear(); // Clear redoStack as well
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Font and Color Picker'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              Text(
                typedText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: selectedFont,
                  color: selectedColor,
                  fontSize: fontSize,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: textEditingController,
                onChanged: (text) {
                  setState(() {
                    typedText = text;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Type something...',
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: DropdownButton<String>(
                  value: selectedFont,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFont = newValue!;
                    });
                  },
                  dropdownColor: Color.fromARGB(255, 235, 237, 239),
                  items: fontList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (undoStack.isNotEmpty) {
                          redoStack.add(typedText);
                          typedText = undoStack.removeLast();
                          textEditingController.text = typedText;
                        }
                      });
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(100, 20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF161A30)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(13)),
                      elevation: MaterialStateProperty.all<double>(4),
                    ),
                    child: Text('Undo'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (redoStack.isNotEmpty) {
                          undoStack.add(typedText);
                          typedText = redoStack.removeLast();
                          textEditingController.text = typedText;
                        }
                      });
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(100, 20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF161A30)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(13)),
                      elevation: MaterialStateProperty.all<double>(4),
                    ),
                    child: Text('Redo'),
                  ),
                  ElevatedButton(
                    onPressed: clearAll,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(100, 20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF161A30)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(13)),
                      elevation: MaterialStateProperty.all<double>(4),
                    ),
                    child: Text('Clear All'),
                  ),
                ],
              ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: increaseFontSize,
                    child: Text('Increase Font Size'),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(100, 20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFB2A59B)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16)),
                      elevation: MaterialStateProperty.all<double>(4),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: decreaseFontSize,
                    child: Text('Decrease Font Size'),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(100, 20)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFB2A59B)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16)),
                      elevation: MaterialStateProperty.all<double>(4),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select Text Color: '),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      _pickColor();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickColor() async {
    Color? pickedColor = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(2.0),
                topRight: const Radius.circular(2.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedColor);
              },
              child: Text('Select'),
            ),
          ],
        );
      },
    );
    if (pickedColor != null) {
      setState(() {
        selectedColor = pickedColor;
      });
    }
  }
}

// random text 


class randon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor customColor = MaterialColor(0xFF76885B, {
      50: Color(0xFF76885B),
      100: Color(0xFFC1C5B3),
      200: Color(0xFF9B9F86),
      300: Color(0xFF757A5A),
      400: Color(0xFF5C6145),
      500: Color(0xFF627254), // This is your hex color
      600: Color(0xFF485032),
      700: Color(0xFF3A3E28),
      800: Color(0xFF2C2F1D),
      900: Color(0xFF14160B),
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Font and Color Picker',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      home: RandomTextPage(),
    );
  }
}

class RandomTextPage extends StatefulWidget {
  @override
  _RandomTextPageState createState() => _RandomTextPageState();
}

class _RandomTextPageState extends State<RandomTextPage> {
  String randomText = '';

  @override
  void initState() {
    super.initState();
    // Generate initial random text
    randomText = generateRandomText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Text Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                randomText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Refresh the text when button is pressed
                  setState(() {
                    randomText = generateRandomText();
                  });
                },
                child: Text('Generate Random Text'),
              ),
              SizedBox(height: 60),

              // Navigation button to FontAndColorPicker class
              ElevatedButton(
                onPressed: () {
                  // Navigate to FontAndColorPicker class
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FontAndColorPicker()),
                  );
                },
                child: Text('Go to Font and Color Picker'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generateRandomText() {
    // Generate random text using the faker package
    final faker = Faker();
    return faker.lorem.sentence();
  }
}
