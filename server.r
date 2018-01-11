library(shiny)
library(FNN)
library(RMySQL)
library(shiny)
library(DT)

##################KNN################################
knn_function<-function(min_Ram,max_Ram,min_cpu,max_cpu,min_storage,max_storage,min_cost,max_cost,data) 
{
index<-which((data$ram>=min_Ram&data$ram<=max_Ram)&(data$vcpus>=min_cpu&data$vcpus<=max_cpu)&(data$disk>=min_storage&data$disk<=max_storage)&(data$cout>=min_cost&data$cout<=max_cost)==TRUE)
train<-data[index,-c(1,5,6)]
iden<-data[index,1]
test<-as.data.frame(t(c(max_Ram,max_cpu,max_storage,min_cost)))
distance<-knnx.dist(train,test,k=nrow(train))#Distance
index_knn<-knnx.index(train,test,k=nrow(train))#Index
out<-data[iden[index_knn],]
return(out)
}
######################################################################
data <- read.csv(file="data_base.csv",header=TRUE)

# Define server logic for slider examples
shinyServer(function(input, output) {

  # Reactive expression to compose a data frame containing all of the values
  sliderValues <- reactive({

    # Compose data frame
    data.frame(Name = c("Min CPU","Max CPU","Min RAM","Max RAM","Min Storage","Max Storage","Min Cost","Max Cost"),Value = as.character(c(input$min_cpu,input$max_cpu,input$min_ram,input$max_ram,input$min_storage,input$max_storage,input$min_cost,input$max_cost)), 
      stringsAsFactors=FALSE)
  })

sliderBest <- reactive({

    # Compose data frame
out<-NULL
if(!((input$min_ram>input$max_ram)|(input$min_cpu>input$max_cpu)|(input$min_storage>input$max_storage)|(input$min_cost>input$max_cost)))
{
 out<-knn_function(input$min_ram,input$max_ram,input$min_cpu,input$max_cpu,input$min_storage,input$max_storage,input$min_cost,input$max_cost,data) 
}
    data.frame(out, 
      stringsAsFactors=FALSE)
  })

  # Show the values using an HTML table
  output$values <- renderTable({
    sliderValues()
  })
  output$best <- renderTable({
   
     sliderBest()
  })


})
