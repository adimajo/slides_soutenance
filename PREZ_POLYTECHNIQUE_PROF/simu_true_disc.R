##############################
####### Adrien Ehrhardt ######
##############################
#### Simulations COMPSTAT ####
##############################

# Outils

library(glmdisc)
library(tikzDevice)
library(xtable)
library(dplyr)
setwd("Z:/6D1/329/Thèse CIFRE SCORING/ADRIEN/LaTeX/PREZ_COMPSTAT")

# Simulation des données

generate_data <- function(k,n) {
  set.seed(k)
  x = matrix(runif(2*n), nrow = n, ncol = 2)

  log_odd = sin((x[,1]-0.7)*7)
  y = rbinom(n,1,1/(1+exp(-log_odd)))
  return(list(x=x,y=y,log_odd=log_odd))
}

# Figure vraie distribution

list2env(generate_data(1,5000),env=environment())

tikz(file = 'true_data_plot.tex', width = 8, height = 3.2)
plot(sort(x[,1]),sin((sort(x[,1])-0.7)*7), type="l", xlab = "x", ylab = "logit(p(1|x))", col = "green", lwd=2)
legend(0.3,1,c("True distribution"), lty=1,col = "green", lwd=2)
dev.off()

# Figure régression logistique linéaire

coeff_x_1 = glm(y~V1, data=data.frame(cbind(x,y)),family=binomial(link="logit"))$coefficients[c("(Intercept)","V1")]

tikz(file = 'linear_plot.tex', width = 8, height = 3.2, engine="pdftex")
plot(sort(x[,1]),sin((sort(x[,1])-0.7)*7), type="l", xlab = "x", ylab = "logit(p(1|x))", col = "green", lwd=2)
lines(sort(x[,1]),(coeff_x_1["(Intercept)"]+coeff_x_1["V1"]*x[,1])[order(x[,1])], type="l", col = "red", lwd=2)
legend(0.3,1,c("True distribution","Linear logistic regression"), lty=1,col = c("green","red"), lwd=2)
dev.off()

# Figure régression logistique discrète mal choisie

library(infotheo)

x_disc = discretize(x[,1], disc="equalfreq")

coeff_x_disc = glm(y~., data=data.frame(x=factor(x_disc[,1]),y),family=binomial(link="logit"))

intervals = confint(coeff_x_disc)

coeff_x_disc_low = summary(coeff_x_disc)$coefficients[,1]+1.96*summary(coeff_x_disc)$coefficients[,2]

coeff_x_disc_high = summary(coeff_x_disc)$coefficients[,1]-1.96*summary(coeff_x_disc)$coefficients[,2]

coeff_x_disc = coeff_x_disc$coefficients

pred = matrix(NA,5000)
predlow = matrix(NA,5000)
predhigh = matrix(NA,5000)

for (k in (1:nlevels(factor(x_disc[,1])))) {
  pred[factor(x_disc[,1]) == levels(factor(x_disc[,1]))[k],1] = coeff_x_disc[k]
  predlow[factor(x_disc[,1]) == levels(factor(x_disc[,1]))[k],1] = coeff_x_disc_low[k]
  predhigh[factor(x_disc[,1]) == levels(factor(x_disc[,1]))[k],1] = coeff_x_disc_high[k]
}

redtrans <- rgb(255, 0, 0, 127, maxColorValue=255) 

tikz(file = 'bad_disc_plot.tex', width = 8, height = 3.2, engine="pdftex")
plot(sort(x[,1]),sin((sort(x[,1])-0.7)*7), type="l", xlab = "x", ylab = "logit(p(1|x))", col = "green", lwd=2)
lines(sort(x[,1]), (coeff_x_disc["(Intercept)"] + pred)[order(x[,1])], col = "red", lwd=2)
polygon(c(sort(x[,1]), rev(sort(x[,1]))), c((coeff_x_disc_low["(Intercept)"] + predlow)[order(x[,1])], (coeff_x_disc_high["(Intercept)"] + predhigh)[order(x[,1])]),
        col=redtrans, border = NA)
legend(0.3,1,c("True distribution","Bad discretization"), lty=c(1,1),col =c("green","red"), lwd=2)
dev.off()



# Figure régression logistique discrète bien choisie

library(glmdisc)

disc = glmdisc(x,y,interact=FALSE,test=FALSE,validation=FALSE,criterion = "bic", iter=300, m_start=3)

coeff_x_disc = glm(y~., data=data.frame(x=factor(disc@disc.data[,1]),y=disc@disc.data[,3]),family=binomial(link="logit"))

intervals = confint.default(coeff_x_disc)

coeff_x_disc_low = summary(coeff_x_disc)$coefficients[,1]+1.96*summary(coeff_x_disc)$coefficients[,2]

coeff_x_disc_high = summary(coeff_x_disc)$coefficients[,1]-1.96*summary(coeff_x_disc)$coefficients[,2]

coeff_x_disc = coeff_x_disc$coefficients

pred = matrix(NA,5000)
predlow = matrix(NA,5000)
predhigh = matrix(NA,5000)

for (k in (1:nlevels(factor(disc@disc.data[,1])))) {
  pred[factor(disc@disc.data[,1]) == levels(factor(disc@disc.data[,1]))[k],1] = coeff_x_disc[k]
  predlow[factor(disc@disc.data[,1]) == levels(factor(disc@disc.data[,1]))[k],1] = coeff_x_disc_low[k]
  predhigh[factor(disc@disc.data[,1]) == levels(factor(disc@disc.data[,1]))[k],1] = coeff_x_disc_high[k]
}



x_lims = sort(aggregate(cont ~ disc, data.frame(disc=disc@disc.data[,1],cont=disc@cont.data[,1]), max)$cont)

x_lims = x_lims[-length(x_lims)]

x_lims = as.vector(sapply(x_lims, function(x) rep(x,2)))

x_lims = c(0,x_lims,1)

yhigh = as.vector(sapply(as.numeric(as.character(levels(as.factor((coeff_x_disc_high["(Intercept)"] + predhigh)[order(disc@cont.data[,1])])))), function(x) rep(x,2)))

ylow = as.vector(sapply(as.numeric(as.character(levels(as.factor((coeff_x_disc_low["(Intercept)"] + predlow)[order(disc@cont.data[,1])])))), function(x) rep(x,2)))

bluetrans <- rgb(0, 0, 255, 127, maxColorValue=255) 


tikz(file = 'good_disc_plot.tex', width = 8, height = 3.2, engine="pdftex")
plot(sort(x[,1]),sin((sort(x[,1])-0.7)*7), type="l", xlab = "x", ylab = "logit(p(1|x))",col = "green", lwd=2)
lines(sort(disc@cont.data[,1]), (coeff_x_disc["(Intercept)"] + pred)[order(disc@cont.data[,1])], col = "blue", lwd=2)
polygon(c(x_lims,rev(x_lims)), c(ylow[c(5,6,1,2,3,4)],rev(yhigh[c(5,6,1,2,3,4)])),
        col=bluetrans, border = NA)
legend(0.3,1,c("True distribution","Good discretization"), lty=c(1,1),col = c("green","blue"), lwd=2)
dev.off()


