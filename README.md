# PFCバランサー
食事を管理するサイトです。  
いつ何をどれだけ食べたかを記録し管理することができます。  
一つのページで食事の管理ができます。また、カレンダー機能を使い日毎のカロリーをひと目で確認できます。
![スクリーンショット 2021-05-12 9 43 35](https://user-images.githubusercontent.com/73508583/117901889-434a0700-b307-11eb-96b9-f7e21163e73c.png)

## 使用技術
* Ruby 2.6.6  
* Ruby on Rails 6.1.3.1  
* MySQL 8.0.23  
* Nginx  
* Puma  
* AWS  
 * VPC  
 * EC2  
 * RDS  
 * Route53  
 * Certificate Manager  
* Docker/Docker-compose  
* RSpec  
* Oracle APEX(API)  

## AWS構成図
![ポートフォリオ構成図](https://user-images.githubusercontent.com/73508583/117901924-59f05e00-b307-11eb-886f-edd23a63273d.png)


## 機能一覧
* ユーザー登録、ログイン機能  
* 食品登録  
* 食品検索機能(OracleDBから)  
* ページネーション機能(kaminari)  
* カレンダー機能(simple_calendar)  

### テスト
* RSpec   
 * 単体テスト(model)  
 * 機能テスト(request)  
 * 統合テスト(system)  


