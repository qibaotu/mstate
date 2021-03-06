\name{plot.msfit}
\alias{plot.msfit}
\title{Plot method for an msfit object}
\description{
Plot method for an object of class 'msfit'. It plots the estimated
cumulative transition intensities in the multi-state model.}
\usage{
\S3method{plot}{msfit}(x, type=c("single", "separate"), cols,
    xlab="Time", ylab="Cumulative hazard", ylim, lwd, lty,
    legend, legend.pos, bty="n", ...)
}
\arguments{
  \item{x}{Object of class 'msfit', containing estimated cumulative
  transition intensities for all transitions in a multi-state model}
  \item{type}{One of \code{"single"} (default) or \code{"separate"}; in
  case of \code{"single"}, all estimated cumulative hazards are drawn
  in a single plot, in case of \code{"separate"}, separate plots are
  shown for the estimated transition intensities}
  \item{cols}{A vector specifying colors for the different transitions;
  default is 1:K (K no of transitions), when type=\code{"single"}, and
  1 (black), when type=\code{"separate"}}
  \item{xlab}{A title for the x-axis; default is \code{"Time"}}
  \item{ylab}{A title for the y-axis; default is
  \code{"Cumulative hazard"}}
  \item{ylim}{The y limits of the plot(s); if ylim is specified for
  type="separate", then all plots use the same ylim for y limits}
  \item{lwd}{The line width, see \code{\link{par}}; default is 1}
  \item{lty}{The line type, see \code{\link{par}}; default is 1}
  \item{legend}{Character vector of length equal to the number of
  transitions, to be used in a legend; if missing, these will be taken
  from the row- and column-names of the transition matrix contained in
  \code{x$trans}. Also used as titles of plots for type=\code{"separate"}}
  \item{legend.pos}{The position of the legend, see \code{\link{legend}};
  default is \code{"topleft"}}
  \item{bty}{The box type of the legend, see \code{\link{legend}}}
  \item{\dots}{Further arguments to plot}
}
\value{No return value}
\seealso{\code{\link{msfit}}}
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
msf <- msfit(cx,newdata,trans=tmat)
# standard plot
plot(msf)
# specifying line width, color, and legend
plot(msf,lwd=2,col=c("darkgreen","darkblue","darkred"),legend=c("1->2","1->3","2->3"))
# separate plots
par(mfrow=c(2,2))
plot(msf,type="sep",lwd=2)
par(mfrow=c(1,1))
}
\keyword{hplot}
