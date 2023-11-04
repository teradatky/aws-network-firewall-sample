# aws-network-firewall-sample

AWS Network Firewall を用いてドメインのホワイトリスト形式で通信制御を行うサンプル。

[解説記事](https://zenn.dev/teradatky)

## 構成図

### 一般的なアーキテクチャ

![normal architecture](/images/architecture1.png)

### 本コードで実現するアーキテクチャ

![my architecture](/images/architecture2.png)

## 使い方

```bash
git clone https://github.com/teradatky/aws-network-firewall-sample.git
cd aws-network-firewall-sample
cd environments/dev

terraform init
terraform plan
terraform apply
```

## 動作確認

1. マネジメントコンソールからセッションマネージャーで EC2 に接続 ※要 IAM ロール
1. 以下コマンドを実行

```bash
# TLS ハンドシェイク等に成功し応答が帰ってくることを確認
curl -s -v --sslv3 -m 5 https://www.google.com 1> /dev/null

# TLS ハンドシェイクに失敗し 5 秒後にタイムアウトすることを確認
curl -s -v --sslv3 -m 5 https://yahoo.co.jp 1> /dev/null
```

許可ドメインへの通信

![OK](/images/curl_ok.png)

許可外のドメインへの通信

![NG](/images/curl_ng.png)

## ディレクトリ構成

主なファイルのみ記載

```text
├── environments
│   └── dev
│       ├── main.tf
│       └── provider.tf
└── modules
    ├── ec2
    │   ├── ec2.tf
    │   ├── outputs.tf
    │   ├── security_group.tf
    │   └── variables.tf
    └── network_firewall
        ├── cloudwatch.tf
        ├── firewall.tf
        ├── outputs.tf
        ├── variables.tf
        └── vpc.tf
```
