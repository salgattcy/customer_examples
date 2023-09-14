package classifier

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) = "PHONE" {
        re_match(
                `\A((1(-| )?((\([2-9]\d{2}\))|([2-9]\d{2})))|([2-9]\d{2})|(\([2-9]\d{2}\)))(-| )?[2-9]((1[02-9])|([02-9]\d))(-| )?\d{4}\z`,
                val
        )
} else = "UNLABELED" {
        true
}
