filename=$(date +"%s")

./wait-for ${DB_HOST}:3306 -t 60 -- echo "Connected to DB"
if [ "$?" != "0" ]; then
    echo "Could not connect to DB"
    exit 1
fi

mysqldump \
    -h ${DB_HOST} \
    -u ${DB_USER} \
    --password=${DB_PASSWORD} \
    $DB_DATABASE > ${filename}.sql

gzip ${filename}.sql

aws s3 cp ${filename}.sql.gz s3://${AWS_BUCKET}/${filename}.sql.gz

# Sleep for swarm container verification
# This avoid creation of multiple containers on swarm mode
sleep 10
