import { createConsumer } from "@rails/actioncable";

export function SubscribeQuestions() {
  createConsumer().subscriptions.create("QuestionChannel", {

    connected() {
      this.perform('follow')
    },

    received(data) {
      var questions_list = document.getElementById("questions");
      questions_list.insertAdjacentHTML('beforeend', data);
    }
  });

  var listQst = document.getElementsByClassName("question");
  for (var qst of listQst) {
    var listBtn = qst.getElementsByClassName("controlBtn");
    for (var btn of listBtn) {
      if(gon.user_id == qst.dataset['authorId']){
        btn.style.display = "block";
      }
    }
  };
}
