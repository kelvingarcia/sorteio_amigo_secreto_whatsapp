import 'package:flutter/cupertino.dart';
import 'package:sorteio_amigo_secreto_whatsapp/model/selected_contact.dart';
import 'package:sorteio_amigo_secreto_whatsapp/utils/size_utils.dart';

class ContactSelection extends StatelessWidget {
  final SelectedContact contact;

  const ContactSelection({Key? key, required this.contact}) : super(key: key);

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
                const Icon(CupertinoIcons.person),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeUtils.fromWidth(context, 0.02),
                  ),
                  child: Text(contact.nome),
                ),
              ],
            ),
            Text(contact.numero)
          ],
        ),
      ),
    );
  }
}
