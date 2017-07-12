package DbSet

// https://github.com/go-xorm/xorm
// https://www.kancloud.cn/kancloud/xorm-manual-zh-cn/56013
// http://blog.csdn.net/aminic/article/details/42029653
import (
    _ "github.com/go-sql-driver/mysql"
    "github.com/go-xorm/xorm"
    "fmt"
    // "time"
)

// CREATE TABLE `users` (
//   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
//   `username` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
//   `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
//   PRIMARY KEY (`id`),
//   UNIQUE KEY `users_email_unique` (`email`)
// ) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci

// 针对users表写个增，删， 改， 查 的demo


type Users struct {
    Id   int `xorm:"int(10) notnull 'id'"`
    Username string `xorm:"varchar(40) notnull 'username'"`
    Email string `xorm:"varchar(255) notnull 'email'"`
}


var engine *xorm.Engine

func mysqlEngine() (*xorm.Engine, error) {
    return xorm.NewEngine("mysql", "root:123456@/test?charset=utf8")
}

// 初始化包全局连接引擎 engine
// 关联表结构
func init_engine() {
    var err error
    engine, err = mysqlEngine()
    if err != nil {
        fmt.Println(err)
    }

    if err := engine.Sync2(new(Users)); err != nil {
        fmt.Println("Fail to sync struct to  table schema :", err)
    }
}


// 查询一条sql
func mysql_select(SelectSql string) ([]map[string]string) {
    reply := []map[string]string{}

    results, err := engine.QueryString(SelectSql)

    if err != nil {
        fmt.Println("err:", err)
        return reply
    }

    return results
}


// =================================
func mysql_get() {
    init_engine()

    Sql := "select * from users limit 3"
    rows := mysql_select(Sql)
    for k, v := range rows {
        fmt.Printf("k=%v, v=%v\n", k, v)

        fmt.Printf("k=%v, id=%v\n", k, v["id"])
        fmt.Printf("k=%v, username=%v\n", k, v["username"])
        fmt.Printf("k=%v, email=%v\n", k, v["email"])
    }
}


