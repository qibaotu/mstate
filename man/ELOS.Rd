\name{ELOS}
\alias{ELOS}
\title{Expected length of stay}
\description{
Given a \code{"probtrans"} object, ELOS calculates the (restricted)
expected length of stay in each of the states of the multi-state model.
}
\usage{ELOS(pt, tau)}
\arguments{
  \item{pt}{An object of class \code{"probtrans"}}
  \item{tau}{The horizon until which ELOS is calculated; if missing, the
  maximum of the observed transition times is taken}
}
\details{
The object \code{pt} needs to be a \code{"probtrans"} object, obtained
with forward prediction (the default, \code{direction}=\code{"forward"}, 
in the call to \code{\link{probtrans}}). The restriction to \code{tau} is
there because, as in ordinary survival analysis, the probability of being
in a state can be positive until infinity, resulting in infinite values.
The (restricted, until tau) expected length of stay in state h, given in
state g at time s, is given by the integral from s to tau of P_{gh}(s,t),
see for instance Beyersmann and Putter (2014).
}
\value{
A K x K matrix (with K number of states), with the (g,h)'th element
containing E_{gh}(s,tau). The starting time point s is inferred from
\code{pt} (the smallest time point, should be equal to the \code{predt}
value in the call to \code{\link{probtrans}}. The row- and column names
of the matrix have been named "from1" until "fromK" and "in1" until "inK",
respectively.
}
\author{Hein Putter \email{H.Putter@lumc.nl}}
\examples{
# transition matrix for illness-death model
tmat <- trans.illdeath()
# data in wide format, for transition 1 this is dataset E1 of
# Therneau & Grambsch (2000)
tg <- data.frame(illt=c(1,1,6,6,8,9),ills=c(1,0,1,1,0,1),
        dt=c(5,1,9,7,8,12),ds=c(1,1,1,1,1,1),
        x1=c(1,1,1,0,0,0),x2=c(6:1))
# data in long format using msprep
tglong <- msprep(time=c(NA,"illt","dt"),status=c(NA,"ills","ds"),
		data=tg,keep=c("x1","x2"),trans=tmat)
# events
events(tglong)
table(tglong$status,tglong$to,tglong$from)
# expanded covariates
tglong <- expand.covs(tglong,c("x1","x2"))
# Cox model with different covariate
cx <- coxph(Surv(Tstart,Tstop,status)~x1.1+x2.2+strata(trans),
        data=tglong,method="breslow")
summary(cx)
# new data, to check whether results are the same for transition 1 as
# those in appendix E.1 of Therneau & Grambsch (2000)
newdata <- data.frame(trans=1:3,x1.1=c(0,0,0),x2.2=c(0,1,0),strata=1:3)
HvH <- msfit(cx,newdata,trans=tmat)
# probtrans
pt <- probtrans(HvH,predt=0)
# ELOS until last observed time point
ELOS(pt)
# Restricted ELOS until tau=10
ELOS(pt, tau=10)
}
\keyword{univar}
