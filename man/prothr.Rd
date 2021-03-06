\name{Liver cirrhosis data}

\docType{data}

\alias{prothr}

\title{Abnormal prothrombin levels in liver cirrhosis}

\description{A data frame of 488 liver cirrhosis patients from a randomized
clinical trial concerning prednisone treatment in these patients.
The dataset is in long format. The included variables are
  \describe{
  \item{id}{Patient identification number}
  \item{from}{Starting state}
  \item{to}{Receiving state}
  \item{trans}{Transition number}
  \item{Tstart}{Starting time}
  \item{Tstop}{Transition time}
  \item{status}{Status variable; 1=transition, 0=censored}
  \item{treat}{Treatment; factor with levels "Placebo", "Prednisone"}
  }
}

\usage{data(prothr)}

\format{A data frame, see \code{\link{data.frame}}.}

\details{This data was kindly provided by Per Kragh Andersen. It was
introduced in Andersen, Borgan, Gill & Keiding (1993), Example 1.3.12,
and used as illustration for computation of transition probabilities
in multi-state models, see Sections IV.4 (Example IV.4.4) and VII.2
(Example VII.2.10).}

\references{
Andersen PK, Borgan O, Gill RD, Keiding N (1993). \emph{Statistical Models
Based on Counting Processes}. Springer, New York.
}

\keyword{datasets}
