resource "citrixadc_nsfeature" "tf_nsfeature" {
  appfw = true
}

resource citrixadc_appfwprofile terraform_lb_appfwprofile {
  depends_on = [citrixadc_nsfeature.tf_nsfeature]
  name = "terraform_terraform_lb_appfwprofile"
  bufferoverflowaction = ["none"]
  contenttypeaction = ["none"]
  cookieconsistencyaction = ["none"]
  creditcard = ["none"]
  creditcardaction = ["none"]
  crosssitescriptingaction = ["log"]
  csrftagaction = ["none"]
  denyurlaction = ["none"]
  dynamiclearning = ["none"]
  fieldconsistencyaction = ["none"]
  fieldformataction = ["none"]
  fileuploadtypesaction = ["none"]
  inspectcontenttypes = ["none"]
  jsondosaction = ["none"]
  jsonsqlinjectionaction = ["log"]
  jsonxssaction = ["none"]
  multipleheaderaction = ["none"]
  sqlinjectionaction = ["block"]
  starturlaction = ["none"]
  type = ["HTML", "XML", "JSON"]
  xmlattachmentaction = ["none"]
  xmldosaction = ["none"]
  xmlformataction = ["none"]
  xmlsoapfaultaction = ["none"]
  xmlsqlinjectionaction = ["log"]
  xmlvalidationaction = ["none"]
  xmlwsiaction = ["none"]
  xmlxssaction = ["none"]
}

resource citrixadc_appfwprofile terraform_global_appfwprofile {
  depends_on = [citrixadc_nsfeature.tf_nsfeature]
  name = "terraform_global_appfwprofile"
  bufferoverflowaction = ["none"]
  contenttypeaction = ["none"]
  cookieconsistencyaction = ["none"]
  creditcard = ["none"]
  creditcardaction = ["none"]
  crosssitescriptingaction = ["none"]
  csrftagaction = ["none"]
  denyurlaction = ["none"]
  dynamiclearning = ["none"]
  fieldconsistencyaction = ["none"]
  fieldformataction = ["none"]
  fileuploadtypesaction = ["none"]
  inspectcontenttypes = ["none"]
  jsondosaction = ["none"]
  jsonsqlinjectionaction = ["none"]
  jsonxssaction = ["none"]
  multipleheaderaction = ["none"]
  sqlinjectionaction = ["log"]
  starturlaction = ["none"]
  type = ["HTML"]
  xmlattachmentaction = ["none"]
  xmldosaction = ["none"]
  xmlformataction = ["none"]
  xmlsoapfaultaction = ["none"]
  xmlsqlinjectionaction = ["none"]
  xmlvalidationaction = ["none"]
  xmlwsiaction = ["none"]
  xmlxssaction = ["none"]
}

resource citrixadc_appfwpolicy terraform_lb_appfwpolicy {
    name = "terraform_lb_appfwpolicy"
    profilename = citrixadc_appfwprofile.terraform_lb_appfwprofile.name
    rule = "true"
}

resource citrixadc_appfwpolicy terraform_global_appfwpolicy {
    name = "terraform_global_appfwpolicy"
    profilename = citrixadc_appfwprofile.terraform_global_appfwprofile.name
    rule = "true"
}

resource citrixadc_appfwglobal_appfwpolicy_binding global_appfw_policy_binding {
    policyname = citrixadc_appfwpolicy.terraform_global_appfwpolicy.name
    priority   = 30
    state      = "ENABLED"
    type       = "REQ_DEFAULT"
}

resource citrixadc_lbvserver_appfwpolicy_binding terraform_lb_appfw_policy_binding {
  name                   = "terraform_lbvserver"
  policyname             = citrixadc_appfwpolicy.terraform_lb_appfwpolicy.name
  priority               = 100
  bindpoint              = "REQUEST"
}


resource "citrixadc_nsconfig_save" "tf_ns_save_waf" {
    all        = true
    timestamp  = "2020-06-20T12:37:06Z"

    depends_on = [
      citrixadc_appfwglobal_appfwpolicy_binding.global_appfw_policy_binding,
      citrixadc_lbvserver_appfwpolicy_binding.terraform_lb_appfw_policy_binding
    ]
}