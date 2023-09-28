package classifier_dob

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "DOB" {
        any([
            lower(key) == "dob",
            lower(key) == "birthdate",
            regex.match(`^(0?[1-9]|1[0-2])[\/](0?[1-9]|[12]\d|3[01])[\/](19|20)\d{2}$`, val)
            ])
} else = "UNLABELED" {
        true
}
