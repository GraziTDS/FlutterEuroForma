import '../models/administrador.dart';
import '../models/educador.dart';
import '../models/educando.dart';
import '../models/evento.dart';
import '../models/papel_usuario.dart';
import '../models/status_educando.dart';
import '../models/tipo_evento.dart';

/// Fonte única de dados mockados do Projeto Educandos - Instituto Eurofarma.
///
/// Nesta Sprint não há integração com API, Firebase ou banco de dados: todos os dados
/// abaixo simulam o comportamento real da plataforma euroForma para fins de demonstração
/// do MVP. `status`/`frequencia` do [Educando] e `vagasOcupadas`/`inscrito` do [Evento] são
/// mutáveis para permitir que as telas de gestão reajam a alterações feitas pelo usuário.
class MockData {
  MockData._();

  /// Cursos oferecidos pelo Instituto Eurofarma dentro do Projeto Educandos.
  static const cursosOferecidos = [
    'Auxiliar de Farmácia',
    'Logística Farmacêutica',
    'Atendimento ao Cliente',
    'Empreendedorismo Social',
  ];

  static List<Educando> educandosBase() => [
        Educando(
          id: 'edu-001',
          nome: 'Ana Carolina Silva',
          email: 'ana.silva@email.com',
          telefone: '(11) 98765-4321',
          cpf: '123.456.789-00',
          nascimento: '11/04/2002',
          idade: 24,
          curso: 'Auxiliar de Farmácia',
          progresso: 64,
          media: 8.6,
          iniciadoEm: '09 de fevereiro de 2026',
          endereco: const Endereco(
              rua: 'Rua das Flores, 120', bairro: 'Vila Maria', cep: '02114-000', cidade: 'São Paulo', uf: 'SP'),
          linkedin: 'linkedin.com/in/ana-carolina-silva',
          curriculoArquivo: 'curriculo_ana_silva.pdf',
          testeIngles: const TesteIngles(nivel: 'B1', pontuacao: 72, data: '09/11/2025'),
          cursosAnteriores: const [
            CursoAnterior(nome: 'Informática Básica', ano: 2024, situacao: 'Concluído'),
            CursoAnterior(nome: 'Atendimento ao Cliente', ano: 2025, situacao: 'Concluído'),
          ],
          historico: const [
            HistoricoEvento(titulo: 'Inscrição realizada', data: '09 de fevereiro de 2026'),
            HistoricoEvento(titulo: 'Início do curso', data: '14 de fevereiro de 2026'),
            HistoricoEvento(titulo: 'Módulo 2 concluído', data: '19 de março de 2026'),
          ],
          boletim: const [
            Disciplina(
                nome: 'Farmacologia básica',
                presencas: '77/80 presenças',
                cp1: 8.0,
                gs1: 9.0,
                md1: 8.5,
                cp2: 7.5,
                faltas: 3,
                frequenciaPercentual: 96.3,
                mediaParcial: 8.2),
            Disciplina(
                nome: 'Boas práticas de manipulação',
                presencas: '58/60 presenças',
                cp1: 9.0,
                gs1: 9.0,
                md1: 9.0,
                cp2: 8.5,
                faltas: 2,
                frequenciaPercentual: 96.7,
                mediaParcial: 8.8),
            Disciplina(
                nome: 'Atendimento ao cliente',
                presencas: '36/40 presenças',
                cp1: 8.0,
                gs1: 8.0,
                md1: 8.0,
                faltas: 4,
                frequenciaPercentual: 90.0,
                mediaParcial: 8.0),
            Disciplina(
                nome: 'Informática aplicada',
                presencas: '50/60 presenças',
                cp1: 7.0,
                gs1: 7.5,
                md1: 7.3,
                cp2: 6.0,
                faltas: 10,
                frequenciaPercentual: 83.3,
                mediaParcial: 6.8),
          ],
          statusInicial: StatusEducando.emCurso,
          frequenciaInicial: 92,
        ),
        Educando(
          id: 'edu-002',
          nome: 'Bruno Henrique Costa',
          email: 'bruno.costa@email.com',
          telefone: '(11) 97654-3210',
          cpf: '234.567.890-11',
          nascimento: '02/08/2001',
          idade: 25,
          curso: 'Logística Farmacêutica',
          progresso: 100,
          media: 9.1,
          iniciadoEm: '03 de agosto de 2025',
          endereco: const Endereco(
              rua: 'Av. Guilherme Cotching, 780',
              bairro: 'Vila Nova Cachoeirinha',
              cep: '02710-001',
              cidade: 'São Paulo',
              uf: 'SP'),
          linkedin: 'linkedin.com/in/bruno-henrique-costa',
          curriculoArquivo: 'curriculo_bruno_costa.pdf',
          testeIngles: const TesteIngles(nivel: 'A2', pontuacao: 58, data: '12/07/2025'),
          cursosAnteriores: const [
            CursoAnterior(nome: 'Informática Básica', ano: 2024, situacao: 'Concluído'),
          ],
          historico: const [
            HistoricoEvento(titulo: 'Inscrição realizada', data: '20 de julho de 2025'),
            HistoricoEvento(titulo: 'Início do curso', data: '03 de agosto de 2025'),
            HistoricoEvento(titulo: 'Curso concluído', data: '12 de dezembro de 2025'),
          ],
          boletim: const [
            Disciplina(
                nome: 'Gestão de estoque',
                presencas: '78/80 presenças',
                cp1: 9.0,
                gs1: 9.5,
                md1: 9.2,
                cp2: 9.0,
                gs2: 9.0,
                md2: 9.0,
                faltas: 2,
                frequenciaPercentual: 97.5,
                mediaParcial: 9.1),
            Disciplina(
                nome: 'Cadeia de frio e transporte',
                presencas: '76/80 presenças',
                cp1: 8.5,
                gs1: 9.0,
                md1: 8.7,
                cp2: 9.0,
                gs2: 9.5,
                md2: 9.2,
                faltas: 4,
                frequenciaPercentual: 95.0,
                mediaParcial: 9.0),
          ],
          statusInicial: StatusEducando.concluido,
          frequenciaInicial: 98,
        ),
        Educando(
          id: 'edu-003',
          nome: 'Carla Mendes Oliveira',
          email: 'carla.mendes@email.com',
          telefone: '(11) 96543-2109',
          cpf: '345.678.901-22',
          nascimento: '27/01/2004',
          idade: 22,
          curso: 'Atendimento ao Cliente',
          progresso: 0,
          media: 0.0,
          iniciadoEm: '27 de abril de 2026',
          endereco: const Endereco(
              rua: 'Rua Voluntários da Pátria, 2340',
              bairro: 'Santana',
              cep: '02010-100',
              cidade: 'São Paulo',
              uf: 'SP'),
          linkedin: 'linkedin.com/in/carla-mendes-oliveira',
          curriculoArquivo: 'curriculo_carla_mendes.pdf',
          historico: const [
            HistoricoEvento(titulo: 'Inscrição realizada', data: '27 de abril de 2026'),
          ],
          statusInicial: StatusEducando.inscrito,
          frequenciaInicial: 0,
        ),
        Educando(
          id: 'edu-004',
          nome: 'Diego Almeida Santos',
          email: 'diego.santos@email.com',
          telefone: '(11) 95432-1098',
          cpf: '456.789.012-33',
          nascimento: '15/06/2003',
          idade: 23,
          curso: 'Auxiliar de Farmácia',
          progresso: 48,
          media: 7.4,
          iniciadoEm: '09 de fevereiro de 2026',
          endereco: const Endereco(
              rua: 'Rua Itapicuru, 45', bairro: 'Perdizes', cep: '01243-000', cidade: 'São Paulo', uf: 'SP'),
          linkedin: 'linkedin.com/in/diego-almeida-santos',
          curriculoArquivo: 'curriculo_diego_santos.pdf',
          testeIngles: const TesteIngles(nivel: 'A2', pontuacao: 61, data: '02/12/2025'),
          historico: const [
            HistoricoEvento(titulo: 'Inscrição realizada', data: '05 de fevereiro de 2026'),
            HistoricoEvento(titulo: 'Início do curso', data: '14 de fevereiro de 2026'),
          ],
          boletim: const [
            Disciplina(
                nome: 'Farmacologia básica',
                presencas: '62/80 presenças',
                cp1: 7.0,
                gs1: 7.5,
                md1: 7.3,
                cp2: 7.0,
                faltas: 18,
                frequenciaPercentual: 77.5,
                mediaParcial: 7.2),
            Disciplina(
                nome: 'Boas práticas de manipulação',
                presencas: '47/60 presenças',
                cp1: 7.5,
                gs1: 8.0,
                md1: 7.8,
                faltas: 13,
                frequenciaPercentual: 78.3,
                mediaParcial: 7.8),
          ],
          statusInicial: StatusEducando.emCurso,
          frequenciaInicial: 78,
        ),
        Educando(
          id: 'edu-005',
          nome: 'Eduarda Ribeiro Lima',
          email: 'eduarda.lima@email.com',
          telefone: '(11) 94321-0987',
          cpf: '567.890.123-44',
          nascimento: '09/09/2000',
          idade: 25,
          curso: 'Empreendedorismo Social',
          progresso: 71,
          media: 8.9,
          iniciadoEm: '09 de fevereiro de 2026',
          endereco: const Endereco(
              rua: 'Rua Cardeal Arcoverde, 1500',
              bairro: 'Pinheiros',
              cep: '05407-003',
              cidade: 'São Paulo',
              uf: 'SP'),
          linkedin: 'linkedin.com/in/eduarda-ribeiro-lima',
          curriculoArquivo: 'curriculo_eduarda_lima.pdf',
          testeIngles: const TesteIngles(nivel: 'B2', pontuacao: 84, data: '18/11/2025'),
          cursosAnteriores: const [
            CursoAnterior(nome: 'Atendimento ao Cliente', ano: 2024, situacao: 'Concluído'),
          ],
          historico: const [
            HistoricoEvento(titulo: 'Inscrição realizada', data: '03 de fevereiro de 2026'),
            HistoricoEvento(titulo: 'Início do curso', data: '14 de fevereiro de 2026'),
            HistoricoEvento(titulo: 'Módulo 2 concluído', data: '22 de março de 2026'),
          ],
          boletim: const [
            Disciplina(
                nome: 'Fundamentos de empreendedorismo',
                presencas: '58/60 presenças',
                cp1: 9.0,
                gs1: 9.0,
                md1: 9.0,
                cp2: 8.5,
                faltas: 2,
                frequenciaPercentual: 96.7,
                mediaParcial: 8.8),
            Disciplina(
                nome: 'Gestão financeira pessoal',
                presencas: '56/60 presenças',
                cp1: 8.5,
                gs1: 9.0,
                md1: 8.7,
                faltas: 4,
                frequenciaPercentual: 93.3,
                mediaParcial: 8.7),
          ],
          statusInicial: StatusEducando.emCurso,
          frequenciaInicial: 85,
        ),
        Educando(
          id: 'edu-006',
          nome: 'Felipe Nogueira Souza',
          email: 'felipe.souza@email.com',
          telefone: '(11) 93210-9876',
          cpf: '678.901.234-55',
          nascimento: '30/03/1999',
          idade: 27,
          curso: 'Logística Farmacêutica',
          progresso: 100,
          media: 9.4,
          iniciadoEm: '04 de agosto de 2025',
          endereco: const Endereco(
              rua: 'Rua Turiassu, 500', bairro: 'Perdizes', cep: '05005-000', cidade: 'São Paulo', uf: 'SP'),
          linkedin: 'linkedin.com/in/felipe-nogueira-souza',
          curriculoArquivo: 'curriculo_felipe_souza.pdf',
          testeIngles: const TesteIngles(nivel: 'B1', pontuacao: 75, data: '20/07/2025'),
          cursosAnteriores: const [
            CursoAnterior(nome: 'Informática Básica', ano: 2023, situacao: 'Concluído'),
            CursoAnterior(nome: 'Atendimento ao Cliente', ano: 2024, situacao: 'Concluído'),
          ],
          historico: const [
            HistoricoEvento(titulo: 'Inscrição realizada', data: '22 de julho de 2025'),
            HistoricoEvento(titulo: 'Início do curso', data: '04 de agosto de 2025'),
            HistoricoEvento(titulo: 'Curso concluído', data: '15 de dezembro de 2025'),
          ],
          boletim: const [
            Disciplina(
                nome: 'Gestão de estoque',
                presencas: '79/80 presenças',
                cp1: 9.5,
                gs1: 9.5,
                md1: 9.5,
                cp2: 9.0,
                gs2: 9.5,
                md2: 9.2,
                faltas: 1,
                frequenciaPercentual: 98.8,
                mediaParcial: 9.4),
            Disciplina(
                nome: 'Boas práticas de armazenagem',
                presencas: '78/80 presenças',
                cp1: 9.0,
                gs1: 9.5,
                md1: 9.2,
                cp2: 9.5,
                gs2: 9.5,
                md2: 9.5,
                faltas: 2,
                frequenciaPercentual: 97.5,
                mediaParcial: 9.3),
          ],
          statusInicial: StatusEducando.concluido,
          frequenciaInicial: 95,
        ),
        Educando(
          id: 'edu-007',
          nome: 'Gabriela Pinheiro Rocha',
          email: 'gabriela.rocha@email.com',
          telefone: '(11) 92109-8765',
          cpf: '789.012.345-66',
          nascimento: '14/12/2002',
          idade: 23,
          curso: 'Atendimento ao Cliente',
          progresso: 22,
          media: 6.5,
          iniciadoEm: '09 de fevereiro de 2026',
          endereco: const Endereco(
              rua: 'Rua Domingos de Morais, 890',
              bairro: 'Vila Mariana',
              cep: '04010-100',
              cidade: 'São Paulo',
              uf: 'SP'),
          linkedin: 'linkedin.com/in/gabriela-pinheiro-rocha',
          curriculoArquivo: 'curriculo_gabriela_rocha.pdf',
          historico: const [
            HistoricoEvento(titulo: 'Inscrição realizada', data: '05 de fevereiro de 2026'),
            HistoricoEvento(titulo: 'Início do curso', data: '14 de fevereiro de 2026'),
            HistoricoEvento(titulo: 'Desistência registrada', data: '10 de abril de 2026'),
          ],
          boletim: const [
            Disciplina(
                nome: 'Comunicação e atendimento',
                presencas: '26/40 presenças',
                cp1: 6.5,
                gs1: 7.0,
                md1: 6.8,
                faltas: 14,
                frequenciaPercentual: 65.0,
                mediaParcial: 6.8),
          ],
          statusInicial: StatusEducando.desistente,
          frequenciaInicial: 32,
        ),
      ];

  /// Motivo de desistência (usado no relatório "Motivos de desistência" do Administrador).
  static const motivoDesistencia =
      'Conflito de horário com novo emprego em meio período. Aluna solicitou retorno futuro no próximo semestre.';

  static List<Educador> educadores() => [
        Educador(
            id: 'prof-001',
            nome: 'Profa. Mariana Alves',
            email: 'mariana.alves@institutoeurofarma.org.br',
            papel: PapelUsuario.coordenador,
            turmas: 4,
            ultimoAcesso: '29/04/2026',
            ativoInicial: true),
        Educador(
            id: 'prof-002',
            nome: 'Prof. Rafael Tavares',
            email: 'rafael.tavares@institutoeurofarma.org.br',
            papel: PapelUsuario.educador,
            turmas: 3,
            ultimoAcesso: '28/04/2026',
            ativoInicial: true),
        Educador(
            id: 'prof-003',
            nome: 'Profa. Juliana Pires',
            email: 'juliana.pires@institutoeurofarma.org.br',
            papel: PapelUsuario.educador,
            turmas: 2,
            ultimoAcesso: '27/04/2026',
            ativoInicial: true),
        Educador(
            id: 'prof-004',
            nome: 'Prof. Sérgio Lopes',
            email: 'sergio.lopes@institutoeurofarma.org.br',
            papel: PapelUsuario.educador,
            turmas: 2,
            ultimoAcesso: '14/03/2026',
            ativoInicial: false),
        Educador(
            id: 'prof-005',
            nome: 'Profa. Beatriz Cardoso',
            email: 'beatriz.cardoso@institutoeurofarma.org.br',
            papel: PapelUsuario.educador,
            turmas: 3,
            ultimoAcesso: '29/04/2026',
            ativoInicial: true),
      ];

  static const administrador = Administrador(nome: 'Ricardo Mendonça', email: 'ricardo.mendonca@institutoeurofarma.org.br');

  static Educador educadorLogado() => Educador(
        id: 'prof-000',
        nome: 'Profa. Mariana Alves',
        email: 'mariana.alves@institutoeurofarma.org.br',
        papel: PapelUsuario.coordenador,
        turmas: 4,
        ultimoAcesso: 'hoje',
        ativoInicial: true,
      );

  static List<Evento> eventos() => [
        Evento(
          id: 'evt-01',
          tipo: TipoEvento.workshop,
          titulo: 'Workshop: Carreiras na Indústria Farmacêutica',
          descricao: 'Conheça as áreas e trilhas de crescimento profissional.',
          local: 'Auditório Eurofarma — Itapevi',
          data: '13 de maio de 2026',
          vagasTotal: 80,
          vagasOcupadasInicial: 52,
        ),
        Evento(
          id: 'evt-02',
          tipo: TipoEvento.palestra,
          titulo: 'Palestra: Inclusão Digital e Empregabilidade',
          descricao: 'Como a tecnologia pode acelerar sua trajetória profissional.',
          local: 'Online (Zoom)',
          data: '19 de maio de 2026',
          vagasTotal: 200,
          vagasOcupadasInicial: 134,
        ),
        Evento(
          id: 'evt-03',
          tipo: TipoEvento.mentoria,
          titulo: 'Mentoria de Carreira em Grupo',
          descricao: 'Encontro com mentores voluntários da Eurofarma.',
          local: 'Centro Instituto Eurofarma — Osasco',
          data: '24 de maio de 2026',
          vagasTotal: 30,
          vagasOcupadasInicial: 18,
        ),
        Evento(
          id: 'evt-04',
          tipo: TipoEvento.networking,
          titulo: 'Networking Educandos & Egressos',
          descricao: 'Troque experiências com quem já se formou no programa.',
          local: 'Hub de Inovação Eurofarma',
          data: '01 de junho de 2026',
          vagasTotal: 60,
          vagasOcupadasInicial: 22,
        ),
      ];

  static const proximasAulas = [
    AulaProxima(disciplina: 'Boas práticas de manipulação', diaMes: '4', mesAbreviado: 'MAI.', dataCompleta: '04 de maio de 2026'),
    AulaProxima(disciplina: 'Atendimento ao cliente', diaMes: '7', mesAbreviado: 'MAI.', dataCompleta: '07 de maio de 2026'),
  ];

  static const tiposRelatorio = [
    TipoRelatorio(titulo: 'Matrículas por curso', descricao: 'Distribuição atual da base por curso ofertado.'),
    TipoRelatorio(titulo: 'Frequência por educando', descricao: 'Ranking de presença individual e desvio da meta.'),
    TipoRelatorio(titulo: 'Conclusão & evasão', descricao: 'Comparativo de concluídos vs. desistentes por período.'),
    TipoRelatorio(titulo: 'Motivos de desistência', descricao: 'Observações e categorias mais frequentes de evasão.'),
  ];

  static const semestreVigente = '2026.1';
}
