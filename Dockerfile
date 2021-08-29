# The following digest is alpine:3.10.6
# This image has known security issues.
# Therefore, it can be used to test the scan in the GitHub Actions pipeline.
#FROM alpine@sha256:abd435b2a549002f78ec235cca4677237e6b8cfa9f7d15a2ea1e644596ff71d2
FROM alpine:3.14

ARG GOSS_VERSION
ARG TF_VERSION
ARG TFLINT_VERSION
ARG TFSEC_VERSION

RUN wget -q \
"https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip" \
&& unzip "./terraform_${TF_VERSION}_linux_amd64.zip" -d /usr/local/bin/ \
&& rm -f "./terraform_${TF_VERSION}_linux_amd64.zip"

RUN wget -q \
"https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip" \
&& unzip tflint_linux_amd64.zip -d /usr/local/bin/ \
&& rm -f ./tflint_linux_amd64.zip

RUN wget -q \
"https://github.com/liamg/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64" \
&& mv tfsec-linux-amd64 /usr/local/bin/tfsec \
&& chmod +x /usr/local/bin/tfsec

RUN wget -q "https://github.com/aelsabbahy/goss/releases/download/v${GOSS_VERSION}/goss-linux-amd64" \
&& mv goss-linux-amd64 /usr/local/bin/goss \
&& chmod +x /usr/local/bin/goss