ec2-management
==============

Control the power state of EC2 instances tagged with *Project*.

**Note: Currently this utility does not prompt for confirmation before changing the power state of all instances for a project. Use with caution!**

## Requirements
* ec2-api-tools

*You must ensure that AWS_ACCESS_KEY & AWS_SECRET_KEY are set in your environment*

## Usage

**Start all instances for a project**
```shell
$ ./ec2-management start P001
```

**Stop all instances for a project**
```shell
$ ./ec2-management stop P001
```

## Cron examples

**Start all instances at 07:00 Monday-Friday**
```shell
0 7 * * 1,2,3,4,5 $PATH_TO_EC2_MANAGEMENT/ec2-management start P001
```

**Stop all instances at 19:00 Monday-Friday**
```shell
0 19 * * 1,2,3,4,5 $PATH_TO_EC2_MANAGEMENT/ec2-management stop P001
```
