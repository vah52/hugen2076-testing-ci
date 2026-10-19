# Replace caller-specified missing codes and values outside inclusive limits.
# Preserve the length and order of the input vector and existing NA values.
# For this demo, assume numeric inputs and valid scalar limits lower <= upper.
clean_numeric <- function(values, missing_codes = numeric(0),
                          lower = -Inf, upper = Inf) {
    values[values %in% missing_codes] <- NA

    outside_range <- !is.na(values) &
        (values < lower | values > upper)
    values[outside_range] <- NA

    return(values)
}
