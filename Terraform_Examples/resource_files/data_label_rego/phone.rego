package classifier_phone

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "PHONE" {
    any([
        contains(lower(key), "phone"),
        regex.match(`\(?\d{3}\)?[ .-]?\d{3}[ .-]?\d{4}`, val),
        regex.match(`\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$`, val),
        regex.match(`((?:9[679]|8[035789]|6[789]|5[90]|42|3[578]|2[1-689])|9[0-58]|8[1246]|6[0-6]|5[1-8]|4[013-9]|3[0-469]|2[70]|7|1)(?:\W*\d){0,13}\d$`, val)
    ])
} else := "UNLABELED" {
        true
}


