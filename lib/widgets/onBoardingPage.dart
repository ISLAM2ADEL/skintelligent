import 'package:skintelligent/commons.dart' ;
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.image , required this.title,  required this.subTitle });
final String image , title , subTitle  ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(
            height: 170,
          ),
          Image.asset(
            image,
            width: 300,
            height: 300,
          ),
          const SizedBox(
            height: 100,
          ),
           Text(
            title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child:  Center(
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
              ),
            ),
          )

        ],
      ),
    );
  }
}
