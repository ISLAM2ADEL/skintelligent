import 'package:skintelligent/commons.dart';

class CustomScannerView extends StatelessWidget {
  const CustomScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return  ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withValues(alpha: 100),
          BlendMode.dstOut,
        ),
        child: Stack(
          children: [
            Container(
              decoration:  BoxDecoration(
                color: Colors.white.withValues(alpha: 100),
                backgroundBlendMode: BlendMode.srcOut,
              ),
            ),
            // Custom Borders on four corners
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 230,
                height: 230,
                child: Stack(
                  children: [
                    // Top-left border
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 40,
                        height: 5,
                        color: Colors.blue,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 5,
                        height: 40,
                        color: Colors.blue,
                      ),
                    ),

                    // Top-right border
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 40,
                        height: 5,
                        color: Colors.blue,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 5,
                        height: 40,
                        color: Colors.blue,
                      ),
                    ),

                    // Bottom-left border
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 40,
                        height: 5,
                        color: Colors.blue,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 5,
                        height: 40,
                        color: Colors.blue,
                      ),
                    ),

                    // Bottom-right border
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 40,
                        height: 5,
                        color: Colors.blue,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 5,
                        height: 40,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
