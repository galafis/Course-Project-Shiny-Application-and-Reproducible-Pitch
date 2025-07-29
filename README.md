# BMI Calculator and Health Visualizer

![BMI Calculator Preview](images/bmi_preview.png)

## Overview

This interactive Shiny application helps users calculate their Body Mass Index (BMI) and provides personalized health recommendations based on the results. The app features multiple visualizations to help users understand their BMI in context and explore potential changes over time.

## Features

- **BMI Calculation**: Calculate your BMI using height, weight, age, and gender inputs
- **Health Assessment**: Receive your BMI category (Underweight, Normal, Overweight, Obese)
- **Personalized Recommendations**: Get tailored health suggestions based on your BMI category
- **Interactive Visualizations**:
  - BMI Gauge: See where your BMI falls on the health spectrum
  - Population Comparison: Compare your BMI to a simulated population distribution
  - BMI Projection: Visualize how your BMI might change over time with different weight scenarios

## How to Use

### Running the App Locally

1. Clone this repository:
   ```
   git clone https://github.com/galafis/BMI-Calculator-Shiny.git
   ```

2. Open R or RStudio and set your working directory to the app folder:
   ```r
   setwd("path/to/BMI-Calculator-Shiny/app")
   ```

3. Install required packages if you haven't already:
   ```r
   install.packages(c("shiny", "ggplot2"))
   ```

4. Run the Shiny app:
   ```r
   shiny::runApp()
   ```

### Using the App

1. Enter your height in centimeters
2. Enter your weight in kilograms
3. Select your age using the slider
4. Choose your gender
5. Click the "Calculate BMI" button
6. View your results and explore the visualizations in different tabs

## Understanding BMI

Body Mass Index (BMI) is a measure of body fat based on height and weight. It is used to screen for weight categories that may lead to health problems.

### BMI Categories:

- **Underweight**: BMI less than 18.5
- **Normal weight**: BMI 18.5-24.9
- **Overweight**: BMI 25-29.9
- **Obesity**: BMI 30 or greater

## Project Structure

```
BMI-Calculator-Shiny/
├── app/
│   ├── ui.R                # User interface definition
│   └── server.R            # Server logic and calculations
├── presentation/
│   ├── presentation.Rmd    # R Markdown presentation slides
│   └── styles.css          # Custom styles for presentation
├── images/                 # Images for documentation
└── README.md               # This documentation file
```

## Presentation

A 5-slide presentation about this application is available in the `presentation` folder. The presentation explains:

1. The purpose and features of the BMI Calculator
2. How BMI is calculated
3. The interactive features of the application
4. Sample visualizations
5. How to access and use the application

To view the presentation:

1. Open the `presentation.Rmd` file in RStudio
2. Click "Run Presentation" or use the following R command:
   ```r
   rmarkdown::run("presentation/presentation.Rmd")
   ```

## Technical Details

This application is built using:

- **R**: Core programming language
- **Shiny**: Web application framework for R
- **ggplot2**: Data visualization package
- **R Markdown**: For the presentation slides

## Future Enhancements

Potential future improvements include:

- Adding more health metrics beyond BMI
- Implementing data persistence to track changes over time
- Adding export functionality for reports
- Creating a mobile-friendly version

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Created by Gabriel Demetrios Lafis on May 28, 2025.

---

**Note**: This BMI calculator is for educational purposes only and should not replace professional medical advice.


## 📋 Descrição

Descreva aqui o conteúdo desta seção.


## 📦 Instalação

Descreva aqui o conteúdo desta seção.


## 💻 Uso

Descreva aqui o conteúdo desta seção.


## 📄 Licença

Descreva aqui o conteúdo desta seção.
