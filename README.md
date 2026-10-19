# HUGEN 2076: Unit testing and continuous integration in-class exercise

This repository supplies a working `clean_numeric()` function, one deliberately
weak starter test, and a complete GitHub Actions workflow. You will write additional
tests. GitHub then runs your saved tests automatically after you push changes.

## What is already supplied?

```text
.github/workflows/run-r-tests.yml  Automation: already complete
R/clean_numeric.R                  Working function: initially leave unchanged
tests/test-clean-numeric.R         One weak test: you add meaningful tests here
run_tests.R                       Run the same tests locally and on GitHub
activity_notes.md                 Record your reasoning and observed runs
testing_ci.Rproj                  Open this project in RStudio
```

Do not change the runner or YAML.

## 1. Make your own repository, then clone it

On the instructor's public template page, select **Use this template > Create a
new repository**. Choose your own account as the owner and name the repository
`testing-ci-YOURUSERNAME`.

Clone **your newly created repository**, not the instructor's original. Use your
usual RStudio/Git procedure and the clone URL from your own repository's Code
button. Open `testing_ci.Rproj`.

Install the `testthat` package if necessary:

```r
install.packages("testthat")
```

## 2. Establish a baseline

From the project root in the R console:

```r
source("run_tests.R")
```

Or in the terminal, from the same directory:

```bash
Rscript --vanilla run_tests.R
```

The supplied test should pass. Replace `YOURUSERNAME` in `activity_notes.md`, save,
commit, and push.

Open **your repository > Actions > R tests**, select the run for that commit,
then open the **Run unit tests** job and expand **Run tests**. Record the result.
Setup can take a few minutes; continue planning your tests while it runs.

A local commit alone does not trigger this hosted workflow. The push does.

## 3. Understand the function's required behavior

```r
clean_numeric(values, missing_codes = numeric(0), lower = -Inf, upper = Inf)
```

The function returns a cleaned numeric vector according to these rules:

- Every value matching ANY entry in `missing_codes` becomes `NA`.
- `missing_codes = numeric(0)` means no special codes are assumed. A negative
  value is not automatically missing; the caller chooses the codes.
- Values strictly less than `lower` or strictly greater than `upper` become `NA`.
  Both endpoints are included in the permitted range.
- The default limits impose no finite lower or upper restriction. The caller
  may specify one limit or both limits.
- Existing `NA` values remain missing in their original positions.
- The output preserves the number and order of observations. Replace values;
  do not drop or reorder observations.
- A specified missing code still becomes `NA` when it falls within the limits.
- An empty numeric input returns an empty numeric vector.

**Scope:** assume `values` is an unnamed numeric vector containing finite numbers
and/or `NA`; `missing_codes` is a numeric vector of finite codes (possibly empty);
and the limits are single nonmissing numeric values with `lower <= upper`.
Infinite limits are allowed as shown in the defaults. Input validation and
behavior outside these assumptions are not part of this class exercise.

## 4. Choose and write your own tests

Keep `R/clean_numeric.R` unchanged for this stage.

Before reading its implementation in detail, use the specification to choose
**three distinct behaviors** worth checking. Write two or three additional named
`test_that()` blocks in `tests/test-clean-numeric.R`. A block may contain more
than one expectation. You choose the actual values, arguments, and expected
results; they are not supplied for you.

For each test, use a tiny input whose result you can determine independently.
Write a brief comment naming a plausible mistake that the test could reveal.

Save and rerun `source("run_tests.R")`. If a test fails at this stage, compare the
specification, the expected result, the saved code, and the failure report before
changing anything.

When your tests pass against the supplied working function, commit and push.

Find the run for this commit. Inspect the **Run tests** step and record what ran.
The same checks should pass on GitHub. A failure during setup is not evidence that
your test found a problem in the function.

## 5. Simulate development and try out your automatic tests

The instructor will supply a small deliberate change to `R/clean_numeric.R`.
Make only that change. Keep your test file unchanged initially.

Commit and push the changed implementation. (Pushing **deliberately** broken code is a controlled demonstration in
this disposable practice repository, not the usual development procedure!)

Does the resulting Actions run pass or fail? Record the result either way.
Compare your results with a classmate, because the same code change can produce different test results
when the unit tests check different behaviors.

If your suite missed the mistake, leave the modified implementation in place and
add a test that exposes the discrepancy with the specification. Confirm it fails
locally, then commit and push the new test so the failure is visible on GitHub.

If your original suite caught the mistake, identify the test and explain why its
input distinguishes the required behavior from the changed behavior.

## 6. Repair the implementation and preserve the evidence

Correct the implementation WITHOUT deleting or weakening the revealing test.
Save, run your full suite locally, and push the repair.

Open the new run and confirm that the tests pass. A failed run remains a record
of the old commit; repairing the code does not turn that old run green.

Finish `activity_notes.md` and commit/push it.

## What the YAML does

`.github/workflows/run-r-tests.yml` responds to pushes, checks out the pushed
revision on a GitHub-hosted Linux runner, sets up R and `testthat`, and executes:

```bash
Rscript --vanilla run_tests.R
```

The runner is not your laptop or a Pitt Slurm node. The configuration is already
complete: you do not need Docker, a container image, an R package, or a manually
configured secret to run these tests. It also includes `workflow_dispatch` for a
manual run from the Actions page if needed.

The two central questions are different:

**Test design:** what behavior should we check, using which inputs?

**Continuous integration:** how do we make those saved checks run automatically
when the repository changes?

## Troubleshooting

- **Cannot push:** verify that `origin` points to YOUR copy. Use your existing
  GitHub authentication setup, not a token pasted into project files.
- **No Actions run:** confirm the push reached GitHub and the workflow file exists
  at `.github/workflows/run-r-tests.yml` at the repository root. Check repository
  Actions settings; organization policies can restrict which actions may run.
- **An old function seems to run:** save the files and rerun `source("run_tests.R")`.
  The supplied runner reloads the saved function. Restart R and rerun if uncertain.
- **Cannot find R/ or tests/:** open the supplied project or run from the repository
  root. Students do not need to add source() calls to the test file.
- **Remote green but local red:** check that you pushed the saved files and are
  inspecting the Actions run for the right commit.
- **Setup/installation failed:** inspect which step failed; ask for help rather
  than changing expected answers or suppressing test failures.

## References

- [Create a repository from a template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)
- [GitHub Actions quickstart](https://docs.github.com/en/actions/get-started/quickstart)
- [testthat test_dir()](https://testthat.r-lib.org/reference/test_dir.html)
