import 'package:skintelligent/commons.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Column(
      children: [
        const SizedBox(height: 20),

        const Row(
            children: <Widget>[
              Expanded(
                  child: Divider(
                    color: Color(0xffdcdcdc),
                    thickness: 2  ,
                  )
              ),

              Text("  Or  "),

              Expanded(
                  child: Divider(
                    color: Color(0xffdcdcdc),
                    thickness: 2  ,
                  )
              ),
            ]
        ),
        const SizedBox(height: 20),

      ],
    ) ;
  }
}
