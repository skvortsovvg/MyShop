
createConsumer().subscriptions.create("CommentChannel", {

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
