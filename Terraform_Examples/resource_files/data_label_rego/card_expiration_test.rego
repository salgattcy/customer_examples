package classifier_card_expiration

test_card_expiration_pattern {
    output.card_expiration == "CARD_EXPIRATION" with input as {"card_expiration":"10/01/1971"}
}

test_card_expiration_pattern {
    output.expiration == "CARD_EXPIRATION" with input as {"expiration":"10/01/1971"}
}

test_card_expiration_pattern {
    output.credit_card_expire == "CARD_EXPIRATION" with input as {"credit_card_expire":"10/01/1971"}
}

test_card_expiration_pattern {
    output.expire_date == "CARD_EXPIRATION" with input as {"expire_date":"1/1/1900"}
}

test_card_expiration_pattern {
    output.cc_expire_date == "CARD_EXPIRATION" with input as {"cc_expire_date":"1/1/1900"}
}
