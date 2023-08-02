import 'package:flutter/material.dart';
import 'package:planeta_uz/chat/chat_model.dart';
import 'package:planeta_uz/chat/chat_provider.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<LoginProvider>().logOut(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: context.read<ChatProvider>().getMessages(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("data not found"),
                    );
                  }
                  if (snapshot.hasData) {
                    return snapshot.data!.isNotEmpty
                        ? ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            children: [
                              ...List.generate(snapshot.data!.length, (index) {
                                MessageModel x = snapshot.data[index];
                                return Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      
                                      Text(
                                        x.message,
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                      Text(
                                        x.createdAt
                                            .toString()
                                            .substring(11, 16),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                );
                              })
                            ],
                          )
                        : const Center(
                            child: Text('Data Empty'),
                          );
                  }
                  return const Center(
                    child: Text('Null'),
                  );
                },
              ),
            ),
            TextFormField(
              controller: context.read<ChatProvider>().textEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Type...",
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<ChatProvider>().addmessage(
                          context: context,
                          messageModel: MessageModel(
                              message: context
                                  .read<ChatProvider>()
                                  .textEditingController
                                  .text,
                              createdAt: DateTime.now(),
                              uid: context.read<LoginProvider>().user!.uid,
                              messageId: ''));

                      context
                          .read<ChatProvider>()
                          .textEditingController
                          .clear();
                    },
                    icon: const Icon(Icons.send),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
