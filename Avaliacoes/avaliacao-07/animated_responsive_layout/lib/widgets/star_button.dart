import 'package:flutter/material.dart';

class StarButton extends StatefulWidget {
  const StarButton({super.key});

  @override
  State<StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<StarButton> {
  bool _isStarred = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _isStarred ? 'Unstar email' : 'Star email',
      onPressed: () => setState(() => _isStarred = !_isStarred),
      icon: Icon(_isStarred ? Icons.star : Icons.star_border),
    );
  }
}
