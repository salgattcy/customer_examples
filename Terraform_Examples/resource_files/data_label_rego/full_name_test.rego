package classifier_full_name

test_dob_pattern {
    output.full_name == "FULL_NAME" with input as {"full_name":"John Doe"}
}

test_dob_pattern {
    output.full_name == "FULL_NAME" with input as {"full_name":"Robert Williams-Brown"}
}

test_dob_pattern {
    output.fullname == "FULL_NAME" with input as {"fullname":"Robert Williams-Brown"}
}

test_dob_pattern {
    output.fullName == "FULL_NAME" with input as {"fullName":"Robert Williams-Brown"}
}

test_dob_pattern {
    output.Full_Name == "FULL_NAME" with input as {"Full_Name":"Robert Williams-Brown"}
}

test_dob_pattern {
    output.FullName == "FULL_NAME" with input as {"FullName":"Robert Williams-Brown"}
}
