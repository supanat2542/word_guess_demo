import 'package:flutter/material.dart';
import 'package:word_guess/model/data_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess Words',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 71, 19, 160),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();
  late Data currentWord;
  bool? result;

  @override
  void initState() {
    super.initState();
    currentWord = getRandomWord();
  }

  void checkAnswer() {
    if (controller.text.trim().toLowerCase() ==
        currentWord.english.toLowerCase()) 
    {
      setState(() {
        result = true;
      });
    } else {
      setState(() {
        result = false;
      });
    }
  }

  void nextWord() {
    setState(() {
      currentWord = getRandomWord();
      controller.clear();
      result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset(currentWord.filePath, height: 200),
            Text(currentWord.english, style: const TextStyle(fontSize: 24)),
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "พิมพ์คำตอบภาษาอังกฤษ",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => checkAnswer(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: checkAnswer,
                  child: const Text("ตรวจคำตอบ"),
                ),
                ElevatedButton(
                  onPressed: nextWord,
                  child: const Text("คำถัดไป"),
                ),
              ],
            ),
            Text(result == true ? "ถูกต้อง 🎉" : result == false ? "ผิด ❌" : "", style: const TextStyle(fontSize: 20)),
            if (result != null && result == false) Text("คำตอบคือ: ${currentWord.english} แปลว่า ${currentWord.thai}", style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
