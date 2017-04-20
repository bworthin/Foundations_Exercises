# titanic is avaliable in your workspace

# Check out the structure of titanic
str(titanic)

# Create a 'dodgy' bar chart of passengers by cPlass with fill by Sex
ggplot(titanic, aes(x = factor(Pclass), fill = factor(Sex))) +
  geom_bar(position = "dodge")


# Add a facet_grid layer to split into two graphs according to who survived vs didn't
ggplot(titanic, aes(x = factor(Pclass), fill = factor(Sex))) +
  geom_bar(position = "dodge") +
  facet_grid(". ~ Survived")

# Position jitter - set to 0.5
posn.j <- position_jitter(0.5, 0)

# Map Age to y axis, change to scatter plot, set jitter and alpha to handle overplotting more clearly
ggplot(titanic, aes(x = factor(Pclass), y = Age, col = factor(Sex))) +
  geom_jitter(size = 3, alpha = 0.5, position = posn.j) +
  facet_grid(". ~ Survived")
