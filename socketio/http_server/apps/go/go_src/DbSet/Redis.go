package DbSet

// redis 连接池demo
//
import (
    "github.com/garyburd/redigo/redis"
    "time"
    "log"
)

type Redis struct {
    pool *redis.Pool
}



// http://godoc.org/github.com/garyburd/redigo/redis#Pool
func NewRedisPool(server string, num int) *Redis {

    pool := &redis.Pool{
        MaxIdle:     10,
        IdleTimeout: time.Minute,
        Dial: func() (redis.Conn, error) {
            c, err := redis.Dial("tcp", server)
            if err != nil {
                return nil, err
            }

            _, err = c.Do("SELECT", num)
            return c, err
        },
    }

    return &Redis{pool}
}

func (this *Redis) Get(key string) (string, error) {
    if len(key) == 0 {
        return "", nil
    }

    conn := this.pool.Get()
    defer conn.Close()

    res, err := conn.Do("GET", key)

    log.Printf("getxx: %#v %#v %#v", key, res, err)

    if err != nil {
        return "", err
    }
    if res == nil {
        return "", nil
    }

    return redis.String(res, nil)
}


func (this *Redis) Set(key string, val string) {
    conn := this.pool.Get()
    defer conn.Close()

    conn.Do("SET", key, val)
}








