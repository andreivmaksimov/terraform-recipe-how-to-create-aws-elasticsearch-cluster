<p align="center">
  <a href="https://dev-ops-notes.com/terraform/terraform-recipe-how-to-create-aws-elasticsearch-cluster/" target="_blank"><img src="https://i1.wp.com/dev-ops-notes.com/wp-content/uploads/sites/2/2018/11/Terraform-recipe-How-to-create-AWS-ElasticSearch-cluster.png?w=1024&ssl=1"></a>
</p>

This is full source code to the article [Terraform recipe - How to create AWS ElasticSearch cluster](https://dev-ops-notes.com/terraform/terraform-recipe-how-to-create-aws-elasticsearch-cluster/)

## Launch instructions

Modify `defaults.tfvar` according to your needs.

Execute the following commands:

```
terraform init
terraform plan -var-file=defaults.tfvar
terraform apply -var-file=defaults.tfvar
```

&copy; [Andrei Maksimov](https://www.linkedin.com/in/avmaksimov/) / [Dev-Ops-Notes.com](https://dev-ops-notes.com)
