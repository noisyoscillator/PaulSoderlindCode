"""
    NewEst3Ps(g0,m=0,HHQ=false)

Calculates covariance matrix of sqrt(T)*sample average.

# Usage
S = NewEst3Ps(g0,m)

# Input
- `g0::Array`: Txq array of q moment conditions
- `m:int`:     scalar, number of lags to use
- `HHQ:Bool`:  bool, true: do Hansen-Hodrick, else Newey-West

# Output
- `S::Array`: qxq covariance matrix of sum( g0/sqrt(T) )

 # Notice
The CLT typically say that sqrt(T)*sample average ->d N(mu,Shat), where Shat is
what this code estimates. Clearly, Var(sample average) = Shat/T.

# Reference
Newey and West, 1987 (Econometrica),  Newey, 1985 (Journal of Econometrics)

"""
function NewEst3Ps(g0,m=0,HHQ=false)

  (T,q) = (size(g0,1),size(g0,2))        #g is Txq
  m     = min(m,T-1)                     #number of lags

  g = g0 .- mean(g0,dims=1)       #Normalizing to Eg=0

  S = g'g/T                              #(qxT)*(Txq)
  for s = 1:m
    Omega_s = g[s+1:T,:]'g[1:T-s,:]/T    #same as Sum[g(t)*g(t-s)',t=s+1,T]
    HHQ ? w = 1 : w = (1 - s/(m+1))      #Hansen-Hodrick or Newey-West
    S       = S + w*(Omega_s + Omega_s')
  end

  if q == 1             #to scalar
    S = S[1,1]
  end

  return S

end
#-----------------------------------------------------------------------
