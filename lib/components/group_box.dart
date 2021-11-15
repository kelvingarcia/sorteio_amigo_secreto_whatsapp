import 'package:flutter/cupertino.dart';
import 'package:sorteio_amigo_secreto_whatsapp/utils/size_utils.dart';

class BoxGroup extends StatefulWidget {
  const BoxGroup({Key? key}) : super(key: key);

  @override
  _BoxGroupState createState() => _BoxGroupState();
}

class _BoxGroupState extends State<BoxGroup> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(CupertinoIcons.group),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeUtils.fromWidth(context, 0.02),
                ),
                child: const Text('Nome do grupo'),
              ),
            ],
          ),
          Row(
            children: const [Text('15'), Icon(CupertinoIcons.right_chevron)],
          ),
        ],
      ),
    );
  }
}
