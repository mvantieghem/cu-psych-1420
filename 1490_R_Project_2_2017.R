##################################################################
##################### UN1490 Assignment 2: R #####################
##################### Assigned: 9/18 #############################
##################### Due: 9/25 before class #####################
##################################################################

# 0. While R can do a lot of amazing stuff on its own, some special
# types of analysis or graphing can be more easily (or stylishly) 
# done using one of a (huge) number of "packages" that people have
# created specially for R. Think of R as your phone, and the packages
# as apps that each allow the phone to do something extra.

# To use a package, you have to install it (once), and then open it
# (every time you re-run your script after using the rm() command to
# remove objects from your workspace). 

# So if you haven't already installed ggplot, run the line of code 
# below. Once you've run it once, add a # to the beginning of its 
# line so it doesn't get re-installed each time you run this script.
# We'll use ggplot at the end of this assignment, to graph your results.

install.packages('ggplot2')

# The command to open the ggplot library is:

library(ggplot2)

# 1. Check your working directory using getwd(). If necessary, change
# directories so that you're working in the same directory that contains
# your datafile (classdata_2017.csv) and your R scripts.


# 2. Read in your data file using read.csv("classdata_2017.csv"), and 
# assign it to the dataframe name TDM.


# 3. Use head(), summary(), and str() to check that the dataframe read
# in correctly.


# 4. Calculating variables from the Regret and Maximization scales:

# Use the code you wrote in your Project 1 to create a new variable
# for overall Regret score in the TDM dataframe called regret_total.

# You'll take a similar approach to calculating an overall Maximizing
# score from the six items we took from the short version of the 
# Maximizing Scale. They are called maxi1, maxi2, maxi3, etc.

# First, assign a new variable called maxi_total that is the average of 
# all six maxi scores (if you need help, see Project 1's code for 
# calculating the mean regret score).

# The Maximizing Scale has been shown to divide up into three subscales:
# Alternative Search (maxi1 & maxi3), Decision Difficulty (maxi2 & maxi5),
# and High Standards (maxi4 & maxi6). Please assign three new variables in
# the TDM dataframe, each of which represents one subscale: maxi_as, maxi_dd,
# and maxi_hs. (Hint: you should be averaging the two scores for each.)


# 5. Use head() to check your creation of the new variables regret_total,
# maxi_total, and maxi_as, maxi_dd, & maxi_hs. 


# 6. Now we can start doing some real data analysis! For the purposes of 
# getting practice in a variety of inferential statistics in R, we'll be
# running more exploratory tests than would normally be considered wise
# for a real study (we'll talk more about why this is a problem later in
# the semester, but hopefully in your stats class you talked about the 
# dangers of running too many tests--i.e., alpha-inflation).

# Let's start with some simple descriptive statistics on our new variables.
# Use mean() and sd() to find the mean and standard deviations for total
# regret, total maximizing, and each of the maxi subscales. 

# Use hist() to visualize the range of scores for each of the variables above.

# Use summary() to get a summary of some of our categorical variables 
# (variables that are not numeric, but rather can take on one of a few
# specified categories): classyr, school, gender, handed.

# Explore at least 5 other variables that you think might have a relationship
# with maximizing and/or regret. If the variable is numeric or interval
# (i.e., if its responses are numbers), compute the mean and sd, and
# produce a histogram. If the variable is categorical, produce a summary.


# 7. Now that you have a sense for what the data show, let's look at how
# some of the variables relate to each other. First, some correlations.

# 7a.
# Let's see if age correlates with birthyear (it should!). The function
# cor.test() allows us to put in two variables and see what their 
# correlation is. Since we just want to do a normal Pearson correlation,
# we'll tell R to run one with method="pearson" ...but you can also run
# a Kendall or Spearman with method="kendall" or method="spearman" if your
# data call for it.

cor.test(TDM$age, TDM$birthyear, method="pearson")

# * What is the r-value and the p-value for this correlation?

# 7b.
# Let's see if maximizing correlates with regret. Use cor.test() on those
# two variables, and report the r-value and p-value.

# Typically, maximizing correlates reasonably strongly with regret (r~0.4).
# Is that the case in our dataset? 

# 7c.
# Let's see if maximizing correlates with various measures of 
# course-selection behavior. Try finding the correlations between maxi_total
# and: courses_enrolled, courses_shopped, points_enrolled, and time_spent.

# 7d.
# Is the regret score, as calculated by the Regret Scale, correlated with
# our students' self-reports of regret (process_regret and outcome_regret)?
# What about regret_general?

# 7e.
# Is the score on the Maximizing Scale related to the self-report of 
# tendency to maximize (maxi_general)?

# 8. T-tests!

# We use t-tests to determine if two samples likely come from different
# populations. Of course, means will always differ somewhat, even if
# two samples are drawn from the same population. When the t-value is high
# enough, we conclude that it's very likely that the two samples actually
# represent two different populations.

# The R command for a Student's t-test is t.test(dv ~ iv, data = DataFrame)
# Note that because we're defining the dataframe (TDM) within the test, we
# don't need to include it in the names of both variables (like this: TDM$age).
# We can just use the variable name on its own (like this: age).

# 8a. 
# Let's start by seeing if there's a difference in age based on handedness.
# (There shouldn't be!)
# Note: t-tests can only be run on two groups. If there was someone ambidextrous 
# in the dataset, say, in row 8, we want to ignore that whole line of observations. 
# We can do this by telling R to run on the dataset TDM, but omitting row 8.

t.test(age ~ handed, data = TDM[-8,])

# 8b.
# What about regret--does it differ by gender?

# 8c.
# Does tendency to maximize differ by gender?

# 8d.
# It might be reasonable to expect that people who made their course decisions
# using a calculation-based mode are more likely to be maximizers than those
# who used an affect- or rule-based mode. So we should see if there's any
# difference in maximizing between those who used calculation-based modes and
# those who didn't.

# The question about decision mode allowed for 4 options (calculation, rule,
# role, and affect). To do a t-test, we need the variable re-coded as
# calculation vs. not-calculation. To do this, we'll use the ifelse() function.
# The code below tells R to create a new variable (dec_mode_2) whose value
# is calc if the original variable (dec_mode) was calculation-based, and whose value is
# not-calc otherwise. 
# Note: Check that the levels of TDM$dec_mode are still correct for your dataset using summary().

TDM$dec_mode_2 <- ifelse(TDM$dec_mode == "calculation-based decision mode (e.g., weighing pros and cons of each course against one another)", "calc", "not-calc")

# Now you can run a t-test just like above, with dec_mode_2 as the IV and
# maximizing as the DV.

# 9. Time to graph some results! ggplot is an extra package that helps R make
# prettier, better figures. We'll use ggplot to make a scatterplot and a bar
# graph, but first let's get oriented with how it works.

# At the beginning of this lab, you installed the package ggplot. You only
# have to do that once ever (unless you uninstall). We also called up the 
# ggplot library with the library(ggplot) command. You need to do that once
# per session of using R.

# ggplot allows you to format your figures in many cool ways, but for our
# purposes, it's easiest to just define a "theme" one time, and then apply
# it to every figure. We'll use one we'll call bwtheme (for black-white),
# which is nice and simple. Like when you pull up the ggplot library, you
# only need to run the code to define the theme once, so highlight and run
# the code below now:

bwtheme <-   theme_bw() + 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        strip.background = element_rect(fill = 'white')) +
  theme(plot.title = element_text(size = rel(1))) + 
  theme(axis.title = element_text(size = rel(1))) 

# When you plot data with ggplot, you need to tell it 3 things:
#  1. what type of plot to make (e.g., scatter, bar chart)
#  2. what data to plot (e.g., what variables are your x and y values?)
#  3. what extra layers do you want to add (e.g., a regression line)
# After you tell ggplot one thing about what you want your plot to 
# look like, if you put a + at the end of the line it knows that you
# have more information to give it about the same plot. You can add as
# many layers to your plotting command as you'd like as long as you end
# each line with a + (except the last line).

# For example, to plot a scatterplot of age and birthyear, you would use:

ggplot(TDM, aes(x=birthyear, y=age)) +
  geom_point(shape=1)  +
  bwtheme

# The ggplot() command defines the dataframe (TDM) and the "aesthetics"
# (the x and y variables you want to use). The geom_point() command
# tells ggplot you want to graph points. Shape=1 tells ggplot to use open
# circles for each point. You can experiment with different shapes by
# changing the number, if you'd like.

# One useful thing to add to a scatterplot is a linear regression line.
# (The correlation between x and y is the same as a linear regression
# with only one predictor variable.) We'll do this with geom_smooth().

ggplot(TDM, aes(x=birthyear, y=age)) +
  geom_point(shape=1)  +
  bwtheme +
  stat_smooth(method=lm)  

# By default, stat_smooth will graph the 95% confidence interval (CI)
# for your regression line. If you want to omit that line, add se=FALSE
# inside the stat_smooth command, like this: stat_smooth(method=lm, se=FALSE)

# Above, you found the correlation between regret and maximizing. Let's
# graph that now. We'll Add a title by adding an additional layer in our 
# ggplot command, and we'll also edit the x and y axis labels so that 
# they're a little more informative than our shorthand variable names.

ggplot(TDM, aes(x=maxi_total, y=regret_total)) +
  geom_point(shape=1)  +
  bwtheme +
  stat_smooth(method=lm)  +
  ggtitle("Regret as a Function of Maximizing Tendency") + # adds the title
  xlab("tendency to maximize") +
  ylab("tendency toward regret")


# 10. 
# Create one more figure that shows the relationship between two continuous
# variables (or any variables that aren't categorical). 
# Make sure your figure has a title, and if necessary, change the labels on
# each axis so that someone not familiar with our variable names would
# understand what the figure represents. You can copy and paste code from
# the previous sections, above, but remember to change the variable names
# as needed.



# 11. Now let's make a boxplot, which is the best way to illustrate the
# means of more than one category (e.g., the two means you're comparing with
# your t-test) as well as the variability within each sample. We'll graph
# this in the same way as we made the scatterplot, just swapping geom_point()
# for geom_boxplot().

ggplot(TDM, aes(x=handed, y=age)) +
  geom_boxplot() +
  bwtheme  

# If you want to add the points over the boxplots (a good habit, so that your
# reader can see where the individual values fall, in addition to the summary
# statistics), you can add the   geom_point(size = 3, alpha = .5). The alpha
# value is opacity (transparency), where higher values are more opaque and 
# lower values are more transparent.

ggplot(TDM, aes(x=handed, y=age)) +
  geom_boxplot() +
  geom_point(size = 3, alpha = .3) +
  bwtheme  

# If you want to change the order of the x-axis labels, or change their
# text, use various commands within scale_x_discrete():

ggplot(TDM, aes(x=handed, y=age)) +
  geom_boxplot() +
  geom_point(size = 3, alpha = .3) +
  bwtheme   +
  scale_x_discrete(limits=c("L","R","A"), # limits re-orders the three bars
                   labels=c("Left", "Right", "Ambi")) # labels changes text

# Finally, if making the points transparent doesn't solve the problem of 
# telling overlapping points apart, you can "jitter" the location of each point
# horizontally by using geom_jitter() in place of geom_point(). Below, the
# geom_point() line has been commented out so it won't run. If you switch the #
# to be in front of the geom_jitter() line instead, you'll see your partially
# transparent points again. Since both of these commands alter the way points 
# are plotted by ggplot, you should only use one at a time:

ggplot(TDM, aes(x=handed, y=age)) +
  geom_boxplot() +
  #geom_point(size = 3, alpha = .3) +
  geom_jitter(position=position_jitter(width=.1, height=0)) +
  bwtheme   +
  scale_x_discrete(limits=c("L","R","A"),
                   labels=c("Left", "Right", "Ambi")) 
  

# Now, please create one new box plot that shows any of our DVs as a function
# of one of our categorical variables.


# 12. STILL SUPER IMPORTANT final step: save your file. Go to File -> Save as...
# and save this R script with a NEW FILENAME that includes your own name, e.g.
# R_Project_2_Hale_Forster.R or R_Project_2_Maneeza_Dawood.R

# To get credit for this assignment, upload your completed and re-named file
# to the Assignments section of Canvas for UN1490. Make sure that
# this file contains both your added code (added in between lines of comment
# text throughout) and your answers to the questions marked with *s throughout.
# Your TA will change the working directory in your script file to theirs, 
# and run the rest of your code as you have left it in the file, so everything
# that you have added that is not preceeded by a # should be correct code!




