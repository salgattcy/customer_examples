package classifier_passport

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "PASSPORT" {
        any([
                contains(lower(key), "passport"),
                contains(lower(key), "passeport"),
                regex.match(
                `^[A-PR-WYZ]{1,2}[1-9]\d\s?\d{4,6}[1-9]$`,
                val
                ),
                regex.match(
                `^[1-9]\d\s?\d{4,6}[1-9][A-PR-WY]{1,2}$`,
                val
                ),
        ])
} else := "UNLABELED" {
        true
}
