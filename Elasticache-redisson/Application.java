package redis.demo;

import java.util.List;
import java.util.Queue;
import java.util.Set;
import java.util.concurrent.ConcurrentMap;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.redisson.config.Config;
import org.redisson.Redisson;
import org.redisson.api.RBucket;
import org.redisson.api.RedissonClient;
public class Application 
{
    public static void main( String[] args )
    {
        System.out.println("connecte started---->");
        Config config = new Config();
        config.useReplicatedServers()
                .addNodeAddress("redis://newtest.XXX.cache.amazonaws.com:6379","redis://newtest-ro.XXX.0001.usw2.cache.amazonaws.com:6379");
            //   .addNodeAddress("rediss://master.myredis.czk7kt.usw2.cache.amazonaws.com:6379","rediss://replica.myredis.czk7kt.usw2.cache.amazonaws.com:6379")
            //   .setPassword("YourPasword");
        RedissonClient redisson = Redisson.create(config);
        System.out.println("connected to redis");
        //循环写入和读取数据的代码
        //for(int i=0;i<1000;i++){redisson.getBucket("key"+i).set("value"+i);System.out.println(redisson.getBucket("key"+i).get());}
        //for(int i=0;i<1000;i++){System.out.println(redisson.getBucket("key"+i).get());}
        for (int i = 0; i < 10000; i++) {

            // 获取一个字符串对象
            RBucket<String> bucket = redisson.getBucket("aaa:"+i);

            // 设置数据
            bucket.set(i+"-"+"safasdfasdfasdfdafdadsfafasdfadsadfakljljljljljljljljljsafasdfasdfasdfdafdadsfafasdfadsadfakljljljljljljljljljsafasdfasdfasdfdafdadsfafasdfadsadfakljljljljljljljljljsafasdfasdfasdfdafdadsfafasdfadsadfakljljljljljljljljljsafasdfasdfasdfdafdadsfafasdfadsadfakljljljljljljljljljsafasdfasdfasdfdafdadsfafasdfadsadfakljljljljljljljljljsafasdfasdfasdfdafdadsfafasdfadsadfakljljljljljljljljljsafasdfasdfasdfdafdadsfafasdfadsadfakljljljljljljljljlj");
            for (int j = 0; j < 10; j++) {
                Object r = bucket.get();
                System.out.println(i + " - " + r);
            }
        }
        redisson.shutdown();
    }
}