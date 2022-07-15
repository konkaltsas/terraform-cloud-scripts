resource "citrixadc_systemfile" "tf_license" {
  filename = "CNS_V8000_SERVER_PLT_Retail.lic"
  filelocation = "/nsconfig/license"
  filecontent = file("~/CNS_V8000_SERVER_PLT_Retail.lic")
}

resource "citrixadc_nsconfig_save" "tf_ns_save" {
    depends_on = [
      citrixadc_systemfile.tf_license
    ]
    all        = true
    timestamp  = "2020-03-24T12:37:06Z"
}

resource "citrixadc_rebooter" "tf_rebooter" {
  depends_on = [citrixadc_nsconfig_save.tf_ns_save]
  timestamp            = "2020-03-24T12:37:06Z"
  warm                 = true
  wait_until_reachable = false
}

resource "time_sleep" "wait_90_seconds" {
  depends_on = [citrixadc_rebooter.tf_rebooter]
  create_duration = "120s"
}