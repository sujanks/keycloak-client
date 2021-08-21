## Keycloak Admin CLI
---

### Login

```
./kcadm.sh config credentials --server http://localhost:8088/auth --realm master --user api-admin --password admin
```

### Create User

```
./kcadm.sh create users -r sample-realm -s username=karis -s firstName=Sam -s lastName=Smith -s email=sam@gmail.com -s enabled=true -o --fields id,username
```

### Add user to group
```
./kcadm.sh update users/3ffe745f-5e0f-4a51-8f12-1246909e5d20/groups/db7244d4-6319-44c1-8940-423c380e5bd6 -r sample-realm -s realm=sample-realm -s userId=3ffe745f-5e0f-4a51-8f12-1246909e5d20 -s groupId=db7244d4-6319-44c1-8940-423c380e5bd6 -n
```


### Links
```
* https://www.keycloak.org/docs/latest/server_admin/#updating-a-group
* https://github.com/keycloak/keycloak/blob/master/integration/client-cli/admin-cli/
```
