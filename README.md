# docker-by-terraform

Terraform で Docker を構成管理する

## 準備

以下のクライアントツールをインストールする
- docker
- terraform
- mysql

## 目標

以下の状態を Terraform で実現する
- ホスト側の 8080 からコンテナ内の NGINX サーバにアクセスできる
- ホスト側の 3306 からコンテナ内の MySQL サーバにアクセスできる

## 使い方

### 構築

更新差分を表示
```sh
$ terraform plan
```

適用
```sh
$ terraform apply
```

### 動作確認

イメージのリストを取得
```sh
$ docker image ls
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
mysql        5.7       938b57d64674   17 hours ago   448MB
nginx        latest    87a94228f133   7 days ago     133MB
```

コンテナのリストを取得
```sh
$ docker container ls
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                               NAMES
5ccba6dd3188   938b57d64674   "docker-entrypoint.s…"   7 minutes ago    Up 7 minutes    33060/tcp, 0.0.0.0:3308->3306/tcp   mysql
c9159e967e1a   87a94228f133   "/docker-entrypoint.…"   21 minutes ago   Up 21 minutes   0.0.0.0:8080->80/tcp                nginx
```

NGINX サーバに疎通確認
```sh
$ curl http://localhost:8080
```

MySQL サーバに接続確認
```
$ mysql -u docker -ppassword -h 127.0.0.1 -P 3308 my_db
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.7.36 MySQL Community Server (GPL)

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

### 削除

Terraform で管理しているリソースを削除
```sh
$ terraform destroy
```
