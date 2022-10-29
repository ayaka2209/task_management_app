# README.md
## Taskモデル  
>string :title  
text :content  

## Taskモデル  
>string :title  
text :content  

## Userモデル  
>string :user_name    
string :email  
string :password_digest  
## Userモデル  
>string :user_name    
string :email  
string :password_digest  
## Labelモデル
>string :label_name

# Herokuへのデプロイ方法

1. heroku create でHerokuに新しいアプリケーションを作成します。

1. Gemfileに'net-smtp','net-imap','net-pop'を追加してbundle installする。

1. git add→git commit -m "init" を使用して、コミットします。

1. Heloku buildpackを追加する。

1. git push heroku masuter でHerokuにデプロイする。
