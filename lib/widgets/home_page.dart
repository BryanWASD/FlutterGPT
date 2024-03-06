import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var results = "results...";
  late var openAI;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openAI = OpenAI.instance.build(
        token: "token",
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
        enableLog: true);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SingleChildScrollView(child: Text(results)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // final request = CompleteText(
                    //     prompt: textEditingController.text,
                    //     model: Davinci002Model(),
                    //     maxTokens: 200);
                    // try {
                    //   final response =
                    //       await openAI.onCompletion(request: request);
                    //   results = response!.choices.first.text;
                    //   setState(() {
                    //     results;
                    //   });
                    // } catch (e) {
                    //   results = ("unable to get the result $e");
                    //   setState(() {
                    //     results;
                    //   });
                    // }

                    void _generateImage() {
                      var prompt = textEditingController.text;

                      final request = GenerateImage(
                          model: DallE2(),
                          prompt,
                          1,
                          size: ImageSize.size256,
                          responseFormat: Format.url);
                      final response = openAI.generateImage(request);
                      print("img url :${response.data?.last?.url}");
                    }

                    textEditingController.clear();
                  },
                  child: Icon(Icons.send),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}