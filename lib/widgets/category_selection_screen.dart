import 'package:atividadedouglas/widgets/xp_indicator.dart';
import 'package:flutter/material.dart';
import 'package:atividadedouglas/models/user.dart';
import 'package:atividadedouglas/pages/quiz_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  final User user;
  final List<String> categories = ['Geografia', 'Ciência', 'Esportes'];

  CategorySelectionScreen({required this.user});

  Future<void> goToQuizScreen(BuildContext context, String category, List<Map<String, dynamic>> questions) async {
    late List<Map<String, dynamic>> selectedQuestions;

    if (category == 'Geografia') {
      selectedQuestions = geographyQuestions;
    } else if (category == 'Ciência') {
      selectedQuestions = scienceQuestions;
    } else if (category == 'Esportes') {
      selectedQuestions = sportsQuestions;
    }

    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(user, category, selectedQuestions),
      ),
    );

    if (updatedUser != null && updatedUser['xp'] != null) {
      user.xp = updatedUser['xp'];
      user.calculateLevel();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CategorySelectionScreen(user: user),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App - Escolha a Categoria'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Selecione uma categoria:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: categories.map<Widget>((category) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          await goToQuizScreen(context, category, []);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(category),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: XpIndicator(user),
    );
  }

  List<Map<String, dynamic>> geographyQuestions = [
    {
      'category': 'Geografia',
      'question': 'Qual é a capital do Brasil?',
      'options': ['Rio de Janeiro', 'São Paulo', 'Brasília', 'Salvador'],
      'correctOption': 'Brasília',
    },
    {
      'category': 'Geografia',
      'question': 'Qual é o maior país do mundo em área territorial?',
      'options': ['China', 'Estados Unidos', 'Canadá', 'Rússia'],
      'correctOption': 'Rússia',
    },
    {
      'category': 'Geografia',
      'question': 'Em que continente está localizado o Deserto do Saara?',
      'options': ['África', 'Ásia', 'Europa', 'América do Sul'],
      'correctOption': 'África',
    },
    {
      'category': 'Geografia',
      'question': 'Qual é o rio mais extenso do mundo?',
      'options': ['Rio Nilo', 'Rio Amazonas', 'Rio Yangtzé', 'Rio Amarelo'],
      'correctOption': 'Rio Amazonas',
    },
    {
      'category': 'Geografia',
      'question': 'Qual é o menor país do mundo?',
      'options': ['Vaticano', 'Mônaco', 'Malta', 'San Marino'],
      'correctOption': 'Vaticano',
    },
  ];


  List<Map<String, dynamic>> scienceQuestions = [
    {
      'category': 'Ciência',
      'question': 'Quantos planetas existem no sistema solar?',
      'options': ['7', '8', '9', '10'],
      'correctOption': '8',
    },
    {
      'category': 'Ciência',
      'question': 'Qual é o elemento químico mais abundante na crosta terrestre?',
      'options': ['Oxigênio', 'Silício', 'Alumínio', 'Ferro'],
      'correctOption': 'Oxigênio',
    },
    {
      'category': 'Ciência',
      'question': 'Qual é a unidade básica da estrutura dos ácidos nucleicos?',
      'options': ['Nucleotídeo', 'Aminoácido', 'Átomo', 'Vírus'],
      'correctOption': 'Nucleotídeo',
    },
    {
      'category': 'Ciência',
      'question': 'Qual é a velocidade da luz no vácuo?',
      'options': ['299.792.458 m/s', '300.000.000 m/s', '200.000.000 m/s', '250.000.000 m/s'],
      'correctOption': '299.792.458 m/s',
    },
    {
      'category': 'Ciência',
      'question': 'Qual é a fórmula química da água?',
      'options': ['H2O', 'CO2', 'NaCl', 'CH4'],
      'correctOption': 'H2O',
    },
  ];


  List<Map<String, dynamic>> sportsQuestions = [
    {
      'category': 'Esportes',
      'question': 'Qual esporte é conhecido como "O esporte dos reis"?',
      'options': ['Futebol', 'Polo', 'Tênis', 'Golfe'],
      'correctOption': 'Polo',
    },
    {
      'category': 'Esportes',
      'question': 'Qual seleção venceu a Copa do Mundo de Futebol de 2018?',
      'options': ['Brasil', 'França', 'Alemanha', 'Argentina'],
      'correctOption': 'França',
    },
    {
      'category': 'Esportes',
      'question': 'Em que país nasceu o esporte conhecido como Muay Thai?',
      'options': ['Japão', 'Tailândia', 'China', 'Índia'],
      'correctOption': 'Tailândia',
    },
    {
      'category': 'Esportes',
      'question': 'Qual esporte é praticado na competição conhecida como Super Bowl?',
      'options': ['Basquete', 'Futebol Americano', 'Beisebol', 'Hóquei no Gelo'],
      'correctOption': 'Futebol Americano',
    },
    {
      'category': 'Esportes',
      'question': 'Qual é o esporte mais popular no Brasil?',
      'options': ['Futebol', 'Vôlei', 'Basquete', 'Tênis'],
      'correctOption': 'Futebol',
    },
  ];

}
