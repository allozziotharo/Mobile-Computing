import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/*  COSI CHIAMIAMO LO SNACKBAR IN ALTRE PAGINE

import del file '...'

non deve per forza stare in un onPressed ma quasi sicuramente serviranno li
onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: ErrorMessageContent(errorText: "messaggio di errore"),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ));
          }
*/

class ErrorMessageContent extends StatelessWidget {
  const ErrorMessageContent({required this.errorText, super.key});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 100,
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Oh No!",
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                    const Spacer(),
                    Text(
                      errorText,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              "assets/icons/redbubbles.svg",
              height: 48,
              width: 40,
            ),
          ),
        ),
        Positioned(
          top: -10, //se lo aumento viene tagliato
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/red.svg",
                height: 40,
              ),
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  "assets/icons/cross.svg",
                  height: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
