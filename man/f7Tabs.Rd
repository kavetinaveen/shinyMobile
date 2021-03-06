% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7-tabs.R
\name{f7Tabs}
\alias{f7Tabs}
\title{Create a Framework7 tabs}
\usage{
f7Tabs(..., .items = NULL, id = NULL, swipeable = FALSE,
  animated = TRUE)
}
\arguments{
\item{...}{Slot for \link{f7Tab}.}

\item{.items}{Slot for other items that could be part of the toolbar such as
buttons or \link{f7Sheet}.}

\item{id}{Optional to get the id of the currently selected \link{f7Tab}.}

\item{swipeable}{Whether to allow finger swip. FALSE by default. Only for touch-screens.
Not compatible with animated.}

\item{animated}{Whether to show transition between tabs. TRUE by default.
Not compatible with swipeable.}
}
\description{
Build a Framework7 tabs
}
\note{
Animated does not work when set to FALSE and swipeable is FALSE.
}
\examples{
if (interactive()) {
 library(shiny)
 library(shinyMobile)
 shiny::shinyApp(
  ui = f7Page(
    title = "Tab Layout",
    f7TabLayout(
      navbar = f7Navbar(title = HTML(paste("Currently selected:", textOutput("selected")))),
      f7Tabs(
        id = "tabdemo",
        swipeable = TRUE,
        animated = FALSE,
        f7Tab(tabName = "Tab 1", "tab 1 text"),
        f7Tab(tabName = "Tab 2", "tab 2 text"),
        f7Tab(tabName = "Tab 3", "tab 3 text"),
        .items = shiny::tags$a(
         class = "tab-link",
         href = "#",
         f7Icon("bolt_fill"),
         shiny::span(class = "tabbar-label", "Optional Item")
        )
      )
    )
  ),
  server = function(input, output) {
    output$selected <- renderText(input$tabdemo)
  }
 )
}
}
\author{
David Granjon, \email{dgranjon@ymail.com}
}
