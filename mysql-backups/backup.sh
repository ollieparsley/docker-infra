#/bin/sh

DUMP=$CURRENT_DATABASE`date +$BACKUP_TIMESTAMP`.sql

# Perform the database backup. Put the output to a variable. If successful upload the backup to S3, if unsuccessful print an entry to the console and the log, and set has_failed to true.
if sqloutput=$(mysqldump -u $TARGET_DATABASE_USER -h $TARGET_DATABASE_HOST -p$TARGET_DATABASE_PASSWORD -P $TARGET_DATABASE_PORT $TARGET_DATABASE_NAME 2>&1 > /tmp/$DUMP)
then
    echo -e "Database backup successfully completed for $TARGET_DATABASE_NAME at $(date +'%d-%m-%Y %H:%M:%S')."

    # Perform the upload to S3. Put the output to a variable. If successful, print an entry to the console and the log. If unsuccessful, set has_failed to true and print an entry to the console and the log
    if awsoutput=$(aws s3 cp /tmp/$DUMP s3://$AWS_BUCKET_NAME$AWS_BUCKET_BACKUP_PATH/$DUMP 2>&1)
    then
        echo -e "Database backup successfully uploaded for $TARGET_DATABASE_NAME at $(date +'%d-%m-%Y %H:%M:%S')."
    else
        echo -e "Database backup failed to upload for $TARGET_DATABASE_NAME at $(date +'%d-%m-%Y %H:%M:%S'). Error: $awsoutput" | tee -a /tmp/kubernetes-s3-mysql-backup.log
    fi
else
    echo -e "Database backup FAILED for $CURRENT_DATABASE at $(date +'%d-%m-%Y %H:%M:%S'). Error: $sqloutput" | tee -a /tmp/kubernetes-s3-mysql-backup.log
fi
