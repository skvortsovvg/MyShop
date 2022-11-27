// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require questions
//= require answers
//= require comments

import Rails from '@rails/ujs';

Rails.start();

import { createConsumer } from "@rails/actioncable";
