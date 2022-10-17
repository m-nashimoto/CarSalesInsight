---
  title: "Project 1"
author: "Masana Nashimoto"
date: "`r Sys.Date()`"
output: github_document
---
  
  <style type="text/css">
  body p, div, h1, h2, h3, h4, h5 {
    color: black;
    font-family: Modern Computer Roman; }
slides > slide.title-slide hgroup h1 { color: #8C1D40; <!--the maroon color--> }
    slides > slide:not(.nobackground):after{
      content: '';
    }
  h2 {
    color: #8C1D40; <!-- the maroon color-->
  }
  slides > slide {
    overflow-x: auto !important;
    overflow-y: auto !important;
  }
  </style>
    
    ```{r setup, include=FALSE}
  knitr::opts_chunk$set(warning = FALSE, message = FALSE)
  knitr::opts_chunk$set(echo = FALSE)
  library(plotly)
  library(dplyr)
  df<- read.csv("Car_sales.csv")
  ```
  
  ## Addressing the problem
  While new car models come out and discontinued  each year, some model remains to be long time seller. For this project, I will dive into identify what characteristic does the top sold car have/what do consumers look for when buying a car.
  
  More information can be found here below.
  https://www.kaggle.com/datasets/gagandeep16/car-sales
  
  ## Setting up the necessity
  ```{r echo = T, results = 'hide'}
  library(plotly)
  library(dplyr)
  df<- read.csv("Car_sales.csv")
  df <- subset(df,select =-Vehicle_type)
  
  ```
  Every plot was generated using plotly 
  
  ## Dataset overview
  glimpse(df)
  ```{r}
  glimpse(df)
  ```
  
  ## Dataset overview continued
  Ford F-seiries seems to be the favorite by far.(possibly counting every F-series line up )
  ```{r echo = T, results = 'hide'}
  select(df, Manufacturer, Model, Sales_in_thousands) %>%
    arrange(desc(Sales_in_thousands))
  ```
  
  ```{r}
  
  select(df, Manufacturer, Model, Sales_in_thousands) %>%
    arrange(desc(Sales_in_thousands))
  fig1 <- plot_ly(x =df$Price_in_thousands, type="histogram")
  fig1 <- fig1 %>% layout(title ='Overview of the price of cars',
                          xaxis=list(title='Price of the cars'),
                          yaxis=list(title='Quantity of cars in the price bracket'))
  fig1
  ```
  
  ## First assumption Horsepower
  Assumption: horsepower
  ```{r}
  fig4 <- plot_ly(df, 
                  x = ~Horsepower,
                  y = ~Sales_in_thousands,
                  type='scatter',
                  mode = 'markers',
                  hoverinfo = 'text',
                  text = paste('Horsepower: ', df$Horsepower,
                               "<br>",
                               'Sales in thousands: ', df$Sales_in_thousands,
                               "<br>",
                               "Manufacture: ", df$Manufacturer,
                               "<br>",
                               "Model:", df$Model),
                  color = ~Manufacturer,
                  marker= list(size =10))
  fig4 <- fig4 %>% layout(
    yaxis = list(zeroline = FALSE),
    xaxis = list(zeroline = FALSE))
  fig4
  ```
  ```{r echo = T, results = 'hide'}
  fig4 <- plot_ly(df, 
                  x = ~Horsepower,
                  y = ~Sales_in_thousands,
                  type='scatter',
                  mode = 'markers',
                  hoverinfo = 'text',
                  text = paste('Horsepower: ', df$Horsepower,
                               "<br>",
                               'Sales in thousands: ', df$Sales_in_thousands,
                               "<br>",
                               "Manufacture: ", df$Manufacturer,
                               "<br>",
                               "Model:", df$Model),
                  color = ~Manufacturer,
                  marker= list(size =10))
  fig4 <- fig4 %>% layout(
    yaxis = list(zeroline = FALSE),
    xaxis = list(zeroline = FALSE))
  
  ```
  Result: Not everyone like the horsepower
  
  
  ## Comparing the usual suspects
  Another thing come to mind is usually car's horsepower and fuel economy.

```{r}
fig3 <- plot_ly(df, 
                x = ~Fuel_efficiency, 
                y = ~ Horsepower,
                type = 'scatter',
                text = paste('Horsepower: ', df$Horsepower,
                             "<br>",
                             'Fuel Efficiency', df$Fuel_efficiency,
                             "<br>",
                             'Sales in thousands: ', df$Sales_in_thousands,
                             "<br>",
                             "Manufacture: ", df$Manufacturer,
                             "<br>",
                             "Model:", df$Model),
                mode = 'markers',
                color = ~Sales_in_thousands )
fig3 <- fig3 %>% layout(title = 'Horsepower vs Fuel Efficiency',
                   xaxis = list(showgrid = FALSE),
                   yaxis = list(showgrid = FALSE))
fig3
```
```{r echo = T, results = 'hide'}
fig3 <- plot_ly(df, 
                x = ~Fuel_efficiency, 
                y = ~ Horsepower,
                type = 'scatter',
text = paste('Horsepower: ', df$Horsepower,
                             "<br>",
                             'Fuel Efficiency', df$Fuel_efficiency,
                             "<br>",
                             'Sales in thousands: ', df$Sales_in_thousands,
                             "<br>",
                             "Manufacture: ", df$Manufacturer,
                             "<br>",
                             "Model:", df$Model),
                mode = 'markers',
                color = ~Sales_in_thousands )
fig3 <- fig3 %>% layout(title = 'Horsepower vs Fuel Efficiency',
                   xaxis = list(showgrid = FALSE),
                   yaxis = list(showgrid = FALSE))

```
Fuel efficiency seems to be the favour.

## Diving in deeper, 3D plotting

Customer prefers inexpensive, fuel friendly car instead of beefy expensive car. Quite obvious to see the pllots are more concentrated on fuel friendly cars.
```{r}
fig5 <- plot_ly(df, x = ~Horsepower, y = ~Price_in_thousands, z = ~Fuel_efficiency,
                type ='scatter3d',
                mode = 'markers',
                hoverinfo = 'text',
                color =~Sales_in_thousands,
                text = paste("Cars sold in thousdands: ", df$Sales_in_thousands,
                             "<br>",
                             "Manufacture: ", df$Manufacturer,
                             "<br>",
                             "Model:", df$Model))
fig5 <- fig5 %>% add_markers()

fig5
```
```{r echo = T, results = 'hide'}
fig5 <- plot_ly(df, x = ~Horsepower, y = ~Price_in_thousands, z = ~Fuel_efficiency,
                type ='scatter3d',
                mode = 'markers',
                hoverinfo = 'text',
                color =~Sales_in_thousands,
                text = paste("Cars sold in thousdands: ", df$Sales_in_thousands,
                             "<br>",
                             "Manufacture: ", df$Manufacturer,
                             "<br>",
                             "Model:", df$Model))
fig5 <- fig5 %>% add_markers()

```
Omitting the Ford F-Seires to see the better understanding of where other car model stand.
```{r echo = T, results = 'hide'}
df=df[-57,]
```
```{r}
fig6 <- plot_ly(df, x = ~Horsepower, y = ~Price_in_thousands, z = ~Fuel_efficiency,
                type ='scatter3d',
                mode = 'markers',
                hoverinfo = 'text',
                color =~Sales_in_thousands,
                text = paste("Cars sold in thousdands: ", df$Sales_in_thousands,
                             "<br>",
                             "Manufacture: ", df$Manufacturer,
                             "<br>",
                             "Model:", df$Model))
fig6 <- fig6 %>% add_markers()
fig6
```




## Deepdive continue
Here, rather than looking at the total car sold, I have made a column of revenue for better understanding.Horsepower and fuel efficiency relationship is inverse proportion regardless. 
```{r echo = T, results = 'hide'}
df$revenue <-with(df, Sales_in_thousands * Price_in_thousands)
```
```{r}
df$revenue <-with(df, Sales_in_thousands * Price_in_thousands)
fig7 <- plot_ly(df, 
                x = ~Fuel_efficiency, 
                y = ~ Horsepower,
                type = 'scatter',
                text = paste('Horsepower: ', df$Horsepower,
                             "<br>",
                             'Fuel Efficiency', df$Fuel_efficiency,
                             "<br>",
                             'Revenue in Millions: ', df$revenue,
                             "<br>",
                             "Manufacture: ", df$Manufacturer,
                             "<br>",
                             "Model:", df$Model),
                mode = 'markers',
                color = ~revenue )
fig7 <- fig7 %>% layout(title = 'Horsepower vs Fuel Efficiency',
                   xaxis = list(showgrid = FALSE),
                   yaxis = list(showgrid = FALSE))
fig7

fig8 <- plot_ly(df, x = ~Horsepower, y = ~Engine_size, z = ~Fuel_efficiency,
                hoverinfo = 'text',
                color =~revenue,
                text = paste('Fuel Efficiency', df$Fuel_efficiency,
                             "<br>",
                             "Manufacture: ", df$Manufacturer,
                             "<br>",
                             "Model:", df$Model))
fig8 <- fig8 %>% add_markers()
fig8 <- fig8 %>% layout(title = 'Horsepower vs Fuel Efficiency vs Engine Size')
fig8

```



## Conclusion
By plotting the given data, I was able to solve what customers are looking for when shopping for cars.At first, horsepower could be one of a good factor. However, that's not the case, customers are looking for inexpensive and fuel friendly car like what I would pick.Ford F-Series being top could be the data is counting all of the F-Series line up(F-150, F-250 etc)