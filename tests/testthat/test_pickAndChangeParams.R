library(uGMAR)
context("pick and change parameters")

params11 <- c(1, 0.9, 1, 10) # StMAR
params12 <- c(0.8, 0.5, 0.5, 2, -1, 0.1, 0.6)
params12_2 <- c(2, -1, 0.1, 0.8, 0.5, 0.5, 0.4, 12, 30) #StMAR
params22 <- c(0.2, 0.1, 0.2, 0.2, 0.3, 0.2, 0.2, 0.2, 0.49)
params13 <- c(0.1, 0.99, 0.1, 0.2, -0.99, 0.2, 0.3, 0.01, 0.3, 0.5, 0.5)
params23 <- c(0.1, 0.1, 0.1, 0.1, 0.2, 0.5, 0.5, 0.2, 0.3, 0.3, 0.3, 0.3, 0.8, 0.05, 11, 12, 13) # StMAR

params12r <- c(0.1, 0.2, 0.9, 0.1, 0.2, 0.6, 11, 12) # StMAR
params22r <- c(0.1, 0.2, 0.89, 0.01, 0.1, 0.2, 0.05)
params23r <- c(0.1, 0.3, 0.4, -0.4, 0.3, 1, 2, 3, 0.5, 0.1, 100, 112, 130) # StMAR
params13r <- c(1, 2, 3, 0.999, 1, 2, 3, 0.2, 0.15)

params13gs <- c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 3, 0.4, 0.2, 10, 20) # M1=1, M2=2
params23gs <- c(1, 0.1, 0.1, 1, 2, 0.2, 0.2, 2, 3, 0.3, 0.3, 3, 0.2, 0.3, 10) # M1=2, M2=1
params14gs <- c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 3, 4, 0.4, 4, 0.4, 0.3, 0.2, 11, 12) # M1=2, M2=2
params22gsr <- c(1, 2, 0.1, 0.2, 1, 2, 0.1, 10) # M1=1, M2=1
params13gsr <- c(1, 2, 3, 0.5, 1, 2, 3, 0.1, 0.1, 11, 12) # M1=1, M2=2
params14gsr <- c(1, 2, 3, 4, 0.5, 1, 2, 3, 4, 0.1, 0.2, 0.3, 10) # M1=3, M2=1


test_that("pick_pars works correctly", {
  expect_equal(pick_pars(p=1, M=1, params=params11, model="StMAR"), matrix(c(1, 0.9, 1), ncol=1))
  expect_equal(pick_pars(p=1, M=2, params=params12, model="GMAR"), matrix(c(0.8, 0.5, 0.5, 2, -1, 0.1), ncol=2))
  expect_equal(pick_pars(p=2, M=2, params=params22, model="GMAR"), matrix(c(0.2, 0.1, 0.2, 0.2, 0.3, 0.2, 0.2, 0.2), ncol=2))
  expect_equal(pick_pars(p=1, M=3, params=params13gs, model="G-StMAR"), matrix(c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 3), ncol=3))
  expect_equal(pick_pars(p=2, M=3, params=params23gs, model="G-StMAR"), matrix(c(1, 0.1, 0.1, 1, 2, 0.2, 0.2, 2, 3, 0.3, 0.3, 3) , ncol=3))
})


test_that("pick_alphas works correctly", {
  expect_equal(pick_alphas(p=1, M=1, params=params11, model="StMAR"), 1)
  expect_equal(pick_alphas(p=1, M=2, params=params12, model="GMAR"), c(0.6, 0.4))
  expect_equal(pick_alphas(p=1, M=2, params=params12_2, model="StMAR"), c(0.4, 0.6))
  expect_equal(pick_alphas(p=2, M=2, params=params22, model="GMAR"), c(0.49, 0.51))
  expect_equal(pick_alphas(p=1, M=3, params=params13, model="GMAR"), c(0.5, 0.5, 0.0))
  expect_equal(pick_alphas(p=2, M=3, params=params23, model="StMAR"), c(0.8, 0.05, 0.15))

  expect_equal(pick_alphas(p=1, M=2, params=params12r, model="StMAR", restricted=TRUE), c(0.6, 0.4))
  expect_equal(pick_alphas(p=2, M=2, params=params22r, model="GMAR", restricted=TRUE), c(0.05, 0.95))
  expect_equal(pick_alphas(p=2, M=3, params=params23r, model="StMAR", restricted=TRUE), c(0.5, 0.1, 0.4))
  expect_equal(pick_alphas(p=1, M=3, params=params13r, model="GMAR", restricted=TRUE), c(0.2, 0.15, 0.65))

  expect_equal(pick_alphas(p=1, M=c(1, 2), params=params13gs, model="G-StMAR"), c(0.4, 0.2, 0.4))
  expect_equal(pick_alphas(p=2, M=c(2, 1), params=params23gs, model="G-StMAR"), c(0.2, 0.3, 0.5))
  expect_equal(pick_alphas(p=1, M=c(2, 2), params=params14gs, model="G-StMAR"), c(0.4, 0.3, 0.2, 0.1))
  expect_equal(pick_alphas(p=2, M=c(1, 1), params=params22gsr, model="G-StMAR", restricted=TRUE), c(0.1, 0.9))
  expect_equal(pick_alphas(p=1, M=c(1, 2), params=params13gsr, model="G-StMAR", restricted=TRUE), c(0.1, 0.1, 0.8))
  expect_equal(pick_alphas(p=1, M=c(3, 1), params=params14gsr, model="G-StMAR", restricted=TRUE), c(0.1, 0.2, 0.3, 0.4))
})


test_that("pick_dfs works correctly", {
  expect_equal(pick_dfs(p=1, M=1, params=params11, model="StMAR"), 10)
  expect_equal(pick_dfs(p=1, M=2, params=params12, model="GMAR"), numeric(0))
  expect_equal(pick_dfs(p=1, M=2, params=params12_2, model="StMAR"), c(12, 30))
  expect_equal(pick_dfs(p=2, M=3, params=params23, model="StMAR"), c(11, 12, 13))

  expect_equal(pick_dfs(p=1, M=2, params=params12r, model="StMAR"), c(11, 12))
  expect_equal(pick_dfs(p=2, M=3, params=params23r, model="StMAR"), c(100, 112, 130))

  expect_equal(pick_dfs(p=1, M=c(1, 2), params=params13gs, model="G-StMAR"), c(10, 20))
  expect_equal(pick_dfs(p=2, M=c(2, 1), params=params23gs, model="G-StMAR"), c(10))
  expect_equal(pick_dfs(p=1, M=c(2, 2), params=params14gs, model="G-StMAR"), c(11, 12))
  expect_equal(pick_dfs(p=2, M=c(1, 1), params=params22gsr, model="G-StMAR"), c(10))
  expect_equal(pick_dfs(p=1, M=c(1, 2), params=params13gsr, model="G-StMAR"), c(11, 12))
  expect_equal(pick_dfs(p=1, M=c(3, 1), params=params14gsr, model="G-StMAR"), c(10))
})


test_that("pick_phi0 works correctly", {
  expect_equal(pick_phi0(p=1, M=1, params=params11, model="StMAR"), 1)
  expect_equal(pick_phi0(p=1, M=2, params=params12, model="GMAR"), c(0.8, 2))
  expect_equal(pick_phi0(p=1, M=2, params=params12_2, model="StMAR"), c(2, 0.8))
  expect_equal(pick_phi0(p=2, M=2, params=params22, model="GMAR"), c(0.2, 0.3))
  expect_equal(pick_phi0(p=1, M=3, params=params13, model="GMAR"), c(0.1, 0.2, 0.3))
  expect_equal(pick_phi0(p=2, M=3, params=params23, model="StMAR"), c(0.1, 0.2, 0.3))

  expect_equal(pick_phi0(p=1, M=2, params=params12r, model="StMAR", restricted=TRUE), c(0.1, 0.2))
  expect_equal(pick_phi0(p=2, M=2, params=params22r, model="GMAR", restricted=TRUE), c(0.1, 0.2))
  expect_equal(pick_phi0(p=2, M=3, params=params23r, model="StMAR", restricted=TRUE), c(0.1, 0.3, 0.4))
  expect_equal(pick_phi0(p=1, M=3, params=params13r, model="GMAR", restricted=TRUE), c(1, 2, 3))

  expect_equal(pick_phi0(p=1, M=c(1, 2), params=params13gs, model="G-StMAR"), c(1, 2, 3))
  expect_equal(pick_phi0(p=2, M=c(2, 1), params=params23gs, model="G-StMAR"), c(1, 2, 3))
  expect_equal(pick_phi0(p=1, M=c(2, 2), params=params14gs, model="G-StMAR"), c(1, 2, 3, 4))
  expect_equal(pick_phi0(p=2, M=c(1, 1), params=params22gsr, model="G-StMAR", restricted=TRUE), c(1, 2))
  expect_equal(pick_phi0(p=1, M=c(1, 2), params=params13gsr, model="G-StMAR", restricted=TRUE), c(1, 2, 3))
  expect_equal(pick_phi0(p=1, M=c(3, 1), params=params14gsr, model="G-StMAR", restricted=TRUE), c(1, 2, 3, 4))
})


calc_mu <- function(p, M, params, model=c("GMAR", "StMAR", "G-StMAR"), restricted=FALSE, constraints=NULL) {
  model <- match.arg(model)
  params <- reform_constrained_pars(p=p, M=M, params=params, model=model, restricted=restricted, constraints=constraints)
  pars <- reform_parameters(p=p, M=M, params=params, model=model, restricted=restricted)$pars
  M <- sum(M)
  vapply(1:M, function(m) pars[1, m]/(1 - sum(pars[(2:(nrow(pars) - 1)), m])), numeric(1))
}

params11_mu <- change_parametrization(p=1, M=1, params=params11, model="StMAR", change_to="mean")
params12_mu <- change_parametrization(p=1, M=2, params=params12, model="GMAR", change_to="mean")
params22_mu <- change_parametrization(p=2, M=2, params=params22, model="GMAR", change_to="mean")
params23gs_mu <- change_parametrization(p=2, M=c(2, 1), params=params23gs, model="G-StMAR", change_to="mean")

params12r_mu <- change_parametrization(p=1, M=2, params=params12r, model="StMAR", restricted=TRUE, change_to="mean")
params22r_mu <- change_parametrization(p=2, M=2, params=params22r, model="GMAR", restricted=TRUE, change_to="mean")
params13gsr_mu <- change_parametrization(p=1, M=c(1, 2), params=params13gsr, model="G-StMAR", restricted=TRUE, change_to="mean")

test_that("change_parametrization works correctly for non-constrained models", {
  expect_equal(calc_mu(p=1, M=1, params=params11, model="StMAR"), pick_phi0(p=1, M=1, params=params11_mu, model="StMAR"))
  expect_equal(change_parametrization(p=1, M=1, params=params11_mu, model="StMAR", change_to="intercept"), params11)

  expect_equal(calc_mu(p=1, M=2, params=params12, model="GMAR"), pick_phi0(p=1, M=2, params=params12_mu, model="GMAR"))
  expect_equal(change_parametrization(p=1, M=2, params=params12_mu, model="GMAR", change_to="intercept"), params12)

  expect_equal(calc_mu(p=2, M=2, params=params22, model="GMAR"), pick_phi0(p=2, M=2, params=params22_mu, model="GMAR"))
  expect_equal(change_parametrization(p=2, M=2, params=params22_mu, model="GMAR", change_to="intercept"), params22)

  expect_equal(calc_mu(p=2, M=c(2, 1), params=params23gs, model="G-StMAR"), pick_phi0(p=2, M=c(2, 1), params=params23gs_mu, model="G-StMAR"))
  expect_equal(change_parametrization(p=2, M=c(2, 1), params=params23gs_mu, model="G-StMAR", change_to="intercept"), params23gs)

  expect_equal(calc_mu(p=1, M=2, params=params12r, model="StMAR", restricted=TRUE), pick_phi0(p=1, M=2, params=params12r_mu, model="StMAR", restricted=TRUE))
  expect_equal(change_parametrization(p=1, M=2, params=params12r_mu, model="StMAR", restricted=TRUE, change_to="intercept"), params12r)

  expect_equal(calc_mu(p=2, M=2, params=params22r, model="GMAR", restricted=TRUE), pick_phi0(p=2, M=2, params=params22r_mu, model="GMAR", restricted=TRUE))
  expect_equal(change_parametrization(p=2, M=2, params=params22r_mu, model="GMAR", restricted=TRUE, change_to="intercept"), params22r)

  expect_equal(calc_mu(p=1, M=c(1, 2), params=params13gsr, model="G-StMAR", restricted=TRUE),
               pick_phi0(p=1, M=c(1, 2), params=params13gsr_mu, model="G-StMAR", restricted=TRUE))
  expect_equal(change_parametrization(p=1, M=c(1, 2), params=params13gsr_mu, model="G-StMAR", restricted=TRUE, change_to="intercept"), params13gsr)
})


R1 <- matrix(c(1, 0, 0, 0, 0, 1), ncol=2)
R2 <- diag(1, ncol=3, nrow=3)
R3 <- matrix(c(0.5, 0.5), ncol=1)
R4 <- diag(1, ncol=2, nrow=2)

params32c <- c(1, 0.1, -0.1, 1, 2, 0.2, -0.2, 2, 0.6, 11, 12) # model="StMAR", constraints=list(R1, R1)
params33c <- c(1, 0.1, 0.1, 0.1, 1, 2, 0.2, 0.2, 0.2, 2, 3, 0.3, -0.3, 3, 0.5, 0.4) #  constraints=list(R2, R2, R1)
params21c <- c(1, 0.1, 1, 3) # model="StMAR", constraints=list(R3)
params23gsc <- c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 0.3, 3, 0.3, 0.4, 20, 30) # M1=1, M2=2, model="G-StMAR", constraints=list(R3, R3, R4)
params21cr <- c(1, 0.1, 1) # restricted=TRUE, constraints=R3
params22cr <- c(1, 2, 0.8, 1, 2, 0.7, 11, 12) #  model="StMAR", restricted=TRUE, constraints=R3

params32c_mu <- change_parametrization(p=3, M=2, params=params32c, model="StMAR", constraints=list(R1, R1), change_to="mean")
params33c_mu <- change_parametrization(p=3, M=3, params=params33c, constraints=list(R2, R2, R1), change_to="mean")
params21c_mu <- change_parametrization(p=2, M=1, params=params21c, constraints=list(R3), change_to="mean")
params23gsc_mu <- change_parametrization(p=2, M=c(1, 2), params=params23gsc, model="G-StMAR", constraints=list(R3, R3, R4), change_to="mean")
params21cr_mu <- change_parametrization(p=2, M=1, params=params21cr, restricted=TRUE, constraints=R3, change_to="mean")
params22cr_mu <- change_parametrization(p=2, M=2, params=params22cr, model="StMAR", restricted=TRUE, constraints=R3, change_to="mean")

test_that("change_parametrization works correctly for constrained models", {
  expect_equal(calc_mu(p=3, M=2, params=params32c, model="StMAR", constraints=list(R1, R1)),
               pick_phi0(p=3, M=2, params=params32c_mu, model="StMAR", constraints=list(R1, R1)))
  expect_equal(change_parametrization(p=3, M=2, params=params32c_mu, model="StMAR", change_to="intercept", constraints=list(R1, R1)), params32c)

  expect_equal(calc_mu(p=3, M=3, params=params33c, model="GMAR", constraints=list(R2, R2, R1)),
               pick_phi0(p=3, M=3, params=params33c_mu, model="GMAR", constraints=list(R2, R2, R1)))
  expect_equal(change_parametrization(p=3, M=3, params=params33c_mu, model="GMAR", change_to="intercept", constraints=list(R2, R2, R1)), params33c)

  expect_equal(calc_mu(p=2, M=1, params=params21c, model="GMAR", constraints=list(R3)),
               pick_phi0(p=2, M=1, params=params21c_mu, model="GMAR", constraints=list(R3)))
  expect_equal(change_parametrization(p=2, M=1, params=params21c_mu, model="GMAR", constraints=list(R3), change_to="intercept"), params21c)

  expect_equal(calc_mu(p=2, M=c(1, 2), params=params23gsc, model="G-StMAR", constraints=list(R3, R3, R4)),
               pick_phi0(p=2, M=c(1, 2), params=params23gsc_mu, model="G-StMAR", constraints=list(R3, R3, R4)))
  expect_equal(change_parametrization(p=2, M=c(1, 2), params=params23gsc_mu, model="G-StMAR", constraints=list(R3, R3, R4), change_to="intercept"), params23gsc)

  expect_equal(calc_mu(p=2, M=1, params=params21cr, model="GMAR", restricted=TRUE, constraints=R3),
               pick_phi0(p=2, M=1, params=params21cr_mu, model="GMAR", restricted=TRUE, constraints=R3))
  expect_equal(change_parametrization(p=2, M=1, params=params21cr_mu, model="GMAR", restricted=TRUE, constraints=R3, change_to="intercept"), params21cr)

  expect_equal(calc_mu(p=2, M=2, params=params22cr, model="StMAR", restricted=TRUE, constraints=R3),
               pick_phi0(p=2, M=2, params=params22cr_mu, model="StMAR", restricted=TRUE, constraints=R3))
  expect_equal(change_parametrization(p=2, M=2, params=params22cr_mu, model="StMAR", restricted=TRUE, constraints=R3, change_to="intercept"), params22cr)
})


params11t <- c(-2, 0.8, 1, 12) # StMAR
params23 <- c(2.7, 0.8, -0.06, 0.3, 3.5, 0.8, -0.07, 2.6, 7.2, 0.3, -0.01, 0.1, 0.6, 0.25)
params23t <- c(1.8, 0.9, -0.06, 0.4, 7.2, 0.3, -0.009, 0.1, 3.1, 0.83, -0.05, 3.7, 0.7, 0.2, 11, 339, 198) # StMAR
params13gsr <- c(1.3, 1, 1.4, 0.8, 0.4, 2, 0.2, 0.25, 0.15, 20) # M1=2, M2=1

stmar11 <- GSMAR(p=1, M=1, params=params11t, model="StMAR")
gmar23 <- GSMAR(p=2, M=3, params=params23, model="GMAR")
stmar23 <- GSMAR(p=2, M=3, params=params23t, model="StMAR")
gstmar13r <- GSMAR(p=1, M=c(2, 1), params=params13gsr, model="G-StMAR", restricted=TRUE)


test_that("get_ar_roots works correctly", {
  expect_equal(get_ar_roots(stmar11)[[1]], 1.25, tolerance=1e-5)
  expect_equal(get_ar_roots(gmar23)[[3]], c(3.81966, 26.18034), tolerance=1e-5)
  expect_equal(get_ar_roots(stmar23)[[2]], c(3.756722, 29.576611), tolerance=1e-5)
  expect_equal(get_ar_roots(gstmar13r)[[3]], 1.25, tolerance=1e-5)
})

pars11t <- c(1, 0.9, 1, 10)
pars12t <- c(2, 0.9, 0.1, 0.8, 0.5, 0.5, 0.4, 12, 30)
pars23t <- c(0.1, 0.1, 0.1, 0.1, 0.2, 0.5, 0.5, 0.2, 0.3, 0.3, 0.3, 0.3, 0.8, 0.05, 11, 12, 13)
pars12tr <- c(0.1, 0.2, 0.9, 0.1, 0.2, 0.6, 14, 12)
pars23tr <- c(0.1, 0.3, 0.4, -0.4, 0.3, 1, 2, 3, 0.5, 0.1, 1000, 112, 130)

R1 <- matrix(c(1, 0, 0, 0, 0, 1), ncol=2)
R2 <- diag(1, ncol=3, nrow=3)
R3 <- matrix(c(0.5, 0.5), ncol=1)

pars32tc <- c(1, 0.1, -0.1, 1, 2, 0.2, -0.2, 2, 0.6, 11, 12) #constraints=list(R1, R1)
pars33tc <- c(1, 0.1, 0.1, 0.1, 1, 2, 0.2, 0.2, 0.2, 2, 3, 0.3, -0.3, 3, 0.3, 0.4, 13, 12, 11) #  constraints=list(R2, R2, R1)
pars22tcr <- c(1, 2, 0.8, 1, 2, 0.7, 11, 12) # restricted=TRUE, constraints=R3
pars21tcr <- c(1, 0.1, 1, 10) # restricted=TRUE, constraints=R3

# G-StMAR
params13gs2 <- c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 3, 0.5, 0.2, 10, 20) # M1=1, M2=2, alpha3=0.3
params13gs3 <- c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 3, 0.5, 0.2, 20, 10) # M1=1, M2=2, alpha3=0.3
params23gs1 <- c(1, 0.1, 0.1, 1, 2, 0.2, 0.2, 2, 3, 0.3, 0.3, 3, 0.2, 0.3, 10) # M1=2, M2=1, alpha3=0.5
params23gs2 <- c(1, 0.1, 0.1, 1, 2, 0.2, 0.2, 2, 3, 0.3, 0.3, 3, 0.2, 0.3, 10, 4) # M1=1, M2=2, alpha3=0.5
params14gs1 <- c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 3, 4, 0.4, 4, 0.4, 0.3, 0.2, 11, 13) # M1=2, M2=2, alpha4=0.1
params14gs2 <- c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 3, 4, 0.4, 4, 0.3, 0.4, 0.2, 13, 11, 13) # M1=1, M2=3, alpha4=0.1
params22gsr1 <- c(1, 2, 0.1, 0.2, 1, 2, 0.1, 10) # M1=1, M2=1, restricted, alpha2=0.9
params13gsr1 <- c(1, 2, 3, 0.5, 1, 2, 3, 0.2, 0.1, 11, 13) # M1=1, M2=2, restricted, alpha3=0.7

R3 <- matrix(c(0.5, 0.5), ncol=1)
R4 <- diag(1, ncol=2, nrow=2)
params23gsc1 <- c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 0.3, 3, 0.3, 0.5, 30, 10) # M1=1, M2=2, model="G-StMAR", constraints=list(R3, R3, R4)
params23gsc2 <- c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 0.3, 3, 0.3, 0.5, 10, 30) # M1=1, M2=2, model="G-StMAR", constraints=list(R3, R3, R4)
params23gscr1 <- c(1, 2, 3, 0.1, 1, 2, 3, 0.3, 0.2, 10, 30) # M1=1, M2=2, model="G-StMAR", restricted=TRUE, constraints=R3

test_that("stmarpars_to_gstmar works correctly", {
  ret23gscr1 <- stmarpars_to_gstmar(p=2, M=c(1, 2), params=params23gscr1, model="G-StMAR", restricted=TRUE, constraints=R3, maxdf=25)
  expect_equal(ret23gscr1$M, c(2, 1))
  expect_equal(ret23gscr1$reg_order, c(3, 1, 2))
  expect_equal(ret23gscr1$params, c(3, 1, 2, 0.1, 3, 1, 2, 0.5, 0.3, 10))

  ret23gsc2 <- stmarpars_to_gstmar(p=2, M=c(1, 2), params=params23gsc2, model="G-StMAR", constraints=list(R3, R3, R4), maxdf=25)
  expect_equal(ret23gsc2$M, c(2, 1))
  expect_equal(ret23gsc2$reg_order, c(1, 3, 2))
  expect_equal(ret23gsc2$params, c(1, 0.1, 1, 3, 0.3, 0.3, 3, 2, 0.2, 2, 0.3, 0.2, 10))

  ret23gsc1 <- stmarpars_to_gstmar(p=2, M=c(1, 2), params=params23gsc1, model="G-StMAR", constraints=list(R3, R3, R4), maxdf=25)
  expect_equal(ret23gsc1$M, c(2, 1))
  expect_equal(ret23gsc1$reg_order, c(2, 1, 3))
  expect_equal(ret23gsc1$params, c(2, 0.2, 2, 1, 0.1, 1, 3, 0.3, 0.3, 3, 0.5, 0.3, 10))

  ret13gsr2 <- suppressWarnings(stmarpars_to_gstmar(p=1, M=c(1, 2), params=params13gsr1, model="G-StMAR", restricted=TRUE, maxdf=100))
  expect_equal(ret13gsr2$M, c(1, 2))
  expect_equal(ret13gsr2$reg_order, c(1, 2, 3))
  expect_equal(ret13gsr2$params, params13gsr1)

  ret13gsr1 <- stmarpars_to_gstmar(p=1, M=c(1, 2), params=params13gsr1, model="G-StMAR", restricted=TRUE, maxdf=12)
  expect_equal(ret13gsr1$M, c(2, 1))
  expect_equal(ret13gsr1$reg_order, c(3, 1, 2))
  expect_equal(ret13gsr1$params, c(3, 1, 2, 0.5, 3, 1, 2, 0.7, 0.2, 11))

  ret22gsr1 <- stmarpars_to_gstmar(p=2, M=c(1, 1), params=params22gsr1, model="G-StMAR", restricted=TRUE, maxdf=5)
  expect_equal(ret22gsr1$M, c(2, 0))
  expect_equal(ret22gsr1$reg_order, c(2, 1))
  expect_equal(ret22gsr1$params, c(2, 1, 0.1, 0.2, 2, 1, 0.9))

  ret14gs2 <- stmarpars_to_gstmar(p=1, M=c(1, 3), params=params14gs2, model="G-StMAR", maxdf=12)
  expect_equal(ret14gs2$M, c(3, 1))
  expect_equal(ret14gs2$reg_order, c(2, 1, 4, 3))
  expect_equal(ret14gs2$params, c(2, 0.2, 2, 1, 0.1, 1, 4, 0.4, 4, 3, 0.3, 3, 0.4, 0.3, 0.1, 11))

  ret14gs1 <- stmarpars_to_gstmar(p=1, M=c(2, 2), params=params14gs1, model="G-StMAR", maxdf=12)
  expect_equal(ret14gs1$M, c(3, 1))
  expect_equal(ret14gs1$reg_order, c(1, 2, 4, 3))
  expect_equal(ret14gs1$params, c(1, 0.1, 1, 2, 0.2, 2, 4, 0.4, 4, 3, 0.3, 3, 0.4, 0.3, 0.1, 11))

  ret23gs2 <- stmarpars_to_gstmar(p=2, M=c(1, 2), params=params23gs2, model="G-StMAR", maxdf=5)
  expect_equal(ret23gs2$M, c(2, 1))
  expect_equal(ret23gs2$reg_order, c(2, 1, 3))
  expect_equal(ret23gs2$params, c(2, 0.2, 0.2, 2, 1, 0.1, 0.1, 1, 3, 0.3, 0.3, 3, 0.3, 0.2, 4))

  ret23gs1 <- stmarpars_to_gstmar(p=2, M=c(2, 1), params=params23gs1, model="G-StMAR", maxdf=5)
  expect_equal(ret23gs1$M, c(3, 0))
  expect_equal(ret23gs1$reg_order, c(3, 2, 1))
  expect_equal(ret23gs1$params, c(3, 0.3, 0.3, 3, 2, 0.2, 0.2, 2, 1, 0.1, 0.1, 1, 0.5, 0.3))

  ret13gs3 <- stmarpars_to_gstmar(p=1, M=c(1, 2), params=params13gs3, model="G-StMAR", maxdf=15)
  expect_equal(ret13gs3$M, c(2, 1))
  expect_equal(ret13gs3$reg_order, c(1, 2, 3))
  expect_equal(ret13gs3$params, c(1, 0.1, 1, 2, 0.2, 2, 3, 0.3, 3, 0.5, 0.2, 10))

  ret13gs2 <- stmarpars_to_gstmar(p=1, M=c(1, 2), params=params13gs2, model="G-StMAR", maxdf=15)
  expect_equal(ret13gs2$M, c(2, 1))
  expect_equal(ret13gs2$reg_order, c(1, 3, 2))
  expect_equal(ret13gs2$params, c(1, 0.1, 1, 3, 0.3, 3, 2, 0.2, 2, 0.5, 0.3, 10))


  expect_equal(stmarpars_to_gstmar(p=1, M=1, params=pars11t, model="StMAR", maxdf=4)$M, c(1, 0))
  expect_equal(stmarpars_to_gstmar(p=1, M=1, params=pars11t, model="StMAR", maxdf=4)$reg_order, 1)
  expect_equal(stmarpars_to_gstmar(p=1, M=1, params=pars11t, model="StMAR", maxdf=4)$params, c(1, 0.9, 1))
  expect_equal(stmarpars_to_gstmar(p=1, M=2, params=pars12t, model="StMAR", maxdf=12)$M, c(1, 1))
  expect_equal(stmarpars_to_gstmar(p=1, M=2, params=pars12t, model="StMAR", maxdf=12)$reg_order, c(2, 1))
  expect_equal(stmarpars_to_gstmar(p=1, M=2, params=pars12t, model="StMAR", maxdf=12)$params, c(0.8, 0.5, 0.5, 2, 0.9, 0.1, 0.6, 12))
  expect_equal(stmarpars_to_gstmar(p=2, M=3, params=pars23t, model="StMAR", maxdf=11)$M, c(2, 1))
  expect_equal(stmarpars_to_gstmar(p=2, M=3, params=pars23t, model="StMAR", maxdf=11)$reg_order, c(3, 2, 1))
  expect_equal(stmarpars_to_gstmar(p=2, M=3, params=pars23t, model="StMAR", maxdf=11)$params, c(0.3, 0.3, 0.3, 0.3, 0.2, 0.5, 0.5, 0.2, 0.1, 0.1, 0.1, 0.1, 0.15, 0.05, 11))
  expect_equal(stmarpars_to_gstmar(p=1, M=2, params=pars12tr, model="StMAR", restricted=TRUE, maxdf=13)$M, c(1, 1))
  expect_equal(stmarpars_to_gstmar(p=1, M=2, params=pars12tr, model="StMAR", restricted=TRUE, maxdf=13)$reg_order, c(1, 2))
  expect_equal(stmarpars_to_gstmar(p=1, M=2, params=pars12tr, model="StMAR", restricted=TRUE, maxdf=13)$params, c(0.1, 0.2, 0.9, 0.1, 0.2, 0.6, 12))
  expect_equal(stmarpars_to_gstmar(p=2, M=3, params=pars23tr, model="StMAR", restricted=TRUE, maxdf=120)$M, c(2, 1))
  expect_equal(stmarpars_to_gstmar(p=2, M=3, params=pars23tr, model="StMAR", restricted=TRUE, maxdf=120)$reg_order, c(1, 3, 2))
  expect_equal(stmarpars_to_gstmar(p=2, M=3, params=pars23tr, model="StMAR", restricted=TRUE, maxdf=120)$params, c(0.1, 0.4, 0.3, -0.4, 0.3, 1, 3, 2, 0.5, 0.4, 112))
  expect_equal(stmarpars_to_gstmar(p=3, M=2, params=pars32tc, model="StMAR", constraints=list(R1, R1), maxdf=11)$M, c(1, 1))
  expect_equal(stmarpars_to_gstmar(p=3, M=2, params=pars32tc, model="StMAR", constraints=list(R1, R1), maxdf=11)$reg_order, c(2, 1))
  expect_equal(stmarpars_to_gstmar(p=3, M=2, params=pars32tc, model="StMAR", constraints=list(R1, R1), maxdf=11)$params, c(2, 0.2, -0.2, 2, 1, 0.1, -0.1, 1, 0.4, 11))
  expect_equal(stmarpars_to_gstmar(p=3, M=3, params=pars33tc, model="StMAR", constraints=list(R2, R2, R1), maxdf=11)$M, c(2, 1))
  expect_equal(stmarpars_to_gstmar(p=3, M=3, params=pars33tc, model="StMAR", constraints=list(R2, R2, R1), maxdf=11)$reg_order, c(2, 1, 3))
  expect_equal(stmarpars_to_gstmar(p=3, M=3, params=pars33tc, model="StMAR", constraints=list(R2, R2, R1), maxdf=11)$params,
               c(2, 0.2, 0.2, 0.2, 2, 1, 0.1, 0.1, 0.1, 1, 3, 0.3, -0.3, 3, 0.4, 0.3, 11))
  expect_equal(stmarpars_to_gstmar(p=2, M=2, params=pars22tcr, model="StMAR", restricted=TRUE, constraints=R3, maxdf=11)$M, c(1, 1))
  expect_equal(stmarpars_to_gstmar(p=2, M=2, params=pars22tcr, model="StMAR", restricted=TRUE, constraints=R3, maxdf=11)$reg_order, c(2, 1))
  expect_equal(stmarpars_to_gstmar(p=2, M=2, params=pars22tcr, model="StMAR", restricted=TRUE, constraints=R3, maxdf=11)$params, c(2, 1, 0.8, 2, 1, 0.3, 11))
  expect_equal(stmarpars_to_gstmar(p=2, M=1, params=pars21tcr, model="StMAR", restricted=TRUE, constraints=R3, maxdf=4)$M, c(1, 0))
  expect_equal(stmarpars_to_gstmar(p=2, M=1, params=pars21tcr, model="StMAR", restricted=TRUE, constraints=R3, maxdf=4)$reg_order, 1)
  expect_equal(stmarpars_to_gstmar(p=2, M=1, params=pars21tcr, model="StMAR", restricted=TRUE, constraints=R3, maxdf=4)$params, c(1, 0.1, 1))
})
