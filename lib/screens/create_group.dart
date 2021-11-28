import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sorteio_amigo_secreto_whatsapp/components/contact_selection.dart';
import 'package:sorteio_amigo_secreto_whatsapp/database/grupo_dao.dart';
import 'package:sorteio_amigo_secreto_whatsapp/model/grupo.dart';
import 'package:sorteio_amigo_secreto_whatsapp/model/participante.dart';
import 'package:sorteio_amigo_secreto_whatsapp/screens/select_contacts.dart';
import 'package:sorteio_amigo_secreto_whatsapp/utils/size_utils.dart';
import 'package:sorteio_amigo_secreto_whatsapp/utils/sort_utils.dart';
import 'package:http/http.dart' as http;

class CreateGroup extends StatefulWidget {
  final Grupo grupo;
  const CreateGroup({Key? key, this.grupo = const Grupo(0, '', [])})
      : super(key: key);

  @override
  CreateGroupState createState() => CreateGroupState();
}

class CreateGroupState extends State<CreateGroup> {
  GrupoDao _dao = GrupoDao();
  late TextEditingController _textController;
  List<Participante> contactList = [];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.grupo.nome);
    contactList.addAll(widget.grupo.participantes);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: const Text('Grupo'),
        trailing: GestureDetector(
          onTap: () {
            _dao.save(Grupo(0, _textController.text, contactList));
            Navigator.pop(context);
          },
          child: const Text(
            'Finalizar',
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: SizeUtils.fromHeight(context, 1),
          color: CupertinoColors.inactiveGray,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(SizeUtils.fromWidth(context, 0.05)),
                  child: SizedBox(
                    height: SizeUtils.fromHeight(context, 0.05),
                    child: CupertinoTextField(
                      controller: _textController,
                      placeholderStyle: const TextStyle(
                        color: CupertinoColors.inactiveGray,
                      ),
                      placeholder: 'Nome do grupo',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SizeUtils.fromWidth(context, 0.05)),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CupertinoButton(
                      color: CupertinoColors.white,
                      onPressed: () async {
                        final PermissionStatus permissionStatus =
                            await _getPermission();
                        if (permissionStatus == PermissionStatus.granted) {
                          debugPrint('granted');
                          List<Contact> contacts =
                              await ContactsService.getContacts();
                          final Participante contact = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  SelectContacts(contactList: contacts),
                            ),
                          );
                          setState(() {
                            contactList.add(contact);
                          });
                        }
                      },
                      child: const Text(
                        'Importar contatos',
                        style: TextStyle(
                          color: CupertinoColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: contactList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContactSelection(
                        createGroupState: this,
                        contact: contactList[index],
                        contactList: contactList,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SizeUtils.fromWidth(context, 0.05)),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      onPressed: () {
                        //debugPrint(contactList.toString());
                        setState(() {});
                        debugPrint(contactList.toString());
                        contactList
                            .forEach((element) => element.pessoaSorteada = '');
                        try {
                          SortUtils.sortPeople(contactList);
                        } catch (e) {
                          String errorMessage;
                          if (e.toString() ==
                              'Quantidade de pessoas com exclusões não pode ser maior do que pessoa sem exclusoes') {
                            errorMessage = e.toString();
                          } else {
                            errorMessage = 'Houve um erro tente novamente.';
                          }
                          showCupertinoDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text('Alerta'),
                              content: Text(errorMessage),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text('OK'),
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          );
                        }
                        contactList.forEach((element) async {
                          debugPrint(
                              element.nome + ": " + element.pessoaSorteada);
                          // final response = await http.post(
                          //   Uri.parse(
                          //       'https://save-sort-save-sort.azuremicroservices.io/save-sort/save-person'),
                          //   headers: <String, String>{
                          //     'Content-Type': 'application/json',
                          //   },
                          //   body: jsonEncode(
                          //     <String, String>{
                          //       'name': element.nome +
                          //           "(" +
                          //           _textController.text +
                          //           ")",
                          //       'sortedPersonName': element.pessoaSorteada,
                          //     },
                          //   ),
                          // );

                          // if (response.statusCode == 200) {
                          //   contactList
                          //       .where((participante) =>
                          //           participante.nome == element.nome)
                          //       .first
                          //       .mongoId = jsonDecode(response.body)['id'];
                          //   debugPrint(element.nome +
                          //       ": " +
                          //       jsonDecode(response.body)['id']);
                          // }
                        });
                      },
                      child: const Text(
                        'Sortear grupo',
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<PermissionStatus> _getPermission() async {
    debugPrint('Entrou no getPermission');
    final PermissionStatus permission = await Permission.contacts.status;
    debugPrint(permission.toString());
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }
}
