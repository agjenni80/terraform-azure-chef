resource "azurerm" "web" {
  # ...

  provisioner "chef" {
    attributes_json = <<-EOF
      {
        "key": "value",
        "app": {
          "cluster1": {
            "nodes": [
              "webserver1",
              "webserver2"
            ]
          }
        }
      }
    EOF

    environment     = "_default"
    run_list        = ["cookbook::recipe"]
    node_name       = "webserver1"
    secret_key      = "${file("../encrypted_data_bag_secret")}"
    server_url      = "https://api.chef.io/organizations/ajennings"
    recreate_client = true
    user_name       = "ajennings"
    user_key        = "${file("../ajennings-chef.pem")}"
    version         = "12.4.1"
    # If you have a self signed cert on your chef server change this to :verify_none
    ssl_verify_mode = ":verify_none"
  }
}
