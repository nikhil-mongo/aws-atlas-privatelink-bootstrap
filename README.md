# Example - AWS and Atlas PrivateLink with Terraform

This project aims to provide an example of setting up PrivateLink connection between AWS and MongoDB Atlas.
The differnece from the generic example is that this aims to read from the state file of a different directory as the resource `mongodbatlas_privatelink_endpoint` needs to be created only once in a region and can be bootstrapped seperately.


## Dependencies

* Terraform v1.1.4
* An AWS account - provider registry.terraform.io/hashicorp/aws v4.0.0
* A MongoDB Atlas account - provider registry.terraform.io/mongodb/mongodbatlas v1.2.0

## Usage

**1\. Ensure your AWS and MongoDB Atlas credentials are set up.**

This can be done using environment variables:

``` bash
$ export AWS_SECRET_ACCESS_KEY='your secret key'
$ export AWS_ACCESS_KEY_ID='your key id'
```

```bash
export MONGODB_ATLAS_PUBLIC_KEY="xxxx"
export MONGODB_ATLAS_PRIVATE_KEY="xxxx"
```

... or the `~/.aws/credentials` file.

```
$ cat ~/.aws/credentials
[default]
aws_access_key_id = your key id
aws_secret_access_key = your secret key

```
... or follow as in the `variables.tf` file and create **terraform.tfvars** file with all the variable values and make sure **not to commit it**.

**2\. Review the Terraform plan.**

Execute the below command and ensure you are happy with the plan.

directory - ./bootstrap/

```bash
$ terraform plan
```

This will deploy the resource `mongodbatlas_privatelink_endpoint` and output the below values - 

- endpoint_service_name
- private_link_id

directory - ./network/

``` bash
$ terraform plan
```
This project currently does the below deployments:

- AWS Custom VPC, Internet Gateway, Route Tables, Subnets with Public and Private access
- PrivateLink Connection at MongoDB Atlas
- Create VPC Endpoint in AWS

This directory the value of `mongodbatlas_privatelink_endpoint` resource from the tfstate file of the ../bootstrap/ directory.

**3\. Configure the security group as required.**

The security group in this configuration allows All Traffic access in Inbound and Outbound Rules.

**4\. Destroy the resources.**

Once you are finished your testing, ensure you destroy the resources to avoid unnecessary charges.

``` bash
$ terraform destroy
```
