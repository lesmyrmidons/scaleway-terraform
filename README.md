# scaleway-terraform
Test terraform with scaleway

## Requirement
Create file credentials.rc into `terraform/credentials.rc`.
Add list of keys:
```ini
# Global keys
SCW_ACCESS_KEY=ACCESS_KEY
SCW_SECRET_KEY=SECRET_KEY
SCW_DEFAULT_ORGANIZATION_ID=ORGANIZATION_ID
SCW_DEFAULT_PROJECT_ID=PROJECT_ID
# Keys for bucket S3
AWS_ACCESS_KEY_ID=ACCESS_KEY
AWS_SECRET_ACCESS_KEY=SECRET_KEY
```

I use go-task for run my command: https://taskfile.dev/#/

Usage:
```shell
$ task init # command terraform init
$ task valid # command terraform plan
```

In file `Taskfile.yml`, I use 1 env for test if linux or other:
```yaml
env:
#  TERRAFORM: '{{if eq OS "linux"}}docker run --rm -v {{.PWD}}/terraform:/data --workdir=/data --env-file credentials.rc -u $(id -u):$(id -g) hashicorp/terraform:1.0.3{{else}}terraform{{end}}'
  TERRAFORM: docker run --rm -v {{.PWD}}/terraform:/data --workdir=/data --env-file credentials.rc -u $(id -u):$(id -g) hashicorp/terraform:1.0.3
```