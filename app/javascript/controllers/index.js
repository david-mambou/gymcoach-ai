// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

import Chart from "stimulus-chartjs"

const application = Application.start()
application.register("chart", Chart)

const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))
