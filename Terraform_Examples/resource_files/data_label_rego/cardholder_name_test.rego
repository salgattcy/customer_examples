package classifier_cardholder_name

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "CARDHOLDER_NAME" {
        contains(lower(key), "cardholder")
        contains(lower(key), "name")
        regex.match(`^([A-Za-z '-]+[\sA-Za-z '-]+)$`, val)
} else = "UNLABELED" {
        true
}
