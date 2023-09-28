package classifier_puk_number

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) = "PUK_NUMBER" {
        any([
                contains(lower(key), "puk"),
                regex.match(
                `^\d{8}$`,
                val
                ),
        ])
} else = "UNLABELED" {
        true
}
