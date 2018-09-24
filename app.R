#
# This is a simple Shiny web application for a YouTube tutorial on installing Shiny Server
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application 
ui <- fluidPage(
   
   # Application title
   titlePanel("Test Your Probability Intuition"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput(inputId = "guess", label = NULL, min = 0, max = 1, value = 0.5, step = 0.01),
         actionButton(inputId = "submit", label = "Guess!")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        textOutput("params"),
        p(),
        textOutput("results")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  flips <- sample(1:100, 1)
  
  heads <- sample(1:flips, 1, prob = dnorm(1:flips, mean = flips/2, sd = flips/ 5))   
  
  output$params <- renderText({
    paste("I am flipping a fair coin", flips, "times. What's the probability I get", heads, "or more heads?")
    
  })
  

  output$results <- renderText({
    your_guess <- eventReactive(input$submit, {input$guess})
    paste("You guessed", your_guess(), 
          "BUT ... the answer is", round(1 - pbinom(q = heads-1, size = flips, prob = 0.5), 3))
  })

}

# Run the application 
shinyApp(ui = ui, server = server)

