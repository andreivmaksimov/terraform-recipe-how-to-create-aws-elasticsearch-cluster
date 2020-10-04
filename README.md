<p align="center">
  <a href="https://hands-on.cloud/terraform-recipe-how-to-create-aws-elasticsearch-cluster/" target="_blank"><img src="https://hands-on.cloud/terraform-recipe-how-to-create-aws-elasticsearch-cluster/Terraform-recipe-How-to-create-AWS-ElasticSearch-cluster.png"></a>
</p>

This is full source code to the article [Terraform recipe - How to create AWS ElasticSearch cluster](https://hands-on.cloud/terraform-recipe-how-to-create-aws-elasticsearch-cluster/)

## Launch instructions

Modify `defaults.tfvar` according to your needs.

Execute the following commands:

```
terraform init
terraform plan -var-file=defaults.tfvar
terraform apply -var-file=defaults.tfvar
```

&copy; [Andrei Maksimov](https://www.linkedin.com/in/avmaksimov/) / [Hands-on.Cloud](https://hands-on.cloud)
