package classifier_first_name

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "FIRST_NAME" {
        contains(lower(key), "first")
        contains(lower(key), "name")
        regex.match(`^[A-Za-z '-]{2,26}$`, val)
} else = "UNLABELED" {
        true
}
