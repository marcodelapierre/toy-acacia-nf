## Toy pipeline to test Nextflow with Acacia (S3 Object Storage) at Pawsey

Acacia is the brand new S3 Object Storage on-premises service at Pawsey, based on CEPH software libraries and deployed in 2022.  
For information on usage, see the [Acacia User Guide](https://support.pawsey.org.au/documentation/display/US/Acacia+-+User+Guide) in the Pawsey User Documentation.


### Software requirements

The pipeline requires the following software to run:
* [Nextflow](https://github.com/nextflow-io/nextflow) to orchestrate the pipeline.  The minimum required version is `22.04.00`, as DSL2 syntax is assumed to be default
  * To run the examples using `config.aws.profile`, the minimum version is `22.12.00-edge`
* [AWS Command Line Interface (CLI)](https://aws.amazon.com/cli) to interact with S3 object storage

The setup also requires the following:
* `nextflow` and `aws` executables available in the shell environment
* AWS Credentials configured within the AWS CLI tool for all relevant S3 accounts (unless Nextflow Secrets are used)


### Configuration and runtime requirements

With the AWS Credentials properly configured as per above, the only additional configuration which is required in the pipeline configuration is:

```
aws {
  client {
    s3PathStyleAccess = true
    endpoint = "https://acacia.pawsey.org.au"
  }
}
```

where:
* `s3PathStyleAccess` is required as Acacia uses the *path-style* addressing model (compared to the AWS default, which is the *virtual-hosted style*), see also [Amazon S3 Path Deprecation Plan](https://aws.amazon.com/blogs/aws/amazon-s3-path-deprecation-plan-the-rest-of-the-story/)
* `endpoint` provides the endpoint for Acacia at Pawsey

There is an additional setting which is required, when a user has multiple S3 accounts: for instance, Pawsey researchers would at least have both a *user* and a *project* account. These accounts are mapped as *profiles* in the AWS CLI.  When using the non-default profile, this must be specified at pipeline runtime using the `AWS_PROFILE` variable:

```
AWS_PROFILE='non-default-profile' nextflow run main.nf <..>
```

With the requirements above being satisfied, the pipeline can use S3 objects as input:
```
params.input='s3://<bucket>/<input-file>'
```

and as output directory ,too:
```
publishDir 's3://<bucket>/', mode: 'copy', saveAs: { '<output-file>' }
```

Some example scripts are provided:
* `main.nf`: pipeline script (grabs an input, adds a string, stores output)
* `echo.nf`: alternative simpler pipeline script (only displays input content)
* `nextflow.config`: configuration file
* `examples.sh`: bash script for personal setup (laptop/workstation/cloud)
* `examples_setonix.sh`: bash script for Setonix (loads modules for `nextflow` and `aws`)
* `examples_secrets.sh`: bash script using secrets (see below)


### Updated configuration for profiles

Nextflow version `22.12.0-edge` implements a new configuration option to choose the AWS profile, `aws.profile`.  In this way, setting of the variable `AWS_PROFILE`, as described above, is not required any more.

The updated pipeline configuration looks as follows:

```
aws {
  profile = "non-default-profile"
  client {
    s3PathStyleAccess = true
    endpoint = "https://acacia.pawsey.org.au"
  }
}
```


### Alternative configuration using Nextflow Secrets

This alternate method makes us of [Nextflow Secrets](https://nextflow.io/docs/latest/secrets.html), a new feature.

The configuration file requires:

```
aws {
  client {
    s3PathStyleAccess = true
    endpoint = "https://acacia.pawsey.org.au"
  }
  accessKey = secrets.<account-key-name>
  secretKey = secrets.<account-secret-name>
}
```

A pair of secrets is needed for each S3 account.  Hence, if multiple accounts are used, multiple secrets have to be provided.  At the pipeline level, this can be managed for instance using configuration profiles.

See [Nextflow Secrets](https://nextflow.io/docs/latest/secrets.html) for information on how to setup Nextflow Secrets.
