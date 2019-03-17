## Saving your tfstate file in s3

**NOTE: This concept is asked frequently in cloud/devops interviews**


## terraform state file (terraform.tfstate) file
When you enter terraform apply command in a directory, terraform saves the state of the resources changed in a file called the state file that is named terraform.tfstate in your working directory.

This file is how terraform knows what to change, or destroy when you use terraform apply or destroy after creating a stack of resources.

>This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment.


In this lesson, we will store our state file remotely in S3 instead so other team members working with the resources created can change and destroy the terraform stack. This also allows to version control the state file so that chances of losing the state file by mistake is minimized.



>Remote state is a feature of backends

> A "backend" in Terraform determines how state is loaded and how an operation such as apply is executed. This abstraction enables non-local file state storage, remote execution, etc.

Keep in mind, state can be stored in other backends like consul, artifactory, azure storage etc. We will work with Amazon s3 in this lesson to store the remote file.  


```
Here are some of the benefits of backends:

Working in a team: Backends can store their state remotely and protect that state with locks to prevent corruption. Some backends such as Terraform Enterprise even automatically store a history of all state revisions.

Keeping sensitive information off disk: State is retrieved from backends on demand and only stored in memory. If you're using a backend such as Amazon S3, the only location the state ever is persisted is in S3.

Remote operations: For larger infrastructures or certain changes, terraform apply can take a long, long time. Some backends support remote operations which enable the operation to execute remotely. You can then turn off your computer and your operation will still complete. Paired with remote state storage and locking above, this also helps in team environments.
```




## Steps

0) Demo: what happens without the remote state.

1) Create a backend.tf file ( or a tf file with any name ) in your working directory. Add this as the content

```
terraform {
  backend "s3" {
    bucket = "cloudyeti-terraform"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

Replace the bucket name , region and path with your desired names. Make sure the S3 bucket exists.
**NOTE: the AWS Credentials need to have access to S3 to work with S3 as the backend to store state file**

2) Add other .tf files with resources and provider settings. We'll use this file for this example named ec2.tf


```HCL
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}
```



3) Initialize the working directory with this command

```
terraform init
```

4 ) Apply the changes with this command
```
terraform apply
```

5) In your working dirctory , you should't see any terraform.tfstate file. Instead let's go and check our s4 bucket, the state file  should be there.

6) That's the demo of remote state. Let's destroy our resources with this command

```
terraform destroy
```

## Reference
https://www.terraform.io/docs/state/index.html

https://www.terraform.io/docs/state/remote.html

https://www.terraform.io/docs/backends/index.html
