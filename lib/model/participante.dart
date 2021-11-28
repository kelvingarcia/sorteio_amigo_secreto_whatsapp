import 'package:sorteio_amigo_secreto_whatsapp/utils/dynamic_utils.dart';

class Participante {
  String mongoId;
  final String nome;
  final String numero;
  String pessoaSorteada;
  List<String> exclusoes;
  bool enviado;

  Participante(this.mongoId, this.nome, this.numero,
      this.pessoaSorteada, this.exclusoes, this.enviado);

  Participante.fromJson(Map<String, dynamic> json)
    : mongoId = json['mongoId'],
      nome = json['nome'],
      numero = json['numero'],
      pessoaSorteada = json['pessoaSorteada'],
      exclusoes = DynamicUtils.createListFromDynamic(json['exclusoes']),
      enviado = json['enviado'];

  Map<String, dynamic> toJson() => {
      'mongoId': mongoId,
      'nome': nome,
      'numero': numero,
      'pessoaSorteada': pessoaSorteada,
      'exclusoes': exclusoes,
      'enviado': enviado
    };

  @override
  String toString() {
    return '{ mongoId: $mongoId, nome: $nome, numero: $numero, pessoaSorteada: $pessoaSorteada, exclusoes: $exclusoes, enviado: $enviado }';
  }
}
