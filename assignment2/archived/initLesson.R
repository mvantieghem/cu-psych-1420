# Code placed in this file fill be executed every time the
      # lesson is started. Any variables created here will show up in
      # the user's working directory and thus be accessible to them
      # throughout the lesson.

if (!require(knitr)) {
  install.packages(knitr)
}

if (!require(ggplot2)) {
  install.packages(ggplot2)
} else {
  require(ggplot2)
}