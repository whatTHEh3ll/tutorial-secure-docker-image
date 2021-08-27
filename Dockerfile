FROM alpine:3.10.6

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