# Pin npm packages by running ./bin/importmap

pin "application", preload: false
pin "questions"
pin "answers"
pin "comments"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.1/lib/assets/compiled/rails-ujs.js"
pin "@rails/actioncable", to: "actioncable.esm.js"