enum Sender { bot, user }

class ChatMessage {
  final String text;
  final Sender sender;

  ChatMessage(this.text, this.sender);
}
