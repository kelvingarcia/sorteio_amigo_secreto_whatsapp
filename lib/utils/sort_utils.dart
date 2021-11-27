import 'package:flutter/cupertino.dart';
import 'package:sorteio_amigo_secreto_whatsapp/model/participante.dart';

class SortUtils {
  static void sortPeople(List<Participante> participantes) {
    List<Participante> shuffledList = List.from(participantes);
    shuffledList.shuffle();
    var hasExclusions = shuffledList.where((element) => element.exclusoes.isNotEmpty).toList();
    var hasNotExclusions = shuffledList.where((element) => element.exclusoes.isEmpty).toList();
    if(hasExclusions.length > hasNotExclusions.length){
      throw 'Quantidade de pessoas com exclusões não pode ser maior do que pessoa sem exclusoes';
    }
    if(hasExclusions.isNotEmpty){
      hasExclusions.forEach((participante) => _sortAndRemove(participante, shuffledList));
      hasNotExclusions.last.pessoaSorteada = shuffledList.removeAt(shuffledList.indexOf(hasExclusions.first)).nome;
    } else {
      hasNotExclusions.last.pessoaSorteada = shuffledList.removeAt(shuffledList.indexOf(hasNotExclusions.first)).nome;
    }    
    hasNotExclusions.forEach((participante) => _sortAndRemove(participante, shuffledList));
  }

  static void _sortAndRemove(Participante participante, List<Participante> shuffledList) {
    if(participante.pessoaSorteada == ''){
      var withoutExclusion = shuffledList.where((element) => !participante.exclusoes.contains(element.nome) && element.nome != participante.nome).toList();
      participante.pessoaSorteada = shuffledList.removeAt(shuffledList.indexOf(withoutExclusion.first)).nome; 
    }
  }
}
