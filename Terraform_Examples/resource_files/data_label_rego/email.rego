package classifier

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) = "EMAIL" {
        re_match(
                `\A[A-Za-z0-9][A-Za-z0-9._%+-]*@[A-Za-z0-9]((\.[A-Za-z0-9])|(-[A-Za-z0-9])|[A-Za-z0-9])*\.[A-Za-z]{2,}\z`,
                val
        )
} else = "UNLABELED" {
        true
}
