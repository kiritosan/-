# bus-management
数据库期末实验

## server.js为后端逻辑

采用mysql数据库存储数据，通过node.js的mysql包实现javascript与数据库的交互,通过express模块实现提供给前端的api

## www中为打包后的前端文件

使用Vue框架进行编写,使用axios库进行网络请求

## 运行方式

进入到bus-management根目录

运行 ```node server.js```

注意：需要本地有定制的mysql数据库

bus-management.sql用来创建数据库、数据表以及导入示例数据

在sql.config.js里面写用来连接mysql的配置文件