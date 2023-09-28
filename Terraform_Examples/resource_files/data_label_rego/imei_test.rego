package classifier_imei

test_imei_pattern {
    output.message == "IMEI" with input as {"message":"98-142052-081792-8"}
}

test_imei_pattern {
    output.message == "IMEI" with input as {"message":"981420520817928"}
}
