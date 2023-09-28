package classifier_imei

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) = "IMEI" {
        any([
                regex.match(
                `\d{2}-\d{6}-\d{6}-\d\d?`,
                val
                ),
                regex.match(
                `\d{15}\d?`,
                val
                ),
        ])
} else = "UNLABELED" {
        true
}
