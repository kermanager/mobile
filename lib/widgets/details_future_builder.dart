import 'package:flutter/material.dart';

class DetailsFutureBuilder<T> extends StatefulWidget {
  final Future<T> Function() future;
  final Widget Function(BuildContext, T) builder;

  const DetailsFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  State<DetailsFutureBuilder<T>> createState() =>
      _DetailsFutureBuilderState<T>();
}

class _DetailsFutureBuilderState<T> extends State<DetailsFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
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
          T data = snapshot.data as T;
          return widget.builder(context, data);
        }
        return const Center(
          child: Text('Aucune donnée'),
        );
      },
    );
  }
}
