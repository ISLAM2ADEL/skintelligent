import 'package:skintelligent/commons.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.listTileColor,
      required this.primaryIcon,
      required this.title});
  final Color listTileColor;
  final IconData primaryIcon;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(13),
                bottomRight: Radius.circular(13)),
            color: Colors.white54,
            border: Border(
                bottom: BorderSide(color: Colors.black12),
                right: BorderSide(color: Colors.black12),
                top: BorderSide(color: Colors.black12),
                left: BorderSide(color: Colors.black12))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            VerticalDivider(
              width: 0,
              thickness: 4,
              color: listTileColor,
            ),
            const SizedBox(
              width: 20,
            ),
            ClipRRect(
              child: Icon(primaryIcon, color: listTileColor, size: 35),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: 50,
              child: VerticalDivider(
                  width: 0,
                  thickness: 2.7,
                  color: listTileColor.withValues(alpha: 0.3)),
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              "$title",
              style: TextStyle(fontSize: 18, color: listTileColor),
            ),
            const SizedBox(
              width: 30,
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: listTileColor,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
