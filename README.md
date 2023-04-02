# StatisticShinyApp

Authors: Friederike Marby and Paula Möller <br>
Date: 2021-01-12

## Purpose of the ShinyApp
The aim of this ShinyApp is to create an understanding of the meaning and use of confidence intervals. Confidence intervals (CI) are statistical intervals that can be used to better estimate where - as in this case - the true expected value µ lies. This concept is used because in statistics calculated values are often based on a sample. By calculating confidence intervals for the estimated expected value, it is then possible, for example, to make the statement that the true expected value µ of the population is within a certain interval with a probability equal to the confidence level.

## Operation of the application
For this example of calculating confidence intervals, initial values for the expected value and standard deviation of norm scales such as the IQ norm, z-scale, T-scale and performance scale of PISA studies, which are used for the standardization of psychological tests, can be specified for an initial preselection via the drop-down. Furthermore, the sample size values and confidence level can be specified using an input slider.

## Calculation of the application
The confidence intervals in this application are calculated using the following formulas for the upper and lower limits of the interval, since the standard deviation is known in this case. 
[ˉx-z_(1-α/2)  σ/√n  ,ˉx-z_(1-α/2)  σ/√n  ]

## Diagrams of the application
The sample data set diagram contains the distribution of the generated values of the normal distribution with the selected sample size, the specified expected value and the specified standard deviation. The green lines in this diagram represent the interval limits of the confidence interval. The diagram Confidence interval around the estimated expected value shows the distribution of the mean values and also the interval limits in which the true mean value is to be expected. It can be clearly seen that the confidence interval is narrower for the distribution of the data than for the distribution of the mean values.

## Link to the application
https://friederikema.shinyapps.io/htwmoema/

## Sources
* Fahrmeir, L., Heumann C., et al. (2010): Statistik – Der Weg zur Datenanalyse. 7. Auflage, Springer.
* Rdrr.iO (2022): shinyjs, in: https://rdrr.io/cran/shinyjs/, (Stand: 04.01.2022).
* RStudio (2022): ShinyDashboard, in: https://rstudio.github.io/shinydashboard/, (Stand: 04.01.2022). 
* Schemmel, J., Ziegler, M. (2020): Der Konfidenzintervall-Rechner: Web-Anwendung zur Berechnung und grafischen Darstellung von Konfidenzintervallen für die testpsychologische Diagnostik. Report Psychologie, 45(1), 16-21.
* Schmuller, J. (2017): Statistik mit R für Dummies, Weinheim.
* StudyFlix (2021): Konfidenzintervalle, in: https://studyflix.de/statistik/konfidenzintervall-1580, (Stand: 28.12.2021)
* Wikipedia (2022): Normwertskala, in: https://de.wikipedia.org/wiki/Normwertskala, (Stand: 04.01.2022).
