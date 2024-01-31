package classifier_dob

output := {k: v |
    v := classify(k, input[k])
}

classify(key, val) := "DOB" {
        any([
            lower(key) == "dob",
            lower(key) == "birthdate",
            # mm/dd/yyyy mm-dd-yyyy mm.dd.yyyy
            regex.match(`^(0?[1-9]|1[0-2])[\/\.-](0?[1-9]|[12]\d|3[01])[\/\.-](19|20)\d{2}$`, val),
            # dd/mm/yyyy
            regex.match(`^(0?[1-9]|[12]\d|3[01])[\/\.-](0?[1-9]|1[0-2])[\/\.-](19|20)\d{2}$`, val),
            # yyyy/mm/dd
            regex.match(`^(19|20)\d{2}[\/\.-](0?[1-9]|1[0-2])[\/\.-](0?[1-9]|[12]\d|3[01])$`, val),
            ])
} else = "UNLABELED" {
        true
}
