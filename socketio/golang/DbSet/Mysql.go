package DbSet

// https://github.com/go-xorm/xorm
// https://www.kancloud.cn/kancloud/xorm-manual-zh-cn/56013
import (
    _ "github.com/go-sql-driver/mysql"
    "github.com/go-xorm/xorm"
    "fmt"
)

var engine *xorm.Engine

func mysqlEngine() (*xorm.Engine, error) {
    return xorm.NewEngine("mysql", "root:123456@/test?charset=utf8")
}

func mysql_get() {
    engine, err := mysqlEngine()
    if err != nil {
        fmt.Println(err)
        return
    }
    defer engine.Close()
    // test(engine)

    results, err := engine.Query("select * from users limit 3")

    fmt.Println("users2:", results)

}





