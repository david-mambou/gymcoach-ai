# Gym AI

## Introduction

This Gym AI is a Rails web app created to simplify the workout life of all those who cannot afford a human coach, leveraging the power of GPT3 AI!

Generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com)
team. Uses [OpenAI API](https://beta.openai.com/overview).

## Prerequisites

Make sure the following are installed on your machine:
- rails
- yarn

## Installation

Don't forget to execute: `bundle install` `yarn install` to install dependencies.

Then generate the database with `rails db:create db:migrate db:seed`.


[Cloudinary](https://cloudinary.com/) is set as the Active Storage service, therefore you will need to create a `.env` file at the root of the project folder and set your Cloudinary access token (URL) in it.

`CLOUDINARY_URL=your_access_url`

In the `.env` file, also add your OpenAI key so you can use the AI.

`OPENAI_ACCESS_TOKEN=access_token_goes_here`

Library documentation for Ruby OpenAI connection API (gem used in this project) is here: https://github.com/alexrudall/ruby-openai.
