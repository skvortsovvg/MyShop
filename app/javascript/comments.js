// import { createConsumer } from "@rails/actioncable";

export function SubscribeComments(question_id) {

  createConsumer().subscriptions.create({channel: "CommentChannel", id: question_id}, {

    connected() {
      this.perform('follow')
    },

    received(data) {
      if(data.commentable_type == "Answer"){
       
        var answer = document.getElementById(
              `answer_${data.commentable_id}`
            );
        
        var comments_list = answer.querySelector(".answer_comments");
        comments_list.insertAdjacentHTML('beforeend', data.html);

        answer.querySelector("#comment_body").value = "";
        btn = answer.querySelector(".collapse");
        btn.classList.toggle("active");
        btn.nextElementSibling.style.display = "none";
      }
    }
  });
}