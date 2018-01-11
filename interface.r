#sudo apt install mysql-client-core-5.7
#sudo apt-get install mysql-server
#sudo apt-get install r-cran-rmysql
#sudo gedit /etc/mysql/my.cnf
#[mysqld]
#datadir = /var/lib/mysql/
#socket = /var/lib/mysql/mysql.soc
graphics.off()
rm(list=ls())
#install packages
repos_berkeley="https://cran.cnr.berkeley.edu/"
if(sum(row.names(installed.packages())=="RMySQL")==0)
{
install.packages("RMySQL",repos=repos_berkeley)
}
if(sum(row.names(installed.packages())=="FNN")==0)
{
install.packages("FNN",repos=repos_berkeley)
}
if(sum(row.names(installed.packages())=="shiny")==0)
{
install.packages("shiny",repos=repos_berkeley)
}
#Load Packages
library(FNN)
library(RMySQL)
library(shiny)
con <- dbConnect(MySQL(), user="root", password="nando321", dbname="openstack", host="localhost",unix.socket = "/var/run/mysqld/mysqld.sock")
rs <- dbSendQuery(con, "select * from simul;")
data <- fetch(rs)
dbDisconnect(con)
##################KNN################################
write.csv(data,file="data_base.csv",row.names=FALSE,quote=FALSE)
######################################################################
#input
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






	



