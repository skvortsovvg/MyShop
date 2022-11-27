
createConsumer().subscriptions.create("AnswerChannel", {

  connected() {
    this.perform('follow')
  },

  received(data) {
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
      console.log('я здесь');
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
