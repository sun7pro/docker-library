# Introduction
Plugin for [Sun*CI](https://civ3.sun-asterisk.vn/document)

Send message to Chatwork using https://cw.sun-asterisk.vn/

# Usage
Setting secret in CI dashboard:

|Variable|Value|
|--------|-----|
| `CW_TO_MEMBERS` | List members receive notifications or all members `[toall]` |
| `CW_ROOM_ID` | Chatwork Room ID |
| `CW_BOT_API_TOKEN` | Token get from https://cw.sun-asterisk.vn/ |

Example `framgia-ci.yml`:
```yml
deploy:
  server_test:
    image: framgiaciteam/deployer:latest
    when:
      branch: develop
    run: php deployer.phar deploy
  server_test_cw_notification:
    image: sun7pro/sunci-cw-bot-api:v1
    cw_bot_api_token: $$cw_bot_api_token
    cw_room_id: $$cw_room_id
    cw_to_members: $$cw_to_members
    when:
      branch: develop
      status: [success, failed]
```
