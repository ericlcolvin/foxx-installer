#!/bin/sh

until $(curl --output /dev/null --silent --head --fail $ARANGO_URL); do
  sleep 5
done

zip -rq app.zip /app
FILENAME=$(curl --silent -F file=@app.zip "$ARANGO_URL/_db/_system/_api/upload?multipart=true" | jq -r '.filename')
curl --silent -X PUT -H "Content-Type: application/json" -d '{"appInfo":"'"$FILENAME"'", "mount":"'"$MOUNTPATH"'"}' "$ARANGO_URL/_db/_system/_admin/foxx/install"
