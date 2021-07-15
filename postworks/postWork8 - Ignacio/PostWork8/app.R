#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



#install.packages("shinythemes")
#(shinythemes)
library(shiny)
library(shinydashboard)

ui <- 
    
    fluidPage(
        
        dashboardPage(skin = "purple",
                      
                      dashboardHeader(title = "PostWork 8"),
                      
                      dashboardSidebar(
                          
                          sidebarMenu(
                              menuItem("Grafica de Barras", tabName = "Barras", icon = icon("bar-chart-o")),
                              menuItem("Graficas de Postwork 3", tabName = "PW3", icon = icon("area-chart")),
                              menuItem("Match Data - DataTable", tabName = "data_table", icon = icon("table")),
                              menuItem("Factores de Ganancia", tabName = "Fact", icon = icon("line-chart"))
                          )
                          
                      ),
                      
                      dashboardBody(
                          
                          # Aditivos :D
                          singleton(tags$head(tags$script(src='script.js'))),
                          singleton(tags$head(tags$link(rel="stylesheet", type = "text/css", href = "styles.css"))),
                          
                          tabItems(
                              
                              # Graficas de Barras
                              tabItem(tabName = "Barras",
                                      fluidRow(
                                          box(width = NULL, height = NULL,
                                              titlePanel("Grafica de Barras de Goles en contra y a favor"), 
                                              selectInput("variable", "Seleccione el valor de X",
                                                          choices = c("home.score","away.score")),
                                              plotOutput("output_plot")
                                          )
                                      )
                              ),
                              
                              # Graficas obtenidas en PostWork3
                              tabItem(tabName = "PW3", 
                                      fluidRow(
                                          box(width = NULL, height = NULL,
                                              titlePanel(h3("Graficos obtenidos en Postwork 3")),
                                              img(src = "Barras.png", height = 450, width = 650),
                                              img(src =  "ProbConjunta.png", height = 450, width = 650)
                                          )
                                      )
                              ),
                              
                              
                              #Match Data en DataTable
                              tabItem(tabName = "data_table",
                                      fluidRow(
                                          box(width = NULL, height = NULL,
                                              titlePanel(h3("Match Data")),
                                              dataTableOutput ("dataTable")
                                          )
                                      )
                              ), 
                              
                              #Factores de Ganacia Maximos y promedios Obtenidos en momios.r
                              tabItem(tabName = "Fact",
                                      fluidRow(
                                          box(width = NULL, height = NULL,
                                              titlePanel(h3("Factores de Ganancia")),
                                              h4("Factor de Ganancia Maximos:"),
                                              img(src = "Escenario_MomiosMax.png", height = 450, width = 750),
                                              h4("Factor de Ganancia Promedios:"),
                                              img(src = "Momios_Promedio.png", height = 450, width = 750)
                                          )
                                      )
                              )
                              
                          )
                      )
        )
    )



server <- function(input, output) {
    library(ggplot2)
    
    
    data <- read.csv("https://raw.githubusercontent.com/AngelicaDC/Postworks_BEDU/main/postworks/postWork8%20-%20Ignacio/PostWork8/data/match.data.csv")
    
    
    output$output_plot <- renderPlot({
        ggplot(data, aes_string(x = input$variable, fill = "FTR")) +
            geom_bar() +
            facet_wrap(as.factor(data$away.team))+
            ggtitle("Goles a favor y en contra")+
            ylab("N° de Goles")}, width = "auto" ,height = 650)
    
    output$dataTable <- renderDataTable({data},options = list(aLengthMenu = c(10,20,50), iDisplayLength = 20))
    
}


shinyApp(ui, server)

