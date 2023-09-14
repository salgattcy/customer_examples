package classifier_cnid

output := {k: v | v := classify(k, input[k])}

classify(key, val) = "TEST_CNID" {
	any([re_match(`(?:[1-9]\d{5})(?:(?:1[89]\d{2}|2\d{3})(?:0[1-9]|1[012])(?:0[1-9]|[12][0-9]|3[01]))\d{2}(?:\d)(?:[0-9xX])`, val)])
}

else = "UNLABELED"
