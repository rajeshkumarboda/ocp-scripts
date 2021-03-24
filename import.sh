#!/bin/bash
export MYSQL_PWD=$MYSQL_PASSWORD
export HOOK_RETRIES=3
export HOOK_SLEEP=100
echo 'Downloading SQL script that initializes the database...'
curl -s -O https://raw.githubusercontent.com/rajeshkumarboda/ocp-scripts/main/users.sql
echo "Trying $HOOK_RETRIES times, sleeping $HOOK_SLEEP sec between tries:"
sleep HOOK_SLEEP
if [ "$HOOK_RETRIES" = 0 ]; then
echo 'Too many tries, giving up'
exit 1
fi
# Run the SQL script
if mysql -h$MYSQL_SERVICE_HOST -u$MYSQL_USER -P3306
$MYSQL_DATABASE < users.sql
then
echo 'Database initialized successfully'
else
echo 'Failed to initialize database'
exit 2
fi
