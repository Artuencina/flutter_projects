class Question {
  final String text;
  final List<String> answers;

  const Question(this.text, this.answers);

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);

    shuffledList.shuffle();

    return shuffledList;
  }
}
