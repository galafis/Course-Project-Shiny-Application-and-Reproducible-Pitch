library(shiny)
library(ggplot2)

# Define server logic
server <- function(input, output) {
  
  # Calculate BMI when button is clicked
  bmiData <- eventReactive(input$calculate, {
    # Get input values
    height_m <- input$height / 100  # Convert cm to meters
    weight_kg <- input$weight
    
    # Calculate BMI
    bmi <- weight_kg / (height_m^2)
    
    # Determine BMI category
    category <- if (bmi < 18.5) {
      "Underweight"
    } else if (bmi < 25) {
      "Normal weight"
    } else if (bmi < 30) {
      "Overweight"
    } else {
      "Obese"
    }
    
    # Determine CSS class for styling
    css_class <- if (bmi < 18.5) {
      "underweight"
    } else if (bmi < 25) {
      "normal"
    } else if (bmi < 30) {
      "overweight"
    } else {
      "obese"
    }
    
    # Return results
    list(
      bmi = bmi,
      category = category,
      css_class = css_class
    )
  })
  
  # Display BMI result
  output$bmiResult <- renderUI({
    bmi_data <- bmiData()
    
    div(class = paste("result-box", bmi_data$css_class),
        h3(paste("Your BMI:", round(bmi_data$bmi, 1))),
        h4(paste("Category:", bmi_data$category))
    )
  })
  
  # Display health recommendations
  output$healthRecommendations <- renderUI({
    bmi_data <- bmiData()
    
    recommendations <- switch(bmi_data$category,
      "Underweight" = list(
        "Consider consulting with a healthcare provider about healthy weight gain strategies.",
        "Focus on nutrient-dense foods to support healthy weight gain.",
        "Incorporate strength training to build muscle mass."
      ),
      "Normal weight" = list(
        "Maintain your current healthy habits.",
        "Regular physical activity (150+ minutes per week) is recommended.",
        "Continue balanced nutrition with plenty of fruits and vegetables."
      ),
      "Overweight" = list(
        "Aim for gradual weight loss of 0.5-1 kg per week.",
        "Increase physical activity to at least 150-300 minutes per week.",
        "Focus on portion control and reducing processed foods."
      ),
      "Obese" = list(
        "Consider consulting with a healthcare provider about weight management.",
        "Aim for gradual, sustainable weight loss.",
        "Focus on both dietary changes and increased physical activity."
      )
    )
    
    tagList(
      tags$ul(
        lapply(recommendations, tags$li)
      )
    )
  })
  
  # Create BMI gauge visualization
  output$bmiGauge <- renderPlot({
    bmi_data <- bmiData()
    bmi <- bmi_data$bmi
    
    # Create data for gauge
    gauge_data <- data.frame(
      x = c(0, 18.5, 25, 30, 40),
      y = c(0, 0, 0, 0, 0),
      category = c("", "Underweight", "Normal", "Overweight", "Obese"),
      fill = c("white", "#fff3cd", "#d4edda", "#f8d7da", "#f1b0b7")
    )
    
    # Create gauge plot
    ggplot() +
      geom_rect(data = data.frame(
        xmin = c(0, 18.5, 25, 30),
        xmax = c(18.5, 25, 30, 40),
        ymin = c(-0.5, -0.5, -0.5, -0.5),
        ymax = c(0.5, 0.5, 0.5, 0.5),
        fill = c("#fff3cd", "#d4edda", "#f8d7da", "#f1b0b7")
      ), aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = fill), alpha = 0.7) +
      scale_fill_identity() +
      geom_text(data = data.frame(
        x = c(9.25, 21.75, 27.5, 35),
        y = c(0, 0, 0, 0),
        label = c("Underweight", "Normal", "Overweight", "Obese")
      ), aes(x = x, y = y, label = label), size = 4) +
      geom_segment(aes(x = bmi, y = -0.7, xend = bmi, yend = 0.7), 
                  color = "#2c3e50", size = 1.5, arrow = arrow(length = unit(0.5, "cm"))) +
      geom_text(aes(x = bmi, y = -0.9, label = paste("Your BMI:", round(bmi, 1))),
               color = "#2c3e50", size = 5, fontface = "bold") +
      scale_x_continuous(limits = c(0, 40), breaks = c(0, 18.5, 25, 30, 40)) +
      scale_y_continuous(limits = c(-1, 1)) +
      theme_minimal() +
      theme(
        axis.title = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA)
      ) +
      labs(title = "BMI Scale")
  })
  
  # Create BMI comparison visualization
  output$bmiComparison <- renderPlot({
    bmi_data <- bmiData()
    bmi <- bmi_data$bmi
    
    # Create simulated population data
    set.seed(123)
    population_bmi <- data.frame(
      bmi = c(
        rnorm(200, mean = 17, sd = 1),    # Underweight
        rnorm(1000, mean = 22, sd = 1.5), # Normal
        rnorm(600, mean = 27, sd = 1.2),  # Overweight
        rnorm(400, mean = 33, sd = 2)     # Obese
      )
    )
    
    # Create comparison plot
    ggplot(population_bmi, aes(x = bmi)) +
      geom_histogram(aes(y = ..density..), binwidth = 0.5, fill = "#b3cde3", color = "white", alpha = 0.7) +
      geom_density(color = "#2c3e50", size = 1) +
      geom_rect(data = data.frame(
        xmin = c(0, 18.5, 25, 30),
        xmax = c(18.5, 25, 30, 40),
        ymin = c(0, 0, 0, 0),
        ymax = c(Inf, Inf, Inf, Inf),
        fill = c("#fff3cd", "#d4edda", "#f8d7da", "#f1b0b7")
      ), aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = fill), alpha = 0.2) +
      scale_fill_identity() +
      geom_vline(xintercept = bmi, color = "#e74c3c", size = 1.5, linetype = "dashed") +
      geom_text(aes(x = bmi + 1, y = 0.15, label = paste("Your BMI:", round(bmi, 1))),
               color = "#e74c3c", size = 5, fontface = "bold") +
      annotate("text", x = c(9.25, 21.75, 27.5, 35), y = 0.02, 
               label = c("Underweight", "Normal", "Overweight", "Obese"),
               color = "#2c3e50", size = 4) +
      scale_x_continuous(limits = c(10, 40), breaks = seq(10, 40, by = 5)) +
      theme_minimal() +
      theme(
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA)
      ) +
      labs(
        title = "Your BMI Compared to Population Distribution",
        x = "Body Mass Index (BMI)",
        y = "Density"
      )
  })
  
  # Create BMI projection visualization
  output$bmiProjection <- renderPlot({
    bmi_data <- bmiData()
    current_bmi <- bmi_data$bmi
    height_m <- input$height / 100
    current_weight <- input$weight
    
    # Create projection data based on scenario
    weeks <- 0:24  # 6 months projection
    
    weights <- switch(input$scenario,
      "maintain" = rep(current_weight, length(weeks)),
      "lose" = current_weight - (0.5 * weeks),
      "gain" = current_weight + (0.5 * weeks)
    )
    
    # Calculate projected BMIs
    projected_bmis <- weights / (height_m^2)
    
    # Create data frame for plotting
    projection_data <- data.frame(
      Week = weeks,
      BMI = projected_bmis
    )
    
    # Create projection plot
    ggplot(projection_data, aes(x = Week, y = BMI)) +
      geom_rect(data = data.frame(
        xmin = rep(-Inf, 4),
        xmax = rep(Inf, 4),
        ymin = c(0, 18.5, 25, 30),
        ymax = c(18.5, 25, 30, Inf),
        fill = c("#fff3cd", "#d4edda", "#f8d7da", "#f1b0b7")
      ), aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = fill), alpha = 0.2) +
      scale_fill_identity() +
      geom_line(color = "#2c3e50", size = 1.5) +
      geom_point(color = "#2c3e50", size = 3) +
      geom_hline(yintercept = c(18.5, 25, 30), linetype = "dashed", color = "gray50") +
      annotate("text", x = 1, y = c(17, 23, 28, 35), 
               label = c("Underweight", "Normal", "Overweight", "Obese"),
               color = "#2c3e50", size = 4, hjust = 0) +
      scale_x_continuous(breaks = seq(0, 24, by = 4)) +
      scale_y_continuous(limits = c(max(10, min(projected_bmis) - 2), max(projected_bmis) + 2)) +
      theme_minimal() +
      theme(
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", color = NA),
        panel.background = element_rect(fill = "white", color = NA)
      ) +
      labs(
        title = paste("BMI Projection -", 
                     switch(input$scenario,
                            "maintain" = "Maintaining Current Weight",
                            "lose" = "Losing 0.5 kg per Week",
                            "gain" = "Gaining 0.5 kg per Week")),
        x = "Weeks",
        y = "Body Mass Index (BMI)"
      )
  })
}
