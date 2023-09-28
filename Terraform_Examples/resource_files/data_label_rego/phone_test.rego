package classifier_phone

test_phone_key {
    output.customer_phone_number == "PHONE" with input as {"customer_phone_number":"some number"}
}

test_phone_key {
    output.phone_number == "PHONE" with input as {"phone_number":"some number"}
}

test_phone_key {
    output.phone == "PHONE" with input as {"phone":"some number"}
}

test_phone_key {
    output.telephone == "PHONE" with input as {"telephone":"some number"}
}

test_phone_key {
    output.PhoneNumber == "PHONE" with input as {"PhoneNumber":"some number"}
}

test_phone_pattern {
    output.message == "PHONE" with input as {"message":"+1-(800)-123-4567"}
}

test_phone_pattern {
    output.message == "PHONE" with input as {"message":"(123) 456-7890"}
}

test_phone_pattern {
    output.message == "PHONE" with input as {"message":"123-456-7890"}
}

test_phone_pattern {
    output.message == "PHONE" with input as {"message":"+1 (123) 456-7890"}
}

test_phone_pattern {
    output.message == "PHONE" with input as {"message":"123 456 7890"}
}
