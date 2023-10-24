# LC 8
before <- c(102.7, 103.5, 102.2, 103.0, 101.2, 100.4, 101.8, 103.1, 102.5, 101.7, 102.1, 101.3)
after <- c(99.0, 100.3, 101.0, 100.9, 99.6, 99.9, 100.2, 100, 100.3, 100.3, 101.5, 100.2)
delta <- after - before

pool_sd = sqrt((11*sd(before)^2+11*sd(after)^2)/22)
meand = mean(delta)
sdd = sd(delta)

tsta = meand/(sdd/sqrt(12))
lowerci = meand - qt(.975, df = 11)*(sdd/sqrt(11))
upperci = meand + qt(.975, df = 11)*(sdd/sqrt(11))

tsta = (mean(after)-mean(before))/(pool_sd*sqrt(1/12+1/12))

t.test(before, after, paired = T, alternative = "two.sided")

pt(tsta, df=22)

# LC 9
IImean = 55.2
IDmean = 49.0
IIsd = 15.5
IDsd = 13.3
IIn = 2597
IDn = 140

# f test
f = IIsd^2/IDsd^2
round(f, 2)
qf(.975, df1 = IIn - 1, df2 = IDn -1) # reject H0

# paired t-test
t = (IImean-IDmean)/sqrt(IIsd^2/IIn+IDsd^2/IDn)
round(t, 2)

d_dash = (IIsd^2/IIn+IDsd^2/IDn)^2/((IIsd^2/IIn)^2/(IIn-1)+(IDsd^2/IDn)^2/(IDn-1))

qt(.975, df=160)

# LC 11










