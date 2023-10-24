# LC 11
p = 24/3900
n = 3900

# 95% CI for the true proportion of vaccinated people
lower_ci = p - qnorm(.975, mean = 0, sd = 1)*sqrt((p*(1-p))/n)
round(lower_ci, 3)

upper_ci = p + qnorm(.975, mean = 0, sd = 1)*sqrt((p*(1-p))/n)
round(upper_ci, 3)

n = 1000
p = 864/1000
p0 = 0.5

z = (p-p0)/sqrt((p0*(1-p0))/n)
round(z, 2)
qnorm(.975, mean = 0, sd = 1)

# LC 12
nt = 150
nn = 100
pt = 48/150
pn = 21/100

# 95% CI for the difference in the proportion of all teachers and nurses that have a second job
lower_ci = pt - pn - qnorm(.975, mean = 0, sd = 1)*sqrt((pt*(1-pt)/nt) + (pn*(1-pn)/nn))
round(lower_ci, 3)

upper_ci = pt - pn + qnorm(.975, mean = 0, sd = 1)*sqrt((pt*(1-pt)/nt) + (pn*(1-pn)/nn))
round(upper_ci, 3)



