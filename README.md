# aws-networkfirewall-sample

AWS Network Firewall で アウトバウンド通信をドメインのホワイトリスト形式で行うサンプルです。

[解説記事](https://zenn.dev/teradatky)

## 構成図

### 一般的な想定アーキテクチャ

![architecture](/images/architecture1.png)

### 本コードで実現するアーキテクチャ

![architecture](/images/architecture2.png)


## 使い方

```bash
git clone https://github.com/teradatky/aws-networkfirewall-sample.git
cd aws-networkfirewall-sample
cd environments/dev

terraform init
terraform plan
terraform apply
```
