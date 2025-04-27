# Layer zip 로딩
resource "aws_lambda_layer_version" "google_auth_layer" {
  layer_name           = "google-auth-layer"
  filename             = "${path.module}/layer.zip"
  compatible_runtimes  = ["python3.10"]
  source_code_hash     = filebase64sha256("${path.module}/layer.zip")
}