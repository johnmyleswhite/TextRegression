# Introduction
This repository contains the development version of the TextRegression
package, which makes it easy to predict continuous outputs using text inputs.
To get started, install the package using the instructions immediately below.
Then you can try out the examples later on to learn how to use the package
to solve your text analysis problems.

Be warned: text regression can take a while, because the data needs to be
resampled to set the hyperparameters used in the final regression analysis.

# Installation
Use the code below inside an R session to install the TextRegression package:

    install.packages('devtools')
    library('devtools')
    install_github('TextRegression', username = 'johnmyleswhite')

# Examples
Try out this toy example to see how to perform a text regression:

    library('TextRegression')
    
    text <- c('saying text is good',
              'saying text once and saying text twice is better',
              'saying text text text is best',
              'saying text once is still ok',
              'not saying it at all is bad',
              'because text is a good thing',
              'we all like text',
              'even though sometimes it is missing')
    
    y <- c(1, 2, 3, 1, 0, 1, 1, 0)
    
    results <- regress.text(text, y)
    
    print(results)
