// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import "../stylesheets/top.scss";
import "../stylesheets/map.scss";
import "../stylesheets/chat_bar.scss";
import "../stylesheets/countdown.scss";
import "../stylesheets/notice.scss";
import "../stylesheets/layouts.scss";

import "./scrollComment";

Rails.start()
Turbolinks.start()
ActiveStorage.start()
