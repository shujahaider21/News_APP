import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/screens/tags_screen.dart';

class HeadlineScreen extends StatelessWidget {
  const HeadlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Headlines"),
        actions: [
          IconButton(
            icon: const Icon(Icons.tag),
            onPressed: () {
              Get.to(() => TagsScreen());
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.getNews();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              } else if (controller.news.isEmpty) {
                return const Center(child: Text("No News Found!"));
              } else {
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            controller.news[index].urlToImage ?? '',
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.news[index].title.length > 20
                                  ? "${controller.news[index].title.substring(0, 20)}..."
                                  : controller.news[index].title,
                            ),
                            Text(controller.news[index].publishedAt),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            itemCount: controller.news.length,
          ),
        ),
      ),
    );
  }
}
