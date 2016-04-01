library(shiny)

## ui.R ##
library(shinydashboard)
sidebar <- dashboardSidebar(
        sidebarMenu(
                menuItem("Ngram App", tabName = "app", icon = icon("play")),
                menuItem("App Doc(coming soon)", icon = icon("book"), tabName = "doc",
                         badgeLabel = "new", badgeColor = "green")
                
        )
)

body <- dashboardBody(
        
        
        tabItem(tabName = 'table',

                fluidRow(
                        box(
                                title = "Inputs", status = "warning",
                                width = 7,height = 400,
                                collapsible = TRUE,
                                textInput("mytext", "Your Input Here:",width = '100%',value = "soccer"),
                                br(),
                                sliderInput("mynumber", "Choose Number of Choices to Display:", 1, 3, 3),
                                h4('App Instruction:'),
                                h5("The next-word-prediction app is able to predict the next word based on user's input. Top 3 predicted words along with their scores will be displayed in the bottom section. All possible words will be displayed in the word cloud graph."),
                                h5('To use the app, the user should input any natural language in the text box above and choose number of top words to display using the slider.'),
                                h6('Please refer to my github for code details:github.com/snowneji/')
                                
                        ),
                        box(
                                title = "", status = "warning",
                                width = 5,height = 400,
                                collapsible = TRUE,
                                plotOutput(outputId = 'plot')
                        )
                        
                        
                ),
                fluidRow(
                        valueBoxOutput( "bestword",width = 12)  
                ),
                fluidRow(
                        valueBoxOutput( "secondword",width = 12)  
                ),
                fluidRow(
                        valueBoxOutput( "thirdword",width = 12)    
                )
                
                
                
                
        )
        
        
        
        
        
        
)

# Put them together into a dashboardPage
dashboardPage(
        skin = 'blue',
        dashboardHeader(title = "Author: Yifan Wang"),
        sidebar,
        body
)


