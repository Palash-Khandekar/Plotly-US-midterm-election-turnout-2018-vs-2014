turnout <- read.csv("TurnoutRates.csv")
str(turnout)

# Create a scatterplot of turnout2018 against turnout2014
p <- turnout %>%
    plot_ly(x = ~turnout2014, y = ~turnout2018) %>%
    add_markers() %>%
    layout(xaxis = list(title = "2014 voter turnout"),
         yaxis = list(title = "2018 voter turnout"))
p
#look closely at the scatterplot you can see that nearly all of the y-coordinates are larger than the x-coordinates,
#showing that voter turnout was higher in 2018 than 2014; 

# Add the line y = x to the scatterplot
p %>%
  add_lines(x = c(.25, .6), y = c(.25, .6)) %>%
  layout(showlegend = FALSE)

# Create a dotplot of voter turnout in 2018 by state ordered by turnout
turn <- turnout %>%
  top_n(15, wt = turnout2018) %>%
  plot_ly(x = ~turnout2018, y = ~fct_reorder(state, turnout2018)) %>%
  add_markers() %>%
  layout(xaxis = list(title = "Eligible voter turnout"), 
         yaxis = list(title = "State", type = "category"))
turn
# Create a choropleth map of the change in voter turnout from 2014 to 2018
change <- turnout %>%
  mutate(change = turnout2018 - turnout2014) %>%
  plot_geo(locationmode = 'USA-states') %>%
  add_trace(z = ~change, locations = ~state.abbr) %>%
  layout(geo = list(scope = 'usa'))
change
#While Minnesota had the highest voter turnout 
#it didn't have the largest increase in turnout, that honor went to Missouri.