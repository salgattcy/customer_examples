package classifier

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) = "AGE" {
       lower(key) == "age"
        re_match(
                `\A((\d{1,2})|1[0-1]\d)\z`,
                val
        )
} else = "UNLABELED" {
        true
}
