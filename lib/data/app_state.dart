import 'package:flutter/foundation.dart';

import '../models/educando.dart';
import '../models/evento.dart';
import '../models/perfil.dart';
import '../models/status_educando.dart';
import 'mock_data.dart';

/// Estado central do app. Mantém, em memória, o estado mockado compartilhado entre as
/// telas: o perfil autenticado na sessão e a lista de educandos (que cresce quando um novo
/// educando é cadastrado pela tela de Educador). Não há persistência real - ao fechar o
/// app, os dados voltam ao estado inicial definido em [MockData].
class AppState extends ChangeNotifier {
  Perfil? _perfilLogado;
  Perfil? get perfilLogado => _perfilLogado;

  final List<Educando> educandos = MockData.educandosBase();
  final List<Evento> eventos = MockData.eventos();

  /// Educando "logado" na sessão de demonstração do perfil Educando (Ana Carolina Silva).
  Educando get educandoLogado => educandos.firstWhere((e) => e.id == 'edu-001');

  void inscreverEmEvento(String eventoId) {
    final evento = eventos.firstWhere((e) => e.id == eventoId);
    if (evento.inscrito || evento.vagasOcupadas >= evento.vagasTotal) return;
    evento.vagasOcupadas += 1;
    evento.inscrito = true;
    notifyListeners();
  }

  String? _mensagemFeedback;
  String? get mensagemFeedback => _mensagemFeedback;

  void login(Perfil perfil) {
    _perfilLogado = perfil;
    notifyListeners();
  }

  void logout() {
    _perfilLogado = null;
    notifyListeners();
  }

  Educando? educandoPorId(String id) {
    for (final e in educandos) {
      if (e.id == id) return e;
    }
    return null;
  }

  void atualizarStatus(String id, StatusEducando novoStatus) {
    educandoPorId(id)?.status = novoStatus;
    notifyListeners();
  }

  void atualizarFrequencia(String id, int novaFrequencia) {
    educandoPorId(id)?.frequencia = novaFrequencia;
    notifyListeners();
  }

  void cadastrarEducando({
    required String nomeCompleto,
    required String cpf,
    required String telefone,
    required String email,
    required String curso,
  }) {
    final proximoId = 'edu-${(educandos.length + 1).toString().padLeft(3, '0')}';
    final novo = Educando(
      id: proximoId,
      nome: nomeCompleto,
      email: email,
      telefone: telefone.isEmpty ? '—' : telefone,
      cpf: cpf.isEmpty ? '—' : cpf,
      nascimento: '—',
      idade: 0,
      curso: curso,
      progresso: 0,
      media: 0.0,
      iniciadoEm: '27 de abril de 2026',
      endereco: const Endereco(rua: '—', bairro: '—', cep: '—', cidade: '—', uf: '—'),
      linkedin: '—',
      curriculoArquivo: '—',
      historico: const [
        HistoricoEvento(titulo: 'Inscrição realizada', data: '27 de abril de 2026'),
      ],
      statusInicial: StatusEducando.inscrito,
      frequenciaInicial: 0,
    );
    educandos.add(novo);
    _mensagemFeedback = 'Educando cadastrado com sucesso! ${nomeCompleto.toUpperCase()} foi adicionado(a) à base.';
    notifyListeners();
  }

  void limparFeedback() {
    _mensagemFeedback = null;
  }
}
