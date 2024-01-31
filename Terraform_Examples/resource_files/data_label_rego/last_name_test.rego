package classifier_last_name

test_ln_pattern {
    output.last_name == "LAST_NAME" with input as {"last_name":"Doe"}
}

test_ln_pattern {
    output.last_name == "LAST_NAME" with input as {"last_name":"Williams-Brown"}
}

test_ln_pattern {
    output.lastname == "LAST_NAME" with input as {"lastname":"Williams-Brown"}
}

test_ln_pattern {
    output.lastName == "LAST_NAME" with input as {"lastName":"Williams-Brown"}
}

test_ln_pattern {
    output.Last_Name == "LAST_NAME" with input as {"Last_Name":"Williams-Brown"}
}

test_ln_pattern {
    output.LastName == "LAST_NAME" with input as {"LastName":"Williams-Brown"}
}
