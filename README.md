# thomaslomas/mysql-s3cmd-cron

This image provides an easy way to backup all databases and upload to S3 scheduled by a cron. This is designed to be a lightweight image built on alpine 3.3.

## Installation

    docker pull thomaslomas/mysql-s3cmd-cron

## Example Usage

    docker run -it --rm --env AWS_ACCESS_KEY="ABC123" --env AWS_SECRET_KEY="dfdsfsf/234234fgf/example" --env AWS_BUCKET=s3://my-backup-bucket --env AWS_BUCKET_LOCATION=EU -v /var/important-folder:/backup --env BACKUP_SCHEDULE="0 * * * *" --env MYSQL_USER="backupuser" --env MYSQL_PASSWORD="backuppass" --link=mysql:mysql thomaslomas/mysql-s3cmd-cron

## Environmental Variables

| Key                 | Required | Default   | Description                                                                        |
|---------------------|----------|-----------|------------------------------------------------------------------------------------|
| AWS_ACCESS_KEY      | Y        |           | This is your AWS Access Key                                                        |
| AWS_SECRET_KEY      | Y        |           | This is your AWS Secret Key                                                        |
| AWS_BUCKET          | Y        |           | This is the full bucket path of where to put the files. E.g. "s3://my-bucket-name" |
| AWS_BUCKET_LOCATION | N        | US        | This is the AWS bucket location                                                    |
| BACKUP_SCHEDULE     | N        | 0 3 * * * | This is how often the cron should execute. This defaults to 3am                    |
| MYSQL_USER          | Y        |           | This is the username in which to connect to MySQL as                               |
| MYSQL_PASSWORD      | Y        |           | This is the password in which to connect to MySQL as                               |

## Required Link

Your MySQL container should be linked with the name `mysql`.
