package classifier_surname

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "SURNAME" {
        contains(lower(key), "sur")
        contains(lower(key), "name")
        regex.match(`^[A-Za-z '-]{2,26}$`, val)
} else = "UNLABELED" {
        true
}
