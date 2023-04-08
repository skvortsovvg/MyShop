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

export function SubscribeAnswers(question_id) {
  createConsumer().subscriptions.create( {channel: "AnswerChannel", id: question_id}, {

    connected() {
      this.perform('follow')
    },

    received(data) {
      console.log('new answer');
      console.log(data);
      var answers_section = document.getElementById("answers");
      var answers_list = document.getElementsByClassName("answer");

      //render new answer
      answers_section.insertAdjacentHTML('beforeend', data.html);
      document.getElementById("answer_body").value = "";
      document.getElementById("answer_files").value = "";
      document.getElementById("new_answer").style.display = "none";
      
      var new_answer = document.getElementById(
            `answer_${data.answer_id}`
          );

      //set collapse funtion on "Add new comment"
      var commentBtn = new_answer.querySelector(".collapse");
      commentBtn.addEventListener("click", function() {
          this.classList.toggle("active");
          var content = this.nextElementSibling;
          if (content.style.display === "block") {
            content.style.display = "none";
          } else {
            content.style.display = "block";
          }
        }); 

      new_answer.querySelector(".editBtn").addEventListener("click", () => {
          new_answer
            .querySelector(".edit_answer")
            .classList.remove("edit_answer");
          new_answer.querySelector(".answer_buttons").style.display = "none";
        });

      //check for visibility for control buttons "Edit", "Delete" and comment ability   
      if (gon.user_id && gon.user_id != 'guest') {
        new_answer.querySelector('.commentable').style.display = "inline-block";
      }
      var listBtn = new_answer.getElementsByClassName("controlBtn");
      for (var btn of listBtn) {
        if (gon.user_id == new_answer.dataset['authorId']){
          btn.style.display = "inline-block";
        }
      };
    }
  });
}

export function SubscribeComments(question_id) {
  createConsumer().subscriptions.create({channel: "CommentChannel", id: question_id}, {

    connected() {
      this.perform('follow')
      console.log('comments connected');
    },

    received(data) {
      if(data.commentable_type == "Answer"){
       
        var answer = document.getElementById(
              `answer_${data.commentable_id}`
            );
        
        console.log(data);
        var comments_list = answer.querySelector(".answer_comments");
        comments_list.insertAdjacentHTML('beforeend', data.html);

        answer.querySelector("#comment_body").value = "";
        btn = answer.querySelector(".collapse");
        btn.classList.toggle("active");
        btn.nextElementSibling.style.display = "none";

      } else if(data.commentable_type == "Question"){
        // use new_comment.js.erb
      }
    }
  });
}
