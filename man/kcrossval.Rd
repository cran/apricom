% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/kcrossval.R
\name{kcrossval}
\alias{kcrossval}
\title{Cross-validation-derived Shrinkage After Estimation}
\usage{
kcrossval(dataset, model, k, nreps, sdm, int = TRUE, int.adj)
}
\arguments{
\item{dataset}{a dataset for regression analysis. Data should be in the form
of a matrix, with the outcome variable as the final column. Application of the
\code{\link{datashape}} function beforehand is recommended, especially if
 categorical predictors are present. For regression with an intercept included
 a column vector of 1s should be included before the dataset (see examples)}

\item{model}{type of regression model. Either "linear" or "logistic".}

\item{k}{the number of cross-validation folds. This number must be within
the range 1 < k <= 0.5 * number of observations}

\item{nreps}{the number of times to replicate the cross-validation process.}

\item{sdm}{a shrinkage design matrix. For examples, see \code{\link{ols.shrink}}}

\item{int}{logical. If TRUE the model will include a
regression intercept.}

\item{int.adj}{logical. If TRUE the regression intercept will be
re-estimated after shrinkage of the regression coefficients.}
}
\value{
\code{kcrossval} returns a list containing the following:

\item{raw.coeff}{the raw regression model coefficients,
              pre-shrinkage.}

\item{shrunk.coeff}{the shrunken regression model coefficients.}

\item{lambda}{the mean shrinkage factor over nreps
              cross-validation replicates.}

\item{nFolds}{the number of cross-validation folds.}

\item{nreps}{the number of cross-validation replicates.}

\item{sdm}{the shrinkage design matrix used to apply
             the shrinkage factor(s) to the regression coefficients.}
}
\description{
Shrink regression coefficients using a Cross-validation-derived
shrinkage factor.
}
\details{
This function applies k-fold cross-validation to a dataset in order to
derive a shrinkage factor and apply it to the regression coefficients.
Data is randomly partitioned into k equally sized sets. One set is used as a
validation set, while the remaining data is used as a training set. Regression
coefficients are estimated in the training set, and then a shrinkage factor
is estimated using the validation set. This process is repeated so that each
partitioned set is used as the validation set once, resulting in k folds.
The mean of k shrinkage factors is then applied to the original
regression coeffients, and the regression intercept may be re-estimated.
This process is repeated nreps times and the mean of the regression
coefficients is returned.

This process can currently be applied to linear or logistic regression models.
}
\examples{
## Example 1: Linear regression using the iris dataset
## 2-fold Cross-validation-derived shrinkage with 50 reps
data(iris)
iris.data <- as.matrix(iris[, 1:4])
iris.data <- cbind(1, iris.data)
sdm1 <- matrix(c(0, 1, 1, 1), nrow = 1)
kcrossval(dataset = iris.data, model = "linear", k = 2,
nreps = 50, sdm = sdm1, int = TRUE, int.adj = TRUE)

## Example 2: logistic regression using a subset of the mtcars data
## 10-fold CV-derived shrinkage (uniform shrinkage and intercept re-estimation)
data(mtcars)
mtc.data <- cbind(1,datashape(mtcars, y = 8, x = c(1, 6, 9)))
head(mtc.data)
set.seed(321)
kcrossval(dataset = mtc.data, model = "logistic",
k = 10, nreps = 10)
}

