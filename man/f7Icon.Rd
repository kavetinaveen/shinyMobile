% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7Icon.R
\name{f7Icon}
\alias{f7Icon}
\title{Create a Framework7 icon}
\usage{
f7Icon(..., lib = NULL, fill = FALSE)
}
\arguments{
\item{...}{Icon name and \link{f7Badge}.}

\item{lib}{Library to use: NULL, "ios" or "md".}

\item{fill}{Whether to fill or not. FALSE by default.}
}
\description{
Build a Framework7 icon
}
\examples{
if(interactive()){
 library(shiny)
 library(shinyMobile)

 shiny::shinyApp(
  ui = f7Page(
    title = "Icons",
    f7ListCard(
     f7ListCardItem(
       title = tagList(
        f7Icon("email_fill", lib = "ios"),
        "This does not appear for material design devices."
       )
     ),
     f7ListCardItem(
       title = f7Icon("home", f7Badge("1", color = "red"))
     ),
     f7ListCardItem(
       title = f7Icon("email", lib = "md")
     )
    )
  ),
  server = function(input, output) {}
 )
}

}
\author{
David Granjon, \email{dgranjon@ymail.com}
}
