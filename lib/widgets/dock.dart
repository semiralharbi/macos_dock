import 'package:flutter/material.dart';

class Dock<T extends Object> extends StatefulWidget {
  const Dock({
    super.key,
    this.items = const [],
    required this.builder,
  });

  final List<T> items;
  final Widget Function(T, bool) builder;

  @override
  State<Dock<T>> createState() => _DockState<T>();
}

class _DockState<T extends Object> extends State<Dock<T>>
    with SingleTickerProviderStateMixin {
  late final List<T> _items = widget.items.toList();
  int? _draggingIndex;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _items.asMap().entries.map((entry) {
          int index = entry.key;
          T item = entry.value;
          return Draggable<T>(
            data: item,
            feedback: SizedBox(
              height: 70,
              width: 70,
              child: widget.builder(item, true),
            ),
            onDragStarted: () {
              setState(() {
                _draggingIndex = index;
              });
            },
            onDragCompleted: () {
              setState(() {
                _draggingIndex = null;
              });
            },
            onDraggableCanceled: (_, __) {
              setState(() {
                _draggingIndex = null;
              });
            },
            child: DragTarget<T>(
              onAcceptWithDetails: (receivedItem) {
                setState(() {
                  int currentIndex = _items.indexOf(receivedItem.data);
                  _items.removeAt(currentIndex);
                  _items.insert(index, receivedItem.data);
                  _draggingIndex = null;
                });
              },
              onWillAcceptWithDetails: (receivedItem) {
                if (receivedItem.data != item) {
                  setState(() {
                    int currentIndex = _items.indexOf(receivedItem.data);
                    _items.removeAt(currentIndex);
                    _items.insert(index, receivedItem.data);
                    _draggingIndex = index;
                  });
                  return true;
                }
                return false;
              },
              builder: (context, candidateData, rejectedData) {
                return _draggingIndex == index
                    ? Container(
                        width: 64,
                        height: 64,
                        color: Colors.transparent,
                      )
                    : widget.builder(item, _draggingIndex == index);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
