library(shiny)
library(FNN)
library(RMySQL)
library(shiny)
library(DT)
#con <- dbConnect(MySQL(), user="root", password="nando321", dbname="openstack", host="localhost",unix.socket = "/var/run/mysqld/mysqld.sock")
#rs <- dbSendQuery(con, "select * from simul;")
#data <- fetch(rs)
#dbDisconnect(con)
data <- read.csv(file="data_base.csv",header=TRUE)



# Define UI for slider demo application
shinyUI(pageWithSidebar(
  
  #  Application title
  headerPanel("Creation des instances"),
  
  # Sidebar with sliders that demonstrate various available options
  sidebarPanel(
    #tags$img(src='image.png',height=50,width=50),
    #tags$img(src='image2.png',height=90,width=70),
    HTML('<center><img src="image2.png" width="90" height="100"></center>'),
    # Simple integer interval
    
    sliderInput("min_cpu", "Min CPU:", 
                min = min(data$vcpus), max = max(data$vcpus), value = 1, step= 1),

    # Decimal interval with step value
    sliderInput("max_cpu", "Max CPU:", 
                min = min(data$vcpus), max = max(data$vcpus), value = 1, step= 1),
   # Simple integer interval
    sliderInput("min_ram", "Min RAM:", 
                min = min(data$ram), max = max(data$ram), value = min(data$ram), step= 256),

    # Decimal interval with step value
    sliderInput("max_ram", "Max RAM:", 
                min = min(data$ram), max = max(data$ram), value =min(data$ram), step= 256),

# Simple integer interval
    sliderInput("min_storage", "Min Storage:", 
                min = min(data$disk), max = max(data$disk), value = min(data$disk), step= 5),

    # Decimal interval with step value
    sliderInput("max_storage", "Max Storage:", 
                min = min(data$disk), max = max(data$disk), value = min(data$disk), step= 5),

 # Simple integer interval
    sliderInput("min_cost", "Min Cost:", 
                min = min(data$disk), max = max(data$cout), value = min(data$cout), step= 5),

    # Decimal interval with step value
    sliderInput("max_cost", "Max Cost:", 
                min = min(data$disk), max = max(data$cout), value = min(data$cout), step= 5) 
      

  ),


  # Show a table summarizing the values entered
  mainPanel(
    tableOutput("values"),tableOutput("best"),
    textInput("Choix de l'id", "Choix de l'id:", "id"),
    actionButton("goButton", "Creer l'instance"),
    helpText("Instance cree avec succes : ip : 192.156.1.23 username : cirros password : cirros")
    
    
            )
))


