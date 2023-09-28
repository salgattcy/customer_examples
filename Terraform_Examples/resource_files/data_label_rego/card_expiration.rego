package classifier_card_expiration

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "CARD_EXPIRATION" {
        any([
            contains(lower(key), "card"),
            contains(lower(key), "expire"),
            contains(lower(key), "credit"),
            contains(lower(key), "expiration")
            ])
        regex.match(`^(0?[1-9]|1[0-2])[\/](0?[1-9]|[12]\d|3[01])[\/](19|20)\d{2}$`, val)
} else = "UNLABELED" {
        true
}
