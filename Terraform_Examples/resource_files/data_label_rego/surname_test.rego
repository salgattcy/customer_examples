package classifier_surname

test_sn_pattern {
    output.surname == "SURNAME" with input as {"surname":"Doe"}
}

test_sn_pattern {
    output.surname == "SURNAME" with input as {"surname":"Williams-Brown"}
}

test_sn_pattern {
    output.surname == "SURNAME" with input as {"surname":"Williams-Brown"}
}

test_sn_pattern {
    output.SurName == "SURNAME" with input as {"SurName":"Williams-Brown"}
}

test_sn_pattern {
    output.SurName == "SURNAME" with input as {"SurName":"Williams-Brown"}
}
