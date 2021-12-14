library(shiny)

ui <- fluidPage("Hello. Goodbye.")
server <- function(input, output) {
  # Brutal.
  shiny::stopApp()
}

shinyApp(ui = ui, server = server)
