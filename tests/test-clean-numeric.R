# run_tests.R loads testthat and the saved function for you.
# Run the full file with source("run_tests.R") from the project root.

# This is a valid starting check, but it tests very little of the specification.
test_that("ordinary values are unchanged", {
    expect_equal(
        clean_numeric(c(10, 20)),
        c(10, 20)
    )
})

# YOUR TURN:
# Choose three different behaviors from the specification in README.md.
# Add two or three named test_that() blocks below.
# You choose the inputs and independently determine their expected outputs.
# Above each test, briefly state which mistake that test could reveal.
# You do not need any new testing syntax; expect_equal() is enough to start.

# Add your tests here.

# test behavior for limits parameters (lower and upper)
# verify that numbers < lower are indeed set for NA, same for upper
test_that("upper and lower parameters work correctly",{
 
    # test vals of lower 
    expect_equal(
        clean_numeric(values = c(-10, -5, 0, 1, 2), lower = 0),
                                c(NA, NA, 0, 1, 2))
    
    # test vals of upper 
    expect_equal(
        clean_numeric(values = c(-100, -50, 0, 10, 10^30), upper = Inf),
        c(-100, -50, 0, 10, 10^30))

})

# test behavior on empty input vector 
# wrong test for demo purposes-- should fail 
test_that("fucntion that returns NA on empty input", {
    expect_equal(
        is.na(clean.numeric(values = c())), TRUE
    )
})
