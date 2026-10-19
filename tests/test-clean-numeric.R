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
