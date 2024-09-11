import 'package:baatchit/controller/firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class voidfuncationClass {
  void customBottomSheet(BuildContext context, String chatId, String msg) {
    final provider = Provider.of<ChatController>(context, listen: false);
    final updateController = TextEditingController(text: msg);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: updateController,
                            decoration: InputDecoration(
                              prefixIconColor: Colors.black,
                              contentPadding: const EdgeInsets.all(0),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(Icons.emoji_emotions),
                              hintText: 'Message',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                            )),
                      ),
                      const SizedBox(width: 5),
                      CircleAvatar(
                        radius: 25,
                        child: IconButton(
                            onPressed: () {
                              provider.updateMsg(updateController, chatId);
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                                Icons.keyboard_double_arrow_right_sharp)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
