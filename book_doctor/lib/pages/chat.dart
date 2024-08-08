
import 'package:book_dctor/core/colors.dart';
import 'package:book_dctor/generated/l10n.dart';
import 'package:book_dctor/payment/strip_keys.dart';
import 'package:book_dctor/widgets/general_textfromfiled.dart';
import 'package:book_dctor/widgets/message.dart';
import 'package:book_dctor/widgets/show_dilog.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late final GenerativeModel model;
  late final ChatSession chatSession;
  final TextEditingController controllerChat = TextEditingController();
  final ScrollController scrollController = ScrollController();
  GlobalKey<FormState> globalKey = GlobalKey();
  List<Content> chatHistory = [];
  bool loading = false;
  @override
  void initState(){
    super.initState();
    model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: PaymentKeys.apiChatAi);
    chatSession = model.startChat();
    chatHistory = chatSession.history.toList();
  }
  
  @override
  void dispose(){
    super.dispose();
    controllerChat.dispose();
  }                                                                                                                                                        
  // Void Error
  void showError (){
    showDialog(context: context, builder: (BuildContext context){
      return ShowdialogSuccess(message: S.of(context).ErrorINAI, onPressed: (){Navigator.pop(context);}, stateImage: "assets/cry.png", mainText: "Error", buttomText: "Ok");
    });
  }
  // void scrollDown 
  void scroolDown (){
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => scrollController.animateTo(scrollController.position.maxScrollExtent ,
      duration: const Duration(milliseconds: 750) , curve: Curves.easeInCirc)
    );
  }
  // void send message 
  Future<void> sendmessage (String message) async {
    // Loading true
    setState(() {
      loading = true;
    });

    try{
      final res = await chatSession.sendMessage(Content.text(message));
      final text = res.text;
      if(text == null){
        showError();
      } else{
        // stop loading
        setState(() {
          loading = false;
          chatHistory.add(Content.text(text)); // AI 
          chatHistory.add(Content.text(message)); // user 
            scroolDown();
            controllerChat.clear();
        });
      }
    }
    catch(e){
      showError();
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkcolorButton = theme.brightness == Brightness.dark ?
    const Color(0xFF4A4A4A) :
    const Color.fromARGB(255, 99, 234, 182) ;

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).askDoctorAI , style: const TextStyle(fontWeight: FontWeight.bold),) ,centerTitle: true,),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.01
        ),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              Expanded(child: 
              ListView.builder(
                controller: scrollController,
                itemCount: chatHistory.length ,
                itemBuilder: (context , index){
                  // For chat 
                  final Content content = chatSession.history.toList()[index];
                  final text = content.parts.whereType<TextPart>().map<String>((e) => e.text).join("");
                  return MessageWiget(message: text, isUser: content.role == "user");
                })),
            Padding(padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: GeneralTextfromfiled(heightText: 55,controller: controllerChat , color: darkcolorButton , textInputType: TextInputType.text ,validator: (val){if(val!.isEmpty){return S.of(context).EmptyMessage;}
return null;},)),
                const SizedBox(width: 7,),
                GestureDetector(onTap: (){
                  // to check that message not empty 
                  if(globalKey.currentState!.validate()){
                      sendmessage(controllerChat.text);
                  }},child: loading == false ? const Icon(Icons.send , size: 30,color: apiMessageColor,) :  const CircularProgressIndicator(color: blueMain,))
              ],
            ))
            ],
          ),
        ),
      ),
    );
  }
}