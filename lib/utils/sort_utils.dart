import 'package:sorteio_amigo_secreto_whatsapp/model/participante.dart';

class SortUtils {
  static void sortPeople(List<Participante> participantes) {
    List<Participante> shuffledList = List.from(participantes);
    shuffledList.shuffle();
    List<Participante> auxList = List.from(shuffledList);
    var hasExclusions = shuffledList.where((element) => element.exclusoes.isNotEmpty).toList();
    var hasNotExclusions = shuffledList.where((element) => element.exclusoes.isEmpty).toList();
    if(hasExclusions.length > hasNotExclusions.length){
      throw 'Quantidade de pessoas com exclusões não pode ser maior do que pessoa sem exclusoes';
    }
    if(hasExclusions.isNotEmpty){
      hasExclusions.forEach((participante) => _sortAndRemove(participante, shuffledList, auxList));
      hasNotExclusions.last.pessoaSorteada = shuffledList.removeAt(shuffledList.indexOf(hasExclusions.first)).nome;
      hasNotExclusions.last.shuffledIndex = auxList.indexOf(hasExclusions.first) + 1;
    } else {
      hasNotExclusions.last.pessoaSorteada = shuffledList.removeAt(shuffledList.indexOf(hasNotExclusions.first)).nome;
      hasNotExclusions.last.shuffledIndex = auxList.indexOf(hasNotExclusions.first) + 1;
    }    
    hasNotExclusions.forEach((participante) => _sortAndRemove(participante, shuffledList, auxList));
  }

  static void _sortAndRemove(Participante participante, List<Participante> shuffledList, List<Participante> auxList) {
    if(participante.pessoaSorteada == ''){
      var withoutExclusion = shuffledList.where((element) => !participante.exclusoes.contains(element.nome) && element.nome != participante.nome).toList();
      participante.pessoaSorteada = shuffledList.removeAt(shuffledList.indexOf(withoutExclusion.first)).nome;
      participante.shuffledIndex = auxList.indexOf(withoutExclusion.first) + 1;
    }
  }
}
