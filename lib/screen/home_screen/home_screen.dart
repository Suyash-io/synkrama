import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Synkrama'),actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: SizedBox(
                height: 300,
                child: ListView.builder(itemBuilder: (context,index) {
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage('images/super-man.jpg'),fit: BoxFit.cover)
                      ),
                    ),
                  );
                },
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                ),
              ),
            ),
            SizedBox(
              height: 500,
              width: Get.width * 0.5,
              child: ListView.builder(itemBuilder: (context,index) {
                return Card(
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    height: 250,
                    width: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/cartoon-dragon.jpg'),fit: BoxFit.cover)
                    ),
                  ),
                );
              },
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 10,
              ),
            ),
            GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 50,crossAxisSpacing: 20), itemBuilder: (context,index) {
              return Card(
                clipBehavior: Clip.hardEdge,
                child: Container(
                  height: 70,
                  decoration:  const BoxDecoration(
                image: DecorationImage(image: AssetImage('images/warrior-urban.jpg'),fit: BoxFit.cover)
              ),
                ),
              );
            },
            itemCount: 9,
            shrinkWrap: true,
            )
          ],
        ),
      )
    );
  }
}
