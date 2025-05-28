library(shiny)

# Define UI
ui <- fluidPage(
  # Application title and theme
  titlePanel("BMI Calculator and Health Visualizer"),
  
  # Custom CSS styling
  tags$head(
    tags$style(HTML("
      .well { background-color: #f8f9fa; border-color: #ddd; }
      .panel { border-color: #ddd; }
      h2 { color: #2c3e50; }
      .btn-primary { background-color: #2c3e50; border-color: #2c3e50; }
      .btn-primary:hover { background-color: #1a252f; border-color: #1a252f; }
      .header-panel { background-color: #2c3e50; color: white; padding: 15px; margin-bottom: 20px; border-radius: 5px; }
      .result-box { padding: 15px; margin-top: 20px; border-radius: 5px; }
      .normal { background-color: #d4edda; color: #155724; }
      .underweight { background-color: #fff3cd; color: #856404; }
      .overweight { background-color: #f8d7da; color: #721c24; }
      .obese { background-color: #f1b0b7; color: #721c24; }
    "))
  ),
  
  # Introduction panel
  div(class = "header-panel",
      h3("Welcome to the BMI Calculator and Health Visualizer"),
      p("This application helps you calculate your Body Mass Index (BMI) and visualize how it compares to health standards.")
  ),
  
  # Sidebar with input controls
  sidebarLayout(
    sidebarPanel(
      h3("Enter Your Information"),
      
      # Input: Height
      numericInput("height", 
                   "Height (cm):", 
                   value = 170, 
                   min = 50, 
                   max = 250),
      
      # Input: Weight
      numericInput("weight", 
                   "Weight (kg):", 
                   value = 70, 
                   min = 20, 
                   max = 300),
      
      # Input: Age
      sliderInput("age", 
                  "Age:", 
                  min = 18, 
                  max = 100, 
                  value = 30),
      
      # Input: Gender
      radioButtons("gender", 
                   "Gender:", 
                   choices = list("Male" = "male", 
                                  "Female" = "female"),
                   selected = "male"),
      
      # Action button
      actionButton("calculate", "Calculate BMI", class = "btn-primary"),
      
      # Documentation
      hr(),
      h4("How to use this app:"),
      tags$ol(
        tags$li("Enter your height in centimeters"),
        tags$li("Enter your weight in kilograms"),
        tags$li("Select your age using the slider"),
        tags$li("Choose your gender"),
        tags$li("Click the 'Calculate BMI' button"),
        tags$li("View your results and visualizations")
      ),
      
      h4("About BMI:"),
      p("Body Mass Index (BMI) is a measure of body fat based on height and weight. It is used to screen for weight categories that may lead to health problems."),
      p("BMI Categories:"),
      tags$ul(
        tags$li("Underweight: BMI less than 18.5"),
        tags$li("Normal weight: BMI 18.5-24.9"),
        tags$li("Overweight: BMI 25-29.9"),
        tags$li("Obesity: BMI 30 or greater")
      )
    ),
    
    # Main panel with outputs
    mainPanel(
      tabsetPanel(
        tabPanel("Results", 
                 h3("Your BMI Results"),
                 uiOutput("bmiResult"),
                 plotOutput("bmiGauge"),
                 h4("Health Recommendations"),
                 uiOutput("healthRecommendations")
        ),
        tabPanel("Visualization", 
                 h3("BMI Comparison"),
                 plotOutput("bmiComparison"),
                 h4("Understanding Your BMI"),
                 p("This chart shows how your BMI compares to the general population distribution. The vertical line represents your current BMI."),
                 p("The colored regions represent different BMI categories:")
        ),
        tabPanel("BMI Over Time",
                 h3("BMI Projection"),
                 p("This chart shows how your BMI might change over time based on different scenarios."),
                 selectInput("scenario", "Select Scenario:",
                             choices = list("Maintain Current Weight" = "maintain",
                                           "Lose 0.5 kg per week" = "lose",
                                           "Gain 0.5 kg per week" = "gain")),
                 plotOutput("bmiProjection")
        )
      )
    )
  ),
  
  # Footer
  tags$footer(
    div(
      style = "text-align: center; margin-top: 30px; padding: 10px; border-top: 1px solid #ddd;",
      p("Created by Gabriel Demetrios Lafis | May 28, 2025"),
      p("This BMI calculator is for educational purposes only and should not replace professional medical advice.")
    )
  )
)
