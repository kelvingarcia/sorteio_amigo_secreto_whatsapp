import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sorteio_amigo_secreto_whatsapp/model/selected_contact.dart';
import 'package:sorteio_amigo_secreto_whatsapp/utils/size_utils.dart';

class SelectContacts extends StatefulWidget {
  final List<Contact> contactList;

  const SelectContacts({Key? key, List<Contact> this.contactList = const []})
      : super(key: key);

  @override
  _SelectContactsState createState() => _SelectContactsState();
}

class _SelectContactsState extends State<SelectContacts> {
  late String _selectedValue;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: const Text('Contatos'),
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
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: widget.contactList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _selectedValue = widget.contactList[index].phones!.first.value!;
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoActionSheet(
                              title: const Text('Selecione o número'),
                              message: Container(
                                height: SizeUtils.fromHeight(context, 0.12),
                                child: CupertinoPicker(
                                  itemExtent: 30,
                                  scrollController: FixedExtentScrollController(
                                      initialItem: 0),
                                  children: List<Widget>.generate(
                                    widget.contactList[index].phones!.length,
                                    (i) {
                                      return Center(
                                        child: Text(widget
                                            .contactList[index].phones![i].value!),
                                      );
                                    },
                                  ),
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      _selectedValue = widget.contactList[index].phones![value].value!;
                                    });
                                  },
                                ),
                              ),
                              actions: <CupertinoActionSheetAction>[
                                CupertinoActionSheetAction(
                                  child: const Text('Adicionar número'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context, SelectedContact(0, widget.contactList[index].displayName!, _selectedValue, ''));
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: SizedBox(
                          height: SizeUtils.fromHeight(context, 0.05),
                          child: Text(widget.contactList[index].displayName!),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}