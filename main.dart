import 'dart:io';
import 'dart:math';

void main() {
  final List<String> wordBank = ['hangman', 'flutter', 'dart', 'programming', 'project'];
  bool playAgain = true;

  while (playAgain) {
    String selectedWord = selectRandomWord(wordBank);
    List<String> guessedLetters = [];
    int attemptsLeft = 6;
    bool wordGuessed = false;

    while (!wordGuessed && attemptsLeft > 0) {
      printHangman(attemptsLeft);
      printWordProgress(selectedWord, guessedLetters);

      print('Enter a letter: ');
      String guess = stdin.readLineSync()!;


      if (guessedLetters.contains(guess)) {
        print('You already guessed that letter.');
        continue;
      }

      guessedLetters.add(guess);

      if (selectedWord.contains(guess)) {
        print('Correct guess!');
        if (checkWordGuessed(selectedWord, guessedLetters)) {
          wordGuessed = true;
        }
      } else {
        print('Incorrect guess!');
        attemptsLeft--;
      }
    }

    printHangman(attemptsLeft);

    if (wordGuessed) {
      print('Congratulations! You guessed the word: $selectedWord');
    } else {
      print('Game over! The word was: $selectedWord');
    }

    print('Do you want to play again? (yes/no): ');
    String playAgainInput = stdin.readLineSync()!;
    playAgain = playAgainInput == 'yes';
  }
}

String selectRandomWord(List<String> wordBank) {
  Random random = Random();
  int randomIndex = random.nextInt(wordBank.length);
  return wordBank[randomIndex];
}

void printHangman(int attemptsLeft) {
  const List<String> hangmanStages = [
    '''
    +---+
        |
        |
        |
       ===
    ''',
    '''
    +---+
    O   |
        |
        |
       ===
    ''',
    '''
    +---+
    O   |
    |   |
        |
       ===
    ''',
    '''
    +---+
    O   |
   /|   |
        |
       ===
    ''',
    '''
    +---+
    O   |
   /|\\  |
        |
       ===
    ''',
    '''
    +---+
    O   |
   /|\\  |
   /    |
       ===
    ''',
    '''
    +---+
    O   |
   /|\\  |
   / \\  |
       ===
    '''
  ];

  print(hangmanStages[6 - attemptsLeft]);
}

void printWordProgress(String word, List<String> guessedLetters) {
  String progress = '';
  for (int i = 0; i < word.length; i++) {
    String letter = word[i];
    if (guessedLetters.contains(letter)) {
      progress += letter;
    } else {
      progress += '_';
    }
    progress += ' ';
  }
  print(progress);
}

bool checkWordGuessed(String word, List<String> guessedLetters) {
  for (int i = 0; i < word.length; i++) {
    String letter = word[i];
    if (!guessedLetters.contains(letter)) {
      return false;
    }
  }
  return true;
}