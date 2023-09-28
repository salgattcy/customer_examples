package classifier_dob

test_dob_key {
    output.dob == "DOB" with input as {"dob":"test"}
}

test_dob_key {
    output.DOB == "DOB" with input as {"DOB":"test"}
}

test_dob_key {
    output.DoB == "DOB" with input as {"DoB":"test"}
}

test_dob_key {
    output.birthdate == "DOB" with input as {"birthdate":"test"}
}

test_dob_key {
    output.BirthDate == "DOB" with input as {"BirthDate":"test"}
}

test_dob_pattern {
    output.message == "DOB" with input as {"message":"01/01/1900"}
}

test_dob_pattern {
    output.message == "DOB" with input as {"message":"1/1/1900"}
}

test_dob_pattern {
    output.message == "DOB" with input as {"message":"10/01/1971"}
}

test_dob_pattern {
    output.message == "DOB" with input as {"message":"11/30/2023"}
}
