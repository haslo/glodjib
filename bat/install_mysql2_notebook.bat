copy "D:\mysql\lib\*" C:\Ruby193\bin
subst X: "D:\mysql"
call gem install mysql2 --platform=ruby -- --with-mysql-dir=x: --with-mysql-lib=C:\Ruby193\bin
subst X: /D