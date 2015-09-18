# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Name of QuantLet : MVAsimcidif
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Published in : Applied Multivariate Statistical Analysis
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Description : Tests the equality of 2 groups of US Company 
# data. It computes the F-statistic and the critical value 
# of the test and the simultaneous confidence intervals.
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Keywords : F-statistic, critical value, confidence-interval,
# mean, covariance, multivariate
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# See also : 
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Author : Awdesch Melzer, Vladimir Georgescu, Song Song
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Submitted : Wed, March 14 2012 by Dedy Dwi Prastyo
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
# Datafile : uscomp2.dat
# −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−

rm(list=ls(all=TRUE))
graphics.off()

# Load data
x = read.table("uscomp2.dat")
y = data.frame(x)

# Create subsets for Energy and Manufacturing
yE = subset(y, y$V8 == "Energy")
yM = subset(y, y$V8 == "Manufacturing")

# Calculate means of groups
exE = cbind(apply(yE[, 2:3], 2, mean))
exM = cbind(apply(yM[, 2:3], 2, mean))

print('Mean group Energy of assets (V2) and sales (V3)')
exE

print('Mean group Manufacturing of assets (V2) and sales (V3)')
exM

# Estimating variance of the groups
# observations within the groups and overall
nE = length(yE[, 1])
nM = length(yM[, 1])
n = nE + nM

# number of groups
p = length(exE)

sE = ((nE - 1)/ nE) * cov(yE[, 2:3])
sM = ((nM - 1)/ nM) * cov(yM[, 2:3])

s = (nE * sE + nM * sM)/ (nE + nM)
sinv = solve(s)
k = nE * nM * (n - p - 1)/ (p * (n^2))

# Computing the test statistic
f = k * t(exE - exM)%*%sinv%*%(exE - exM)
f

# Computing the critical value
critvalue = qf(1 - 0.05, 2, 22)
critvalue

#Computes the simultaneous confidence intervals
deltau = (exE - exM) + sqrt(qf(1 - 0.05, p, n - p - 1) * (1/ k) * diag(s))
deltal = (exE - exM) - sqrt(qf(1 - 0.05, p, n - p - 1) * (1/ k) * diag(s))

confit = cbind(deltal, deltau)
confit
