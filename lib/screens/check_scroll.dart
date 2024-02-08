import 'package:flutter/material.dart';

class MyAppScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("bnvn"),),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('AppBar Title'),
                background: Image.network(
                  'https://example.com/image.jpg', // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                childCount: 50, // Replace with your desired item count
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Another Item $index'),
                  );
                },
                childCount: 50, // Replace with your desired item count
              ),
            ),
          ],
        ),

    );
  }
}
