copy "J:\Program Files (x86)\MySQL\MySQL Server 5.6\lib\*" J:\Ruby193\bin
subst X: "J:\Program Files (x86)\MySQL\MySQL Server 5.6"
call gem install mysql2 --platform=ruby -- --with-mysql-dir=x: --with-mysql-lib=J:\Ruby193\bin
subst X: /D