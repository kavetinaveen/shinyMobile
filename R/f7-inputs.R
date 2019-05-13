# #' Create a Framework7 picker input
# #'
# #' Build a Framework7 picker input
# #'
# #' @param inputId Picker input id.
# #' @param label Picker label.
# #' @param placeHolder Text to write in the container.
# #' @param choices Picker choices.
# #'
# #' @examples
# #' if(interactive()){
# #'  library(shiny)
# #'  library(shinyF7)
# #'
# #'  shiny::shinyApp(
# #'    ui = f7Page(
# #'     title = "My app",
# #'     f7pickerInput(
# #'      inputId = "my-picker",
# #'      placeHolder = "Some text here!",
# #'      label = "Picker Input",
# #'      choices = c('a', 'b', 'c')
# #'     )
# #'    ),
# #'    server = function(input, output) {}
# #'  )
# #' }
# #'
# #' @author David Granjon, \email{dgranjon@@ymail.com}
# #'
# #' @export
# f7pickerInput <- function(inputId, label, placeHolder = NULL, choices) {
#
#   # input tag
#   inputTag <- shiny::tags$div(
#     class = "item-content item-input item-input-with-value",
#     shiny::tags$div(
#       class = "item-inner",
#       shiny::tags$div(
#         class = "item-input-wrap",
#         shiny::tags$input(
#           class = "input-with-value",
#           id = inputId,
#           type = "text",
#           placeholder = placeHolder,
#           readonly = "readonly"
#         )
#       )
#     )
#   )
#
#   # JS
#   choices <- jsonlite::toJSON(choices)
#   choices <- paste("values: ", choices)
#
#   pickerJS <- shiny::tags$script(
#     paste0(
#       "var pickerDevice = app.picker.create({
#           inputEl: '#", inputId,"',
#           cols: [
#             {
#               textAlign: 'center',
#               ", choices,"
#             }
#           ]
#          });
#         "
#     )
#   )
#
#   # tag wrapper
#   mainTag <- shiny::tags$div(
#     class = "block-title",
#     label,
#     shiny::tags$div(
#       class = "list no-hairlines-md",
#       shiny::tags$ul(
#         shiny::tags$li(
#           inputTag
#         )
#       )
#     )
#   )
#
#   # final input tag
#   shiny::tagList(
#     shiny::singleton(shiny::tags$head(pickerJS)),
#     mainTag
#   )
#
# }



#' Create a F7 Checkbox
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value (TRUE or FALSE).
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7Init(theme = "auto"),
#'     f7Card(
#'      f7checkBox(
#'       inputId = "check",
#'       label = "Checkbox",
#'       value = FALSE
#'      ),
#'      verbatimTextOutput("test")
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint({input$check})
#'    }
#'  )
#' }
#
#' @export
f7checkBox <- function(inputId, label, value = FALSE){
  value <- shiny::restoreInput(id = inputId, default = value)
  inputTag <- shiny::tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  shiny::tags$label(
    class = "checkbox form-group shiny-input-container",
    inputTag,
    shiny::tags$i(class = "icon icon-checkbox"),
    shiny::tags$div(
      class = "item-inner",
      shiny::tags$div(class = "item-title", label)
    )
  )
}





#' Create a f7 slider
#'
#' @param inputId Slider input id.
#' @param label Slider label.
#' @param min Slider minimum range.
#' @param max Slider maximum range.
#' @param value Slider value or a vector containing 2 values (for a range).
#' @param step Slider increase step size.
#' @param scale Slider scale.
#' @param vertical Whether to apply a vertical display. FALSE by default. Does not work yet.
#'
#' @export
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7Init(theme = "auto"),
#'     f7Card(
#'      f7Slider(
#'       inputId = "obs",
#'       label = "Number of observations",
#'       max = 1000,
#'       min = 0,
#'       value = 100,
#'       scale = TRUE
#'      ),
#'      verbatimTextOutput("test")
#'     ),
#'     plotOutput("distPlot")
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint({input$obs})
#'     output$distPlot <- renderPlot({
#'      hist(rnorm(input$obs))
#'     })
#'    }
#'  )
#' }
#'
#' # Create a range
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7Init(theme = "auto"),
#'     f7Card(
#'      f7Slider(
#'       inputId = "obs",
#'       label = "Range values",
#'       max = 500,
#'       min = 0,
#'       value = c(50, 100),
#'       scale = TRUE
#'      ),
#'      verbatimTextOutput("test")
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint({input$obs})
#'    }
#'  )
#' }
#'
f7Slider <- function(inputId, label, min, max, value,
                     step = NULL, scale = FALSE, vertical = FALSE) {

  # custom input binding
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::includeScript(path = system.file("framework7-4.3.1/input-bindings/sliderInputBinding.js", package = "shinyF7"))
      )
    ),
    # slider initialization
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(
          paste0(
            "// init the slider component
                $(function() {
                  var range = app.range.create({ el: '#", inputId,"' });
                });
              "
          )
        )
      )
    ),
    # HTML skeleton
    shiny::br(),
    shiny::tags$div(class = "block-title", label),
    shiny::tags$div(
      class = "range-slider",
      id = inputId,
      `data-dual` = if (length(value) == 2) "true" else NULL,
      `data-min`= min,
      `data-max`= max,
      `data-vertical` = tolower(vertical),
      `data-label`= "true",
      `data-step`= if (is.null(step)) 5 else step,
      `data-value`= if (length(value) == 1) value else NULL,
      `data-value-left` = if (length(value) == 2) value[1] else NULL,
      `data-value-right` = if (length(value) == 2) value[2] else NULL,
      `data-scale`= tolower(scale),
      `data-scale-steps`= if (is.null(step)) 5 else step,
      `data-scale-sub-steps` = "4"
    )
  )
}


#' Create a F7 radio stepper
#'
#' @param inputId Stepper input id.
#' @param label Stepper label.
#' @param min Stepper minimum value.
#' @param max Stepper maximum value.
#' @param value Stepper value. Must belong to \code{\[min, max\]}.
#' @param step Increment step. 1 by default.
#' @param fill Whether to fill the stepper. FALSE by default.
#' @param rounded Whether to round the stepper. FALSE by default.
#' @param raised Whether to put a relied around the stepper. FALSE by default.
#' @param size Stepper size: "small", "large" or NULL.
#' @param color Stepper color: NULL or "red", "green", "blue", "pink", "yellow", "orange", "grey" and "black".
#' @param wrap In wraps mode incrementing beyond maximum value sets value to minimum value,
#' likewise, decrementing below minimum value sets value to maximum value. TRUE by default.
#' @param autorepeat Pressing and holding one of its buttons increments or decrements the stepper’s
#' value repeatedly. With dynamic autorepeat, the rate of change depends on how long the user
#' continues pressing the control. TRUE by default.
#' @param manual It is possible to enter value manually from keyboard or mobile keypad. When click on
#' input field, stepper enter into manual input mode, which allow type value from keyboar and check
#' fractional part with defined accurancy. Click outside or enter Return key, ending manual mode.
#' TRUE by default.
#'
#' @note Note that wrap, autorepeat and manual do not work.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7Init(theme = "auto"),
#'     f7Stepper(
#'      inputId = "stepper",
#'      label = "My stepper",
#'      min = 0,
#'      max = 10,
#'      value = 4
#'     ),
#'     verbatimTextOutput("test"),
#'     f7Stepper(
#'      inputId = "stepper2",
#'      label = "My stepper 2",
#'      min = 0,
#'      max = 10,
#'      value = 4,
#'      color = "orange",
#'      raised = TRUE,
#'      fill = TRUE,
#'      rounded = TRUE
#'     ),
#'     verbatimTextOutput("test2")
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint(input$stepper)
#'     output$test2 <- renderPrint(input$stepper2)
#'    }
#'  )
#' }
#
#' @export
f7Stepper <- function(inputId, label, min, max, value, step = 1,
                      fill = FALSE, rounded = FALSE, raised = FALSE, size = NULL,
                      color = NULL, wrap = FALSE, autorepeat = TRUE, manual = TRUE) {

  stepperCl <- "stepper"
  if (fill) stepperCl <- paste0(stepperCl, " stepper-fill")
  if (rounded) stepperCl <- paste0(stepperCl, " stepper-round")
  if (!is.null(size)) {
    if (size == "small") {
      stepperCl <- paste0(stepperCl, " stepper-small")
    } else if (size == "large") {
      stepperCl <- paste0(stepperCl, " stepper-large")
    }
  }
  if (raised) stepperCl <- paste0(stepperCl, " stepper-raised")
  if (!is.null(color)) stepperCl <- paste0(stepperCl, " color-", color)

  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::includeScript(path = system.file("framework7-4.3.1/input-bindings/stepperInputBinding.js", package = "shinyF7"))
      )
    ),
    # javascript initialization
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(
          paste0(
            "$(function(){
              var stepper = app.stepper.create({
                el: '#", inputId,"'
              });
             });
            "
          )
        )
      )
    ),

    # stepper tag
    shiny::tags$small(label),
    shiny::tags$div(
      class = stepperCl,
      id = inputId,
      `data-wraps` = tolower(wrap),
      `data-autorepeat` = tolower(autorepeat),
      `data-autorepeat-dynamic` = tolower(autorepeat),
      `data-decimal-point`= "2",
      `data-manual-input-mode` = tolower(manual),
      shiny::tags$div(class = "stepper-button-minus"),
      shiny::tags$div(
        class = "stepper-input-wrap",
        shiny::tags$input(
          type = "text",
          value = value,
          min = min,
          max = max,
          step = step
        )
      ),
      shiny::tags$div(class = "stepper-button-plus")
    )
  )
}