package classifier_full_name

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "FULL_NAME" {
        contains(lower(key), "full")
        contains(lower(key), "name")
        regex.match(`^([A-Za-z '-]+[\sA-Za-z '-]+)$`, val)
} else = "UNLABELED" {
        true
}
