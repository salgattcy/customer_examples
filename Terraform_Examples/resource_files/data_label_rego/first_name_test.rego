package classifier_first_name

test_dob_pattern {
    output.first_name == "FIRST_NAME" with input as {"first_name":"John"}
}

test_dob_pattern {
    output.first_name == "FIRST_NAME" with input as {"first_name":"Robert"}
}

test_dob_pattern {
    output.firstname == "FIRST_NAME" with input as {"firstname":"Robert"}
}

test_dob_pattern {
    output.firstName == "FIRST_NAME" with input as {"firstName":"Robert"}
}

test_dob_pattern {
    output.First_Name == "FIRST_NAME" with input as {"First_Name":"Robert"}
}

test_dob_pattern {
    output.FirstName == "FIRST_NAME" with input as {"FirstName":"Robert"}
}
