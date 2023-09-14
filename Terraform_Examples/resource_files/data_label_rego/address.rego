package classifier

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) = "ADDRESS" {
        any([lower(key) == "state",
              re_match(`\A.*address.*\z`, lower(key)),
              lower(key) == "zip",
              lower(key) == "zipcode",
              re_match(`\Astreet.*\z`, lower(key))])
} else = "UNLABELED" {
        true
}
