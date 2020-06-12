#!/bin/sh
if [ -n "$PLUGIN_DEPLOY" ]; then
    curl --http1.1 -X POST "https://cw.sun-asterisk.vn/api/v1/rooms/$CW_ROOM_ID/messages" \
        -H "Bot-Api-Token: $CW_BOT_API_TOKEN" \
        --data-urlencode "body=$CW_TO_MEMBERS [info][title][$PLUGIN_DEPLOY] Deploy $PLUGIN_REPO_BRANCH[/title]
Repo: $PLUGIN_REPO_NAME
Author: $PLUGIN_COMMIT_AUTHOR
Message: $PLUGIN_COMMIT_MESSAGE
CI link: https://civ3.sun-asterisk.vn/repositories/$PLUGIN_REPO_FULLNAME/builds/$PLUGIN_BUILD_NUMBER/logs
Details: $PLUGIN_REPO_LINK/commit/$PLUGIN_COMMIT_SHA[/info]"
fi

exit 0
