package classifier_cardholder_name

test_chn_pattern {
    output.cardholder_name == "CARDHOLDER_NAME" with input as {"cardholder_name":"John Doe"}
}

test_chn_pattern {
    output.cardholder_name == "CARDHOLDER_NAME" with input as {"cardholder_name":"Robert Williams-Brown"}
}

test_chn_pattern {
    output.cardholdername == "CARDHOLDER_NAME" with input as {"cardholdername":"Robert Williams-Brown"}
}

test_chn_pattern {
    output.cardholderName == "CARDHOLDER_NAME" with input as {"cardholderName":"Robert Williams-Brown"}
}

test_chn_pattern {
    output.cardholder_Name == "CARDHOLDER_NAME" with input as {"cardholder_Name":"Robert Williams-Brown"}
}

test_chn_pattern {
    output.cardholderName == "CARDHOLDER_NAME" with input as {"cardholderName":"Robert Williams-Brown"}
}
