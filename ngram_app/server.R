

# Define a server for the Shiny app
shinyServer(function(input, output) {
        library(shiny)
        library(shinydashboard)
        library(wordcloud)
        source('main_script.R')
        res= reactive({
                a=res1(query = input$mytext,sum_data)
                b = res2(a,rec_num = input$mynumber)
                b
                })
        plot_res = reactive({
                dat=res1(query = input$mytext,sum_data)
                wordcloud(words =dat$term,freq = dat$sum_data,random.order = F,colors =brewer.pal(8, 'Dark2'),max.words = 30,scale=c(6,1) )
                })
        
        output$bestword = renderValueBox({

                valueBox(
                        value = res()[1],
                        subtitle = 'Your next word is most likely',
                        icon = icon('rocket'),
                        color = 'lime'
                        )     
        })
        
        output$plot = renderPlot({
                plot_res()
                
        })
        
        
        
        
        

        
        output$secondword = renderValueBox({
          
                valueBox(
                        value = if(is.na(res()[2,])){"Oops, I'm running out of words"} else{res()[2]},
                        subtitle = 'If not,probably',
                        icon = icon('car'),
                        color = 'yellow'
                )     
        })
        
        output$thirdword = renderValueBox({
                valueBox(
                        value = if(is.na(res()[3,])){"Oops, I'm running out of words"} else{res()[3]},
                        subtitle = 'Well..One last shot',
                        icon = icon('bicycle'),
                        color = 'light-blue'
                )     
        })
})