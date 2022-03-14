# Test of Simple Script Deployment
Use the netsuite cli to deploy a script via automation

Netsuite CLI: https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_4345767112.html

## Secrets

Using secret files with the format of to iterate through the build (one element for each Netsuite account that needs to recieve the package)

```
[
  {
    "NetsuiteAccount": "tstxxxxxx",
    "Name": "AuraDev",
    "TokenId": "1166xxxxx",
    "TokenSecret": "3fe9xxxxx"
  }
]
```

## SuiteCloud account:savetoken

Need to create a temp token on a build server

``` bash
suitecloud account:savetoken --authid DeployTokenAccount --account TSTDRV2294847 --tokenid xxx --tokensecret xxx
```

## Removed Production Code

Removed the contents of restlets in SDF Account cusomization packages as the goal of this repo is to show a pattern for packaging and deployment.
