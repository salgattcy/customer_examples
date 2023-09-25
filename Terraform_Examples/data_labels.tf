locals {
  no_code_data_labels = toset(compact((split("\n", file("./resource_files/no_code_data_labels.txt")))))
}

locals {
  data_labels_json = jsondecode(file("./resource_files/data_labels_with_code.json"))
}


resource "cyral_datalabel" "data_labels" {
  for_each = local.no_code_data_labels
  name     = each.key
  classification_rule {
    rule_status = "DISABLED"
    rule_type   = "UNKNOWN"
  }
}

resource "cyral_datalabel" "data_labels_with_code" {
  for_each = local.data_labels_json
  name        = each.value.name
  description = try(each.value.description, "")
  classification_rule {
    rule_type   = try(each.value.rule_type, "REGO")
    rule_code   = file(each.value.rule_code_file)
    rule_status = try(each.value.rule_status, "DISABLED")
  }
}
