# General Instructions
Following this guide: https://github.com/GoogleCloudPlatform/terraformer

1. Create an `init.tf` file that holds the provider info then run the `terraform init` command to download the provider with the desired version.
2. Export GCP credentials then run terraformer plan to check what resources will get pulled in. You have to specify the resources you want to pull in explicitly. These will appear in the `plan.json` file. Then import the resources. You could import directly and skip the plan step.

```shell
export GOOGLE_APPLICATION_CREDENTIALS=~/.gcloud/gcloudSecretsHashiCorp/sam-gabrail-gcp-demos-8770826913f1.json
terraformer plan google --compact --projects=sam-gabrail-gcp-demos --resources=gke
terraformer import plan generated/google/sam-gabrail-gcp-demos/terraformer/global/plan.json
```

Output for plan step below:

```shell
2020/07/15 09:47:50 google importing project sam-gabrail-gcp-demos region global
2020/07/15 09:47:51 google importing... gke
2020/07/15 09:47:51 Refreshing state... google_container_cluster.tfer--vault-002D-cluster-002D-demo
2020/07/15 09:47:51 Refreshing state... google_container_node_pool.tfer--vault-002D-cluster-002D-demo_vault-002D-nodepool
2020/07/15 09:47:53 Saving planfile to generated/google/sam-gabrail-gcp-demos/terraformer/global/plan.json
```

Output for import step below:

```shell
2020/07/15 09:48:10 google Connecting.... 
2020/07/15 09:48:10 google save gke
2020/07/15 09:48:10 google save tfstate for gke
```

Here's another example (notice you need to specify the region to get instances to show up):
```shell
terraformer plan google --compact --projects=sam-gabrail-gcp-demos --resources=disks,dns,firewall,images,instanceGroups,instanceTemplates,instances,networks,nodeGroups --regions=us-central1
terraformer import plan generated/google/sam-gabrail-gcp-demos/terraformer/global/plan.json
```

One more example
```shell
terraformer import google --compact --projects=sam-gabrail-gcp-demos --resources=instances --filter=google_compute_instance=terraformer-test --regions=us-central1
```

## Next Steps

1. Once satisfied with the imported resources, go into the resource folder
2. Run `terraform init`
3. Run `terraform plan`, you'll notice no changes because the state file was imported successfully and the configuration file matches nicely.
4. You could make changes to the config file if you wish and then run `terraform apply`. Do note that there are some config options that you'll need to delete from the auto-generated config files as they become static. For example if you import an instance sitting in one zone and you want to re-create the instance in another zone, you'll have to delete the IP address that got generated because it's specific to the original zone.
5. If you want to move from OSS to TFC or TFE, you can use the CLI driven workflow. To do that do the following:
  a. You need to create a workspace in TFC and don't connect it to VCS.
  b. Make sure to add the remote backend stanza to the tf config.
  c. Make sure you have your TFC token inside of .terraformrc in the home directory. 
  d. Run `terraform init` this will migrate the state file from local to TFC/TFE
  e. You may need to remove the local state file after the migration