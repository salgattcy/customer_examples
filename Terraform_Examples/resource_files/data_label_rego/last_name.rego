package classifier_last_name

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "LAST_NAME" {
        contains(lower(key), "last")
        contains(lower(key), "name")
        regex.match(`^[A-Za-z '-]{2,26}$`, val)
} else = "UNLABELED" {
        true
}
