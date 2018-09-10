# Put custom tests in this file.
      
      # Uncommenting the following line of code will disable
      # auto-detection of new variables and thus prevent swirl from
      # executing every command twice, which can slow things down.
      
      # AUTO_DETECT_NEWVAR <- FALSE
      
      # However, this means that you should detect user-created
      # variables when appropriate. The answer test, creates_new_var()
      # can be used for for the purpose, but it also re-evaluates the
      # expression which the user entered, so care must be taken.

# For checking that calls contain various operators
# but that aren't called as FUN()
# e.g. $, [], using regexp on the expr as text
# swirl's base answer testing functions appear to call the last-entered expr
# from the stack INSIDE the answer test, not feeding it in as an arg
# pattern: regexp string, inherits from grepl's pattern arg

expr_grepl <- function (pattern) {
  this_expr <- environment(sys.function(1))$e$expr
  test <- grepl(pattern, rlang::expr_name(this_expr))
  return (test)
}

# For checking that the result of a call has a certain data type
# type: string which has an "is.*()" type checking function in base R

result_has_type <- function (type) {
  # check that type is valid. It better be because this is only for internal use
  if (!exists(paste0("is.", type))) return (FALSE)
  test <- do.call(paste0("is.", type), arg = list(environment(sys.function(1))$e$val))
  return (test)
}

# For checking that the result of a call is "approximately" equal to some value
# Rounds the result to specified digits and then checks for equality with test value

val_rounded_equals <- function (value, digits = 0) {
  test <- round(environment(sys.function(1))$e$val, digits = digits) == value
  if (is.na(test)) return (FALSE)
  return (test)
}

# From Nick Carchedi's R Programming Alt swirl course
# Sends an email to a desired instructor.
# Slightly modified to allow sending to specific TAs by multiple choice

notify <- function() {
  e <- get("e", parent.frame())
  
  if (e$val == "Jonathan") {
    address <- "jonathan.nicholas@columbia.edu"
  } else if (e$val == "Maneeza") {
    address <- "md2811@columbia.edu"
  } else if (e$val == "Monica") {
    address <- "monica.thieu@columbia.edu"
  }
  
  good <- FALSE
  while(!good) {
    # Get info
    name <- readline_clean("What is your UNI? ")
    
    # Repeat back to them
    message("\nDoes this look correct?\n")
    message("Your name: ", name, "\n", "Send to: ", address)
    
    yn <- select.list(c("Yes", "No"), graphics = FALSE)
    if(yn == "Yes") good <- TRUE
  }
  
  # Get course and lesson names
  course_name <- attr(e$les, "course_name")
  lesson_name <- attr(e$les, "lesson_name")
  
  subject <- paste(name, "just completed", course_name, "-", lesson_name)
  # This is where we'd be able to implement something of a student-specific key.
  # The trouble here is that all of these files would be in the swirl course so
  # enterprising students could sneak in and grab their own key. Gotta check
  body = ""
  
  # Send email
  swirl:::email(address, subject, body)
  
  hrule()
  message("I just tried to create a new email with the following info:\n")
  message("To: ", address)
  message("Subject: ", subject)
  message("Body: <empty>")
  
  message("\nIf it didn't work, you can send the same email manually.")
  hrule()
  
  # Return TRUE to satisfy swirl and return to course menu
  TRUE
}

# Helper fuction for email

readline_clean <- function(prompt = "") {
  wrapped <- strwrap(prompt, width = getOption("width") - 2)
  mes <- stringr::str_c("| ", wrapped, collapse = "\n")
  message(mes)
  readline()
}

# Helper function for email

hrule <- function() {
  message("\n", paste0(rep("#", getOption("width") - 2), collapse = ""), "\n")
}
