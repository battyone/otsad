% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetDetectorScore.R
\name{GetDetectorScore}
\alias{GetDetectorScore}
\title{Get detector score}
\usage{
GetDetectorScore(data, print = FALSE, title = "")
}
\arguments{
\item{data}{All dataset with training and test datasets and with at least \code{timestamp},
\code{value}, \code{is.anomaly} and \code{is.real.anomaly} columns.}

\item{print}{If TRUE shows a graph with results.}

\item{title}{Title of the graph.}
}
\value{
List conformed by the following items:
  \item{data}{Same data set with additional columns such as \code{label}, \code{start.limit},
  \code{end.limit}, \code{standard.score} and etc.}
  \item{standard}{Total score obtained by the detector using the weights of the
  standard profile.}
  \item{low_FP_rate}{Total score obtained by the detector using the weights of the
  reward_low_FP_rate profile.}
  \item{low_FN_rate}{Total score obtained by the detector using the weights of the
  reward_low_FN_rate profile.}
  \item{tp}{Number of true positives}
  \item{tn}{Number of true negatives}
  \item{fp}{Number of false positives}
  \item{fn}{Number of false negatives}
}
\description{
\code{GetDetectorScore} Calculates the start and end positions of each window that
are focused on the real anomalies. This windows can be used to know if the detected anomaly is a
true positive or not.
}
\details{
\code{data} must be a data.frame with  \code{timestamp}, \code{value}, \code{is.anomaly}
and \code{is.real.anomaly} columns. \code{timestamp} column can be numeric, of type POSIXct, or a
character type date convertible to POSIXct.

This function calculates the scores based on three different profiles. Each label tp, fp, tn,
fn is associated with a weight to give a more realistic score.
For the standard profile weights are tp = 1, tn = 1, fp, = 0.11, and fn = 1.
For the reward_low_FP_rate profile weights are tp = 1, tn = 1, fp, = 0.22, and fn = 1.
For the reward_low_FN_rate profile weights are tp = 1, tn = 1, fp, = 0.11, and fn = 2.
}
\examples{
## Generate data
set.seed(100)
n <- 180
x <- sample(1:100, n, replace = TRUE)
x[70:90] <- sample(110:115, 21, replace = TRUE)
x[25] <- 200
x[150] <- 170
df <- data.frame(timestamp = 1:n, value = x)

# Add is.real.anomaly column
df$is.real.anomaly <- 0
df[c(25,80,150), "is.real.anomaly"] <- 1

## Calculate anomalies
result <- CpSdEwma(
  data = df$value,
  n.train = 5,
  threshold = 0.01,
  l = 3
)
res <- cbind(df, result)

# Get detector score
GetDetectorScore(res, print = FALSE, title = "")
}
\references{
A. Lavin and S. Ahmad, “Evaluating Real-time Anomaly Detection Algorithms – the
  Numenta Anomaly Benchmark,” in 14th International Conference on Machine Learning and
  Applications (IEEE ICMLA’15), 2015.
}
