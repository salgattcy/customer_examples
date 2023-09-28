package classifier_cvv

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "CVV" {
        any([
            lower(key) == "cvv",
            regex.match(`^\d{3,4}$`, val)
            ])
} else := "UNLABELED" {
        true
}
