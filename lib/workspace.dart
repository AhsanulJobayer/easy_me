import 'dart:convert';

import 'dart:io';
//import 'package:universal_html/html.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';
import 'package:tflite/tflite.dart';

class workspace extends StatefulWidget{
  final String workspace_ID;
  final String username;
  workspace({Key? key, required this.workspace_ID, required this.username}) : super(key: key);


  @override
  ChatPage createState() => ChatPage(workspace_ID, username);
}

class ChatPage extends State<workspace> {
  List<types.Message> _messages = [];
  final String workspace_ID;
  final String username;
  ChatPage(this.workspace_ID, this.username);
  //final _user = const types.User(id: '1234');

  @override
  void initState() {

    print("workspace_ID:: ");
    print(workspace_ID);
    print(username);

    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      //_messages.insert(0, message);

      String unique_ID = message.id + message.createdAt.toString();
      print("Unique_ID: " +unique_ID);
      FirebaseFirestore.instance.collection("Messages").doc(unique_ID).set(message.toJson());
    });
  }

  void setMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final user = types.User(id: username);
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {

      late File file;

      setState(() {
        file = File(result.files.single.path!);
      });

      late String url;
      //cloud storage upload
      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(result.files.single.name + DateTime.now().millisecondsSinceEpoch.toString());
      TaskSnapshot uploadTask = await firebaseStorageRef.putFile(file);

      try{
        if (uploadTask.state == TaskState.success) {
          url = await firebaseStorageRef.getDownloadURL();
        }
        print(url);
      }
      catch(e){
        print(e);
      }

      final message = types.FileMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: workspace_ID,
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: url,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final user = types.User(id: username);
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      //File? selectedImage = File(result.path, result.name);
      late File img;

      setState(() {
        img = File(result.path);
      });

      late String url;
      //cloud storage upload
      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(result.name + DateTime.now().millisecondsSinceEpoch.toString());
      TaskSnapshot uploadTask = await firebaseStorageRef.putFile(img);

      try{
        if (uploadTask.state == TaskState.success) {
          url = await firebaseStorageRef.getDownloadURL();
        }
        print(url);
      }
      catch(e){
        print(e);
    }

      print("isuploaded: ");
      print(uploadTask);


      final message = types.ImageMessage(
        author: user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: workspace_ID,
        name: result.name,
        size: bytes.length,
        uri: url,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final user = types.User(id: username);
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: workspace_ID,
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    getDocs();
    final response = await rootBundle.loadString('assets/messages.json');
    // final messages = (jsonDecode(response) as List)
    //     .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
    //     .toList();

    final messages = _messages;

    setState(() {
      _messages = messages;
    });
  }

  Future getDocs() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Messages').where('id', isEqualTo: workspace_ID).get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<types.Message> blank = [];
    _messages = blank;
    int i;
    for(i = 0; i < data.length; i++) {

      Map<String, dynamic> single_message = data[i] as Map<String, dynamic>;

      final user = types.User(id: single_message['author']['id']);

      if(single_message['type'] == "text") {
        String text = single_message['text'];
        print("text: " +text);

        final textMessage = types.TextMessage(
          author: user,
          createdAt: single_message['createdAt'],
          id: single_message['id'],
          text: single_message['text'],
        );

        setMessage(textMessage);
      }
      else if(single_message['type'] == "file") {

        final message = types.FileMessage(
          author: user,
          createdAt: single_message['createdAt'],
          id: single_message['id'],
          mimeType: single_message['mimeType'],
          name: single_message['name'],
          size: single_message['size'],
          uri: single_message['uri'],
        );

        setMessage(message);
      }
      else if(single_message['type'] == "image") {

        //String height = single_message['height'];
        //double parameter = await int.parse(single_message['height']).toDouble();
        final message = types.ImageMessage(
          author: user,
          createdAt: single_message['createdAt'],
          height: single_message['height'],
          id: single_message['id'],
          name: single_message['name'],
          size: single_message['size'],
          uri: single_message['uri'],
          width: single_message['width'],
        );

        setMessage(message);
      }
    }
    print(_messages.toString());
    print("data :");
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    final user = types.User(id: username);

    getDocs();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAtachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          user: user,
        ),
      ),
    );
  }
}
