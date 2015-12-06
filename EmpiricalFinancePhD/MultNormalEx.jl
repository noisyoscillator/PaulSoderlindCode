#------------------------------------------------------------------------------
#  MultNormalEx.jl
#
#
#
#
#
#
#
#
#
#
#
#
#
#  Paul.Soderlind@unisg.ch   Oct 2015
#------------------------------------------------------------------------------


mu = [-1 10]               #means of two series
V  = [1   0.5;               #covariance matrix of two series
      0.5 2  ]

T = 1000

P = chol(V)
X = repmat(mu,T,1) + randn(T,2)*P    #T x 2 matrix

println("means of simulated data")
println(round(mean(X,1),4))
println("covariance matrix of simulated data")
println(round(cov(X),4))

