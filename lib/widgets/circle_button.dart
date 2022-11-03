import 'package:fitatu_clone/common.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.child,
    this.onTap,
    this.size = 48,
    this.color,
  });

  final double size;
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size),
      child: Ink(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          color: color,
        ),
        child: Center(child: child),
      ),
    );
  }
}
