##################################################################
##################### UN1490 Assignment 1: R #####################
##################### Assigned: 9/11 #############################
##################### Due: 9/18 before class #####################
##################################################################

#### 0. ####
# Any text after a # is not read by R until a carriage return.
#	(a carriage return is a new line)
# so if you want to make notes for yourself, put them after a #.
# RStudio shows this kind of "comment text" in green.
# Tip: To comment multiple lines of code, highlight them and type ctrl[/command] + shift + C.
# Anything that's on its own (un-commented) line will get run.

# Try running a command:
#   a. below this line, type an equation (e.g., 1+3).
#   b. highlight the equation, and tell RStudio to run it
#      by hitting command+return (mac) or ctrl+enter (PC).
#   c. You should see the equation come up in the Console below (>1+3)
#      followed by a line with the reponse ([1] 4).
#   d. What happens if you type 1+3= and try to run that?
#      If you see a + in the bottom line on the console, R is waiting for
#      additional commands (your command wasn't complete). 
#   e. If you find yourself stuck with a + rather than a > in the command
#      line of the Console, click on the cursor there, type any letter/number,
#      and hit enter/return. This should give you an error, but restore the >.

# Note: it can be easy to get a little lost in all this comment text and
# lines of code. We've tried to help a little by starring (*) the places where
# you need to add something to this file: either writing a new line of code,
# or answering a question by adding your own comment line (remember to start it
# with a hash symbol like this paragraph, or R will think it's a command and
# get confused!).

#### 1. ####
# First we want to tell R where to find the data files we'll be using.
# Use the drop-down menu to change your working directory:
#	Session -> Set Working Directory -> Choose Directory... 
#	Find and select the folder in which you'll be saving all of your R
# assignments for this class.


# Optional: You can also create an R project file to use for this class. 
# An R project saves your working directory, history, environment, and the files 
# you have open all in one place, making it easy to resume where you left off.
# To create an R project, go to File --> New project, and create a new project in an existing directory
# Select the directory where you plan to store all your files for this course.


#### 2. ####
# Ask R 'what is the current working directory?' with getwd():
# * Type the command getwd() on the line below this, highlight it, and run it.

#### 3. ####
# * Copy and paste R's response to your getwd() query into setwd() below, for 
#	future use (paste it inside the quotation marks).
# Then use getwd() to check that your command worked correctly.

setwd("~/COLUMBIA/01_TEACHING/UN1490/R/")
getwd()


#### 4. ####
# Before working with data, we need to read it into R's environment.

# Read in our class dataset.
#    a. First, make sure that the dataset is saved in the right place.
#       (it should be in the same directory you set above)
#       (it should be in .csv format)
#    b. Now, read in the file using the read.csv() command below.
#       (the read.csv() command pulls the data from the file)
#       (the TDM <- part of this line assigns that dataset to the label TDM)
#       (R is case sensitive. Our convention will be to label data frames 
#       with capital letters, and variables in lowercase)

TDM <- read.csv("classdata_2017.csv")


#### 5. #### 
# Functions that help you check that the data read in correctly: 
#	str, head, dim, names, class, summary
# Run each of these commands (the first command is below as an example).
# With your TA, walk through what each one tells you. 
# * Write your notes in comment text (after a #) below:

str(TDM) #stands for structure - we'll talk about types of data later in this class
        # This shows you:
        #   the type of object that TDM is, 
        #   the number of observations and number of variables (dimensions) of TDM 
        #   a list of each variable and its class (TDMerval, factor, numeric, etc.) 
        #   for each variable, a list of all values

# Access R's help menu for information about a function: ?functionname
?class

#### 6. ####
# Find out what objects are in your working environment with objects()
objects()

#### 7. ####
# Remove all objects from your working environment with  rm(list=ls(all=TRUE))
#	   After you run this command, check objects() again: what does it say?
#	   Re-read in the class data (see Step 4 if you need a refresher).
rm(list=ls(all=TRUE))

#### 8. ####
# TDM is a dataframe object in the working environment, but how do you
#	access the variables within that dataframe?  For example if you wanted
#	to make a histogram of the age variable, what would you do? 
#     a. To access objects within other objects (e.g. variables within 
#	        dataframes), you use the $ as you would / \ for webpages within 
#	        a website or file locations, so hist(TDM$age) tells R to make a 
#	        histogram of the age variable within the TDM dataframe.
#     b. Use the functions from step 5 to find two numerical variables in your dataset.
#     c. * Make histograms of two numerical variables using hist(). 
#        (What happens if you try to make a histogram of a non-numerical variable?)
#     c. * Use summary() on two different types of variables. What does it tell you?
#     d. * Use mean() to find the mean age.
#        Why does it say NA? This means "not available." R is telling you it can't
#        compute a mean. Often, this happens when you have one or more missing values.
#        Look at the dataset (click on TDM in the Data box on the right): you will
#        find at least one value in the age column entered as NA.
#        ...So how do you find the mean? Tell R to ignore values of NA by editing the 
#        mean() command using na.rm (NA remove): mean(TDM$age, na.rm=TRUE)


#### 9. ####
# Sometimes we want to know, e.g., the mean age of just the post-bacs in the class.
# To access a subset of the data, there are several options, but one option is 
#	to use the square brackets after the data to be subset. Try each of these:

#	TDM[TDM$class == "Post-bac", ] returns all columns for when class year is Post-bac
#                         (note: == means "is defined as")
#                         (note: for factor variables you need to use quotes)
#                         (note: for numeric variables you don't need quotes)

#	TDM[23, ] returns all columns for the 23rd row (when row is 23)
#	TDM[12 , 4] returns the 12th row, fourth column
#	TDM[ , 1] returns all the rows of the first column 
#	TDM$id also returns all the rows of the first column

#	TDM$class[TDM$age > 21] returns class scores for all Ps where age > 21

# So the square brackets say Dataframe[which rows, which columns] 
#	or Dataframe$variable[which rows].  If you don't specify which rows
#	(or which columns), R assumes you want them all.

#### 10. ####
# Now it's your turn to write some commands to compute various descriptive
# statistics on our class dataset. For each of the questions below, add a line
# with the appropriate code to compute the answer, and add the answer itself in
# a commented line after the code. 

#   a. * What is the mean number of Psychology classes taken by our Ps? 

#   b. * How many students are ambidextrous? How many are left-handed?

#   c. * What is the mean age of the seniors? Mean age of the juniors? 
#      Mean age of the post-bacs? Mean age of the sophomores?


#### 11. ####
# You can create new variables by combining existing ones. We'll calculate
# each P's score on a "Regret Scale" (Schwartz et al., 2002) by averaging the 
# scores on each of 5 different questions: regret1, regret2, regret3, regret4, 
# and regret5. (Note that when we cleaned this data file we already reverse-coded
# regret5 for you.)

# We can calculate the mean regret score for each P by literally adding the
# five regret variables together and dividing by 5, like this: 

(TDM$regret1 + TDM$regret2 + TDM$regret3 + TDM$regret4 + TDM$regret5)/5

# But we want to save this calculation as a new variable. Assign your 
# calculation to the variable regret_total by using the <- command:

TDM$regret_total <- (TDM$regret1 + TDM$regret2 + TDM$regret3 + TDM$regret4 + TDM$regret5)/5

# * Now re-run names() on the TDM dataframe to check that your new variable is there.

# * What is the mean regret score for the class?

# * What is the mean regret score for students over 21 years of age?


#### 12. ####
# SUPER IMPORTANT final step: save your file. Go to File -> Save as...
# and save this R script with a NEW FILENAME that includes your own name, e.g.
# R_Project_1_Hale_Forster.R or R_Project_1_Maneeza_Dawood.R

# To get credit for this assignment, upload your completed and re-named file
# to the Assignments section of Canvas for UN1491 (NOT the main class). This 
# will help your TAs keep track of their own students' work. Make sure that
# this file contains both your added code (added in between lines of comment
# text throughout) and your answers to the questions marked with *s throughout.
# Your TA will change the working directory in your script file to theirs, 
# and run the rest of your code as you have left it in the file, so everything
# that you have added that is not preceeded by a # should be correct code!




