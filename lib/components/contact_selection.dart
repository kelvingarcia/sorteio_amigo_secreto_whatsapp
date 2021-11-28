import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:sorteio_amigo_secreto_whatsapp/model/participante.dart';
import 'package:sorteio_amigo_secreto_whatsapp/screens/create_group.dart';
import 'package:sorteio_amigo_secreto_whatsapp/screens/exceptions.dart';
import 'package:sorteio_amigo_secreto_whatsapp/utils/size_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSelection extends StatelessWidget {
  final CreateGroupState createGroupState;
  final Participante contact;
  final List<Participante> contactList;

  const ContactSelection(
      {Key? key, required this.contact, required this.contactList, required this.createGroupState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: <Widget>[
        CupertinoContextMenuAction(
          child: const Text('Enviar mensagem'),
          onPressed: () async {
            var numero = contact.numero.replaceAll(' ', '').replaceAll('-', '');
            var link =
                'https://sorteio-1637874895562.azurewebsites.net/sorteio-amigo-secreto-garcia/person-view/' +
                    contact.mongoId;
            var whatsappUrl = "whatsapp://send?phone=$numero&text=$link";

            if (await canLaunch(whatsappUrl)) {
              await launch(whatsappUrl);
              createGroupState.setState(() {
                contact.enviado = true;
              });
            } else {
              throw 'Could not launch $whatsappUrl';
            }
          },
        ),
        CupertinoContextMenuAction(
          child: const Text('Adicionar exceção'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => Exceptions(
                  contactList: contactList,
                  participante: contact,
                ),
              ),
            );
          },
        ),
        CupertinoContextMenuAction(
          child: const Text('Deletar'),
          onPressed: () {
            createGroupState.setState(() {              
              contactList.remove(contact);
            });
            Navigator.pop(context);
          },
        ),
      ],
      child: SizedBox(
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
                  Visibility(
                    visible: contact.enviado,
                    child: const Icon(CupertinoIcons.check_mark),
                  ),
                  Visibility(
                    visible: contact.shuffledIndex != 0,
                    child: Text(contact.shuffledIndex.toString()),
                  ),
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
      ),
    );
  }
}
