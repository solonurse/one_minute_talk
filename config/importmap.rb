# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "modal", to: "modal.js"
pin "slide", to: "slide.js"
pin "add_form", to: "add_form.js"
pin "check_box", to: "check_box.js"
pin "word_count", to: "word_count.js"
pin "stop_watch", to: "stop_watch.js"
pin "loading", to: "loading.js"
pin "reminder_type_toggle", to: "reminder_type_toggle.js"