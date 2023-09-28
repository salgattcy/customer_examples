package classifier_phone

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "PHONE" {
    any([
        contains(lower(key), "phone"),
        regex.match(
            `\(?\d{3}\)?[ .-]?\d{3}[ .-]?\d{4}`,
            val
        )
    ])
} else := "UNLABELED" {
        true
}


