# MySQL Docker Backuper

Docker image for making backups of mysql/mariadb databases and export to AWS S3. It export gzipped backup to AWS S3.

> This is a simple project for backup to S3. It can easily be adapted for other services (Digital Ocean Spaces, Azure Blob Storage...). I use only S3 for this, but if anyone need for another service, create an issue and let's to it :)

## Running

Start a new service passing the required parameters.

```sh
docker service create \
    --env DB_USER=$DB_USER \
    --env DB_PASSWORD=$DB_PASSWORD \
    --env DB_DATABASE=$DB_DATABASE \
    --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    --env AWS_BUCKET=$AWS_BUCKET \
    --network my-network \
    rafaelhdr/mysql-docker-backuper:0.1
```

## Parameters

* DB_USER
* DB_PASSWORD
* DB_DATABASE
* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* AWS_SECRET_ACCESS_KEY
* AWS_BUCKET - The name of the bucket, but can append a path, for example `mybucket/path/to/some/directory`

## Example

Set AWS environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_BUCKET`) and run the commands below:

```sh
docker network create -d bridge my-network

docker run \
    -d \
    --rm \
    --name my-db-host \
    --env MYSQL_ROOT_PASSWORD=my-password \
    --env MYSQL_DATABASE=my-db \
    --network my-network \
    mysql:8.0

docker run \
    -d \
    --rm \
    --name my-backuper \
    --env DB_HOST=my-db-host \
    --env DB_USER=root \
    --env DB_PASSWORD=my-password \
    --env DB_DATABASE=my-db \
    --env AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    --env AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    --env AWS_BUCKET=$AWS_BUCKET \
    --network my-network \
    rafaelhdr/mysql-docker-backuper:0.1
```

Check the database backup at your AWS S3.
