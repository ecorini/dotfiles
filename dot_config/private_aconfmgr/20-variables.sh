AconfNeedProgram bw bitwarden-cli n
AconfNeedProgram jq jq n

# user secrets
local user_linux_item=pc/user_linux
local user_json=$(bw get item $user_linux_item)
local user_name=$(echo $user_json | jq -r .login.username) 
local user_salt=$(echo $user_json | jq -r .fields[0].value)
local user_password=$(echo $user_json | jq -r .login.password)
USER_HASHED_PASSWORD=$(openssl passwd -6 -salt $user_salt $user_password)
USER_NAME=$user_name
USER_UID=1000
USER_GID=1000
USER_HOME=/home/$user_name

# goodcloud secrets
local goodcloud_item=cloud/thegood.cloud
local goodcloud_json=$(bw get item $goodcloud_item)
GOODCLOUD_LOGIN=$(echo $goodcloud_json | jq -r .login.username)
GOODCLOUD_PASSWORD=$(echo $goodcloud_json | jq -r .login.password)
GOODCLOUD_URL=$(echo $goodcloud_json | jq -r .login.uris[0].uri)


LOCALE=en_US.UTF-8
KEYMAP=it
