import 'package:flutter/material.dart';

class JogoDaVelha extends StatefulWidget {
  const JogoDaVelha({super.key});

  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _winner = '';
    });
  }

  void _handleTap(int index) {
    if (_board[index] == '' && _winner == '') {
      setState(() {
        _board[index] = _currentPlayer;
        _winner = _checkWinner();
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      });
    }
  }

  String _checkWinner() {
    const winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var pattern in winPatterns) {
      final a = pattern[0];
      final b = pattern[1];
      final c = pattern[2];
      if (_board[a] != '' && _board[a] == _board[b] && _board[a] == _board[c]) {
        return _board[a];
      }
    }
    if (!_board.contains('')) {
      return 'Empate';
    }
    return '';
  }

  Widget _buildButton(String value, {int? index}) {
    return TextButton(
      child: Text(
        value,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      onPressed: index != null ? () => _handleTap(index) : _resetGame,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            'Jogador Atual: $_currentPlayer',
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          child: Text(
            _winner.isEmpty
                ? 'Clique para Jogar'
                : _winner == 'Empate'
                    ? 'Empate!'
                    : 'Jogador $_winner Venceu!',
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          flex: 3,
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1,
            children: List.generate(9, (index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.blue,
                ),
                child: Center(
                  child: _buildButton(_board[index], index: index),
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: _buildButton('Reiniciar'),
        ),
      ],
    );
  }
}
