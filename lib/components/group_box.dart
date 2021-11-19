import 'package:flutter/cupertino.dart';
import 'package:sorteio_amigo_secreto_whatsapp/utils/size_utils.dart';

class BoxGroup extends StatefulWidget {
  final String? nomeGrupo;
  final int? quantidadePessoas;

  const BoxGroup({Key? key, String? this.nomeGrupo, int? this.quantidadePessoas}) : super(key: key);

  @override
  _BoxGroupState createState() => _BoxGroupState();
}

class _BoxGroupState extends State<BoxGroup> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.black,
              width: 1.0,
            ),
          ),
        ),
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
                  child: Text(widget.nomeGrupo ?? ''),
                ),
              ],
            ),
            Row(
              children: [Text(widget.quantidadePessoas.toString()), Icon(CupertinoIcons.right_chevron)],
            ),
          ],
        ),
      ),
    );
  }
}
