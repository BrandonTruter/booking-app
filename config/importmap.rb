# Pin npm packages by running ./bin/importmap

pin "application"
pin "node_modules/axios", to: "axious.min.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "axios-on-rails", to: "https://ga.jspm.io/npm:axios-on-rails@0.0.1/index.js"
