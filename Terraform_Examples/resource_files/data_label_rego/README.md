# Testing

This directory contains two files for each rego type `<pattern>.rego` and `<pattern>_test.rego`. The `<pattern>.rego` files contain the Rego code used to identify various patterns for the repo crawler. The `<pattern>_test.rego` files can be used to supply various test cases to confirm the Rego is behaving as expected.

The below sections provide two ways that these tests can be incorporated into development and release flows.

## Manually run the Open Policy Agent

You can manully run the Open Policy Agent against this directory or a single file in this directory. The example below makes use of the Open Policy Agent docker image.

```shell
% docker run -v ./:/opt/rules openpolicyagent/opa  -v test /opt/rules
PASS: 77/77

```

The above command will execute all tests defined in each of the `<pattern>_test.rego` files. You can also add the `-v` argument to output details regarding each test

```shell
 % docker run -v ./:/opt/rules openpolicyagent/opa test /opt/rules -v
/opt/rules/card_expiration_test.rego:
data.classifier_card_expiration.test_card_expiration_pattern: PASS (1.204982ms)
data.classifier_card_expiration.test_card_expiration_pattern#01: PASS (299.623µs)
data.classifier_card_expiration.test_card_expiration_pattern#02: PASS (418.156µs)
data.classifier_card_expiration.test_card_expiration_pattern#03: PASS (266.741µs)
data.classifier_card_expiration.test_card_expiration_pattern#04: PASS (257.92µs)

/opt/rules/cardholder_name.rego:
data.classifier_cardholder_name.test_dob_pattern: PASS (230.971µs)
data.classifier_cardholder_name.test_dob_pattern#01: PASS (260.868µs)
data.classifier_cardholder_name.test_dob_pattern#02: PASS (262.106µs)
data.classifier_cardholder_name.test_dob_pattern#03: PASS (219.609µs)
data.classifier_cardholder_name.test_dob_pattern#04: PASS (217.717µs)
data.classifier_cardholder_name.test_dob_pattern#05: PASS (975.858µs)

/opt/rules/cvv_test.rego:
data.classifier_cvv.test_cvv_key: PASS (1.201353ms)
data.classifier_cvv.test_cvv_key#01: PASS (326.153µs)
data.classifier_cvv.test_cvv_key#02: PASS (341.487µs)
data.classifier_cvv.test_cvv_pattern: PASS (254.81µs)
data.classifier_cvv.test_cvv_pattern#01: PASS (281.046µs)
data.classifier_cvv.test_cvv_pattern#02: PASS (318.881µs)
data.classifier_cvv.test_cvv_pattern#03: PASS (320.209µs)

/opt/rules/dob_test.rego:
data.classifier_dob.test_dob_key: PASS (429.738µs)
data.classifier_dob.test_dob_key#01: PASS (598.128µs)
data.classifier_dob.test_dob_key#02: PASS (311.673µs)
data.classifier_dob.test_dob_key#03: PASS (340.377µs)
data.classifier_dob.test_dob_key#04: PASS (219.734µs)
data.classifier_dob.test_dob_pattern: PASS (239.332µs)
data.classifier_dob.test_dob_pattern#01: PASS (293.608µs)
data.classifier_dob.test_dob_pattern#02: PASS (284.732µs)
data.classifier_dob.test_dob_pattern#03: PASS (250.077µs)

/opt/rules/first_name_test.rego:
data.classifier_first_name.test_dob_pattern: PASS (355.604µs)
data.classifier_first_name.test_dob_pattern#01: PASS (297.735µs)
data.classifier_first_name.test_dob_pattern#02: PASS (219.47µs)
data.classifier_first_name.test_dob_pattern#03: PASS (238.476µs)
data.classifier_first_name.test_dob_pattern#04: PASS (1.169865ms)
data.classifier_first_name.test_dob_pattern#05: PASS (1.265225ms)

/opt/rules/full_name_test.rego:
data.classifier_full_name.test_dob_pattern: PASS (489.132µs)
data.classifier_full_name.test_dob_pattern#01: PASS (226.373µs)
data.classifier_full_name.test_dob_pattern#02: PASS (264.415µs)
data.classifier_full_name.test_dob_pattern#03: PASS (204.249µs)
data.classifier_full_name.test_dob_pattern#04: PASS (257.854µs)
data.classifier_full_name.test_dob_pattern#05: PASS (373.542µs)

/opt/rules/imei_test.rego:
data.classifier_imei.test_imei_pattern: PASS (247.485µs)
data.classifier_imei.test_imei_pattern#01: PASS (190.699µs)

/opt/rules/last_name_test.rego:
data.classifier_last_name.test_dob_pattern: PASS (203.852µs)
data.classifier_last_name.test_dob_pattern#01: PASS (231.247µs)
data.classifier_last_name.test_dob_pattern#02: PASS (300.714µs)
data.classifier_last_name.test_dob_pattern#03: PASS (194.613µs)
data.classifier_last_name.test_dob_pattern#04: PASS (191.112µs)
data.classifier_last_name.test_dob_pattern#05: PASS (189.666µs)

/opt/rules/passport_test.rego:
data.classifier_passport.test_passport_key: PASS (343.849µs)
data.classifier_passport.test_passport_key#01: PASS (236.4µs)
data.classifier_passport.test_passport_pattern: PASS (215.661µs)
data.classifier_passport.test_passport_pattern#01: PASS (249.519µs)
data.classifier_passport.test_passport_pattern#02: PASS (261.045µs)
data.classifier_passport.test_passport_pattern#03: PASS (230.517µs)
data.classifier_passport.test_passport_pattern#04: PASS (219.528µs)
data.classifier_passport.test_passport_pattern#05: PASS (255.444µs)
data.classifier_passport.test_passport_pattern#06: PASS (649.166µs)
data.classifier_passport.test_passport_pattern#07: PASS (1.212033ms)
data.classifier_passport.test_passport_pattern#08: PASS (1.408683ms)
data.classifier_passport.test_passport_pattern#09: PASS (487.374µs)
data.classifier_passport.test_passport_pattern#10: PASS (528.074µs)

/opt/rules/phone_test.rego:
data.classifier_phone.test_phone_key: PASS (260.118µs)
data.classifier_phone.test_phone_key#01: PASS (320.226µs)
data.classifier_phone.test_phone_key#02: PASS (194.301µs)
data.classifier_phone.test_phone_key#03: PASS (270.413µs)
data.classifier_phone.test_phone_key#04: PASS (187.467µs)
data.classifier_phone.test_phone_pattern: PASS (460.349µs)
data.classifier_phone.test_phone_pattern#01: PASS (192.885µs)
data.classifier_phone.test_phone_pattern#02: PASS (190.415µs)
data.classifier_phone.test_phone_pattern#03: PASS (222.826µs)
data.classifier_phone.test_phone_pattern#04: PASS (191.977µs)

/opt/rules/puk_number_test.rego:
data.classifier_puk_number.test_imei_pattern: PASS (228.517µs)
data.classifier_puk_number.test_imei_pattern#01: PASS (196.792µs)

/opt/rules/surname_test.rego:
data.classifier_surname.test_dob_pattern: PASS (224.174µs)
data.classifier_surname.test_dob_pattern#01: PASS (222.67µs)
data.classifier_surname.test_dob_pattern#02: PASS (188.556µs)
data.classifier_surname.test_dob_pattern#03: PASS (186.654µs)
data.classifier_surname.test_dob_pattern#04: PASS (184.144µs)
--------------------------------------------------------------------------------
PASS: 77/77

```

## Use a Github Action to run the Open Policy Agent

In addition to running the Open Policy Agent on the command line, you can make it part of your commits as a GitHub Action. The below example assumes that you create this Action as `opa.yml` but you are welcome to change that. If you do change the name, be sure to update the `paths` statement.

This Action also assumes that you have all of the rego files in the same directory (customer_examples/Trrraform_Examples/resource_files/data_label_rego). 

Finally, you'll notice that this includes a [Matrix](https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs) that will allow you to place the Rego files in multiple directories. If you have Rego tests in multiple directories, then you can update the `package` attribute such as:

```yaml
...
    runs-on: ubuntu-latest
    strategy:
      matrix:
        package:
          - customer_examples/Terraform_Examples/resource_files/data_label_rego
          - another_directory/data_label_rego
          - test_examples/rego
...
```

```yaml
name: Test Rego Policies

on:
  push:
    paths:
      - 'customer_examples/Terraform_Examples/resource_files/data_label_rego/*'
      - '.github/workflows/opa.yml'

jobs:
  Run-OPA-Tests:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        package:
          - customer_examples/Terraform_Examples/resource_files/data_label_rego

    steps:
    - name: Check out repository code
      uses: actions/checkout@v3

    - name: Setup OPA
      uses: open-policy-agent/setup-opa@v2
      with:
        version: latest

    - name: Run Rego Policy Tests
      run: opa test ${{ matrix.package }} -v

```