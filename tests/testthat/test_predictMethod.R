library(uGMAR)
context("predict method")

params12 <- c(1.0, 0.9, 0.25, 4.5, 0.7, 3.0, 0.8)
params23 <- c(2.7, 0.8, -0.06, 0.3, 3.5, 0.8, -0.07, 2.6, 7.2, 0.3, -0.01, 0.1, 0.6, 0.25)
params12r <- c(1.4, 1.8, 0.9, 0.3, 3.3, 0.8)
params12gs <- c(4.13, 0.73, 1.98, 1.7, 0.85, 0.3, 0.37, 9) # M1=1, M2=1
params23r <- c(1.7, 1.9, 2.1, 0.8, -0.05, 0.3, 0.7, 4.5, 0.7, 0.2)
R1 <- matrix(c(1, 0, 0, 0, 0, 1), ncol=2)
R3 <- matrix(c(0.5, 0.5), ncol=1)
R4 <- diag(1, ncol=2, nrow=2)
params22c <- c(1, 0.1, -0.1, 1, 2, 0.2, 2, 0.8, 11, 12) # R4, R3, StMAR
params32cr <- c(1, 2, 0.3, -0.3, 1, 2, 0.6) # R1

gmar12 <- GSMAR(data=simudata, p=1, M=2, params=params12, model="GMAR")
gmar23 <- GSMAR(data=simudata, p=2, M=3, params=params23, model="GMAR")
gmar12r <- GSMAR(data=simudata, p=1, M=2, params=params12r, model="GMAR", restricted=TRUE)
gmar23r <- GSMAR(data=simudata, p=2, M=3, params=params23r, model="GMAR", restricted=TRUE)
stmar22c <- GSMAR(data=simudata, p=2, M=2, params=params22c, model="StMAR", constraints=list(R4, R3))
gmar32cr <- GSMAR(data=simudata, p=3, M=2, params=params32cr, model="GMAR", restricted=TRUE, constraints=R1)
gstmar12 <- GSMAR(data=simudata, p=1, M=c(1, 1), params=params12gs, model="G-StMAR")

set.seed(1); pred12_0 <- predict.gsmar(gmar12, n_ahead=1, nsimu=1, pi_type="none", plot_res=FALSE, pred_type="mean")
set.seed(1); pred12 <- predict.gsmar(gmar12, n_ahead=1, nsimu=50, pi=c(0.90, 0.80), plot_res=FALSE, pred_type="mean")
set.seed(2); pred23_0 <- predict.gsmar(gmar23, n_ahead=1, nsimu=1, plot_res=FALSE, pred_type="cond_mean")
set.seed(2); pred23 <- predict.gsmar(gmar23, n_ahead=3, nsimu=50, pi=c(0.99, 0.90, 0.60), plot_res=FALSE, pred_type="median")
set.seed(3); pred12r <- predict.gsmar(gmar12r, n_ahead=3, nsimu=50, pi=c(0.999, 0.001), plot_res=FALSE, pred_type="median")
set.seed(4); pred23r <- predict.gsmar(gmar23r, n_ahead=1, nsimu=50, pi=c(0.5), plot_res=FALSE, pred_type="mean")
set.seed(5); pred22c <- predict.gsmar(stmar22c, n_ahead=1, nsimu=20, pi=c(0.99, 0.90, 0.60), plot_res=FALSE, pred_type="median")
set.seed(6); pred32cr <- predict.gsmar(gmar32cr, n_ahead=1, nsimu=10, pi=c(0.90), plot_res=FALSE, pred_type="mean")
set.seed(7); pred12gs <- predict.gsmar(gstmar12, n_ahead=1, nsimu=50, pi=c(0.90, 0.80), plot_res=FALSE, pred_type="mean")

test_that("predict.gsmar gives correct prediction", {
  expect_equal(pred12_0$pred, 14.52315, tolerance=1e-3)
  expect_equal(pred12$pred, 14.97511, tolerance=1e-3)
  expect_equal(pred23_0$pred, 14.48078, tolerance=1e-3)
  expect_equal(pred23$pred[3], 13.74908, tolerance=1e-3)
  expect_equal(pred12r$pred[2], 14.8341, tolerance=1e-3)
  expect_equal(pred23r$pred, 13.3039, tolerance=1e-3)
  expect_equal(pred22c$pred, 7.228356, tolerance=1e-3)
  expect_equal(pred32cr$pred, 1.859976, tolerance=1e-3)
  expect_equal(pred12gs$pred, 15.03605, tolerance=1e-3)

  expect_equal(pred12$mix_pred[2], 0.9996098, tolerance=1e-3)
  expect_equal(pred22c$mix_pred[1], 0.04774833, tolerance=1e-3)
  expect_equal(pred32cr$mix_pred[2], 1, tolerance=1e-3)
  expect_equal(pred12gs$mix_pred[1], 0.9821575, tolerance=1e-3)
})

test_that("predict.gsmar gives correct prediction intervals", {
  expect_equal(pred12$pred_ints[1], 12.59725, tolerance=1e-3)
  expect_equal(pred12$pred_ints[3], 16.68422, tolerance=1e-3)
  expect_equal(pred23$pred_ints[3], 9.283188, tolerance=1e-3)
  expect_equal(pred23$pred_ints[11], 15.78241, tolerance=1e-3)
  expect_equal(pred12r$pred_ints[3], 13.22346, tolerance=1e-3)
  expect_equal(pred12r$pred_ints[7], 15.07128, tolerance=1e-3)
  expect_equal(pred23r$pred_ints[2], 14.89878, tolerance=1e-3)
  expect_equal(pred22c$pred_ints[3], 0.7954964, tolerance=1e-3)
  expect_equal(pred32cr$pred_ints[2], 3.428412, tolerance=1e-3)
  expect_equal(pred12gs$pred_ints[2], 13.29962, tolerance=1e-3)

  expect_equal(pred12$mix_pred_ints[1, 4, 2], 0.999698, tolerance=1e-3)
  expect_equal(pred32cr$mix_pred_ints[1, 1, 2], 1, tolerance=1e-3)
  expect_equal(pred12gs$mix_pred_ints[1, 2, 2], 0.0178425, tolerance=1e-3)
})

params12gs <- c(3.98, 0.68, 0.36, 0.70, 0.94, 11.75, 0.25, 2.03) # M = c(1, 1)
params23gs <- c(2.0, 0.83, 0.01, 0.36, 1.14, 0.90, 0.01, 0.06, 4.23, 0.72, 0.01, 3.85, 0.6, 0.20, 3.3) # M = c(2, 1)
gstmar12 <- GSMAR(simudata, p=1, M=c(1, 1), params=params12gs, model="G-StMAR")
gstmar23 <- GSMAR(simudata, p=2, M=c(2, 1), params=params23gs, model="G-StMAR")
pred12gs <- predict.gsmar(gstmar12, pred_type="cond_mean", plot_res=FALSE)
pred23gs <- predict.gsmar(gstmar23, pred_type="cond_mean", plot_res=FALSE)

test_that("predict.gsmar one-step-cond-mean works correctly", {
  expect_equal(pred12gs$pred, 14.90026, tolerance=1e-3)
  expect_equal(pred23gs$pred, 15.23974, tolerance=1e-3)
  expect_equal(unname(pred12gs$mix_pred[1, 1]), 0.02785793, tolerance=1e-3)
  expect_equal(unname(pred23gs$mix_pred[1, 3]), 0.9275984, tolerance=1e-3)
})
