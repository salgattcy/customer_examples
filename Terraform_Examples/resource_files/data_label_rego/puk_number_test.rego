package classifier_puk_number

test_imei_pattern {
    output.puk_number == "PUK_NUMBER" with input as {"puk_number":"98-142052-081792-8"}
}

test_imei_pattern {
    output.message == "PUK_NUMBER" with input as {"message":"08675309"}
}
