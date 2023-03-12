# StatisticShinyApp

Authors: Friederike Marby and Paula Möller <br>

## Sinn und Zweck der ShinyApp:
Mithilfe dieser ShinyApp soll ein Verständnis über die Bedeutung und Nutzung von Konfidenzintervallen geschaffen werden. Unter Konfidenzintervallen (KI) sind statistische Intervalle zu verstehen, mit welchem man besser einschätzen kann, wo - wie in diesem Fall - der wahre Erwartungswert µ liegt. Dieses Konzept wird angewendet, da in der Statistik berechnete Werte oft auf der Grundlage einer Stichprobe zustande kommen. Durch die Berechnung von Konfidenzintervallen für den geschätzten Erwartungswert kann dann zum Beispiel die Aussage getroffen werden, dass der wahre Erwartungswert µ der Grundgesamtheit sich mit einer Wahrscheinlichkeit in Höhe des Konfidenzniveaus innerhalb eines bestimmten Intervalls befindet.

## Bedienung der Anwendung:
Für dieses Beispiel zur Berechnung von Konfidenzintervallen können für eine erste Vorauswahl über das Drop-Down erste Werte für Erwartungswert und Standardabweichung von Normwertskalen wie der IQ-Norm, z-Skala, T-Skala und Leistungsskala von PISA-Studien, die für die Normierung von psychologischen Tests verwendet werden, festgelegt werden. Des Weiteren können die Werte zur Stichprobengröße und das Konfidenzniveau mittels eines Input Sliders festgelegt werden.

## Berechnung der Anwendung:
Die Berechnung der Konfidenzintervalle in dieser Anwendung erfolgt mithilfe der folgenden Formeln für die Ober- und Untergrenze des Intervalls, da die Standardabweichung in diesem Fall bekannt ist. 
[ˉx-z_(1-α/2)  σ/√n  ,ˉx-z_(1-α/2)  σ/√n  ]

## Diagramme der Anwendung:
Das Diagramm Datensatz der Stichprobe enthält die Verteilung der generierten Werte der Normalverteilung mit der ausgewählten Stichprobengröße, dem angegebenen Erwartungswert und der angegebenen Standardabweichung. Mit den grünen Linien sind in diesem Diagramm die Intervallgrenzen des Konfidenzintervalls dargestellt. Das Diagramm Konfidenzintervall um den geschätzten Erwartungswert bildet die Verteilung der Mittelwerte ab und es werden ebenfalls die Intervallgrenzen ab abgebildet, in denen der wahre Mittelwert zu erwarten ist. Es ist deutlich zu erkennen, dass das Konfidenzintervall bei der Verteilung der Daten enger ist als bei der Verteilung der Mittelwerte.

## Link zur Anwendung: 
https://friederikema.shinyapps.io/htwmoema/

## Quellen:
* Fahrmeir, L., Heumann C., et al. (2010): Statistik – Der Weg zur Datenanalyse. 7. Auflage, Springer.
* Rdrr.iO (2022): shinyjs, in: https://rdrr.io/cran/shinyjs/, (Stand: 04.01.2022).
* RStudio (2022): ShinyDashboard, in: https://rstudio.github.io/shinydashboard/, (Stand: 04.01.2022). 
* Schemmel, J., Ziegler, M. (2020): Der Konfidenzintervall-Rechner: Web-Anwendung zur Berechnung und grafischen Darstellung von Konfidenzintervallen für die testpsychologische Diagnostik. Report Psychologie, 45(1), 16-21.
* Schmuller, J. (2017): Statistik mit R für Dummies, Weinheim.
* StudyFlix (2021): Konfidenzintervalle, in: https://studyflix.de/statistik/konfidenzintervall-1580, (Stand: 28.12.2021) 
