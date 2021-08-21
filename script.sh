#!/bin/bash

filename=alpha.yaml

_realm=$(yq e '.realm' $filename)
_groupId=$(yq e '.group.id' $filename)
_userIds=`yq e '.group.users[]' $filename`

./kcadm.sh config credentials --server http://localhost:8088/auth --realm master --user api-admin --password admin -o

admin_exists=$(./kcadm.sh get realms/$_realm)
if [[ -z "$admin_exists" ]]; then
	echo "[ERROR] Realm $_realm does not exist"
	exit 1
fi

group_exists=$(./kcadm.sh get groups/$_groupId -r $_realm)
if [[ -z "$group_exists" ]]; then
	echo "[ERROR] Group $_groupId does not exist"
	exit 1
fi

for uid in $_userIds
do
	uid_exists=$(./kcadm.sh get users/$uid -r $_realm)
	if [[ -z "$uid_exists" ]]; then
		echo "[ERROR] User $uid does not exist"
	else
		./kcadm.sh update users/$uid/groups/$_groupId -r $_realm -s realm=$_realm -s userId=$uid -s groupId=$_groupId -n
		echo "[INFO] User $uid added to group $_groupId for realm $_realm"
		#./kcadm.sh delete users/$uid/groups/$_groupId -r $_realm
	fi
done

