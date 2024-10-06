import 'package:flutter/material.dart';

class ListFutureBuilder<T> extends StatefulWidget {
  final Future<List<T>> Function() future;
  final Widget Function(BuildContext, T) builder;

  const ListFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  State<ListFutureBuilder<T>> createState() => _ListFutureBuilderState<T>();
}

class _ListFutureBuilderState<T> extends State<ListFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: widget.future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No items found'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              T item = snapshot.data![index];
              return widget.builder(context, item);
            },
          );
        }
        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }
}
