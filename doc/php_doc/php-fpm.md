https://www.cnblogs.com/feng18/p/6224638.html

php-fpm优化方法

php-fpm存在两种方式，一种是直接开启指定数量的php-fpm进程，不再增加或者减少；
另一种则是开始时开启一定数量的php-fpm进程，当请求量变大时，动态的增加php-fpm进程数到上限，当空闲时自动释放空闲的进程数到一个下限。
这两种不同的执行方式，可以根据服务器的实际需求来进行调整。

要用到的一些参数，分别是pm、pm.max_children、pm.start_servers、pm.min_spare_servers和pm.max_spare_servers。

pm表示使用那种方式，有两个值可以选择，就是static（静态）或者dynamic（动态）。

下面4个参数的意思分别为：
 

pm.max_children：静态方式下开启的php-fpm进程数量，在动态方式下他限定php-fpm的最大进程数（这里要注意pm.max_spare_servers的值只能小于等于pm.max_children）
pm.start_servers：动态方式下的起始php-fpm进程数量。
pm.min_spare_servers：动态方式空闲状态下的最小php-fpm进程数量。
pm.max_spare_servers：动态方式空闲状态下的最大php-fpm进程数量。
如果dm设置为static，那么其实只有pm.max_children这个参数生效。系统会开启设置的数量个php-fpm进程。

如果dm设置为dynamic，4个参数都生效。系统会在php-fpm运行开始时启动pm.start_servers个php-fpm进程，然后根据系统的需求动态在pm.min_spare_servers和pm.max_spare_servers之间调整php-fpm进程数。

那么，对于服务器，选择哪种执行方式比较好呢？事实上，跟Apache一样，运行的PHP程序在执行完成后，或多或少会有内存泄露的问题。这也是为什么开始时一个php-fpm进程只占用3M左右内存，运行一段时间后就会上升到20-30M的原因了。（www. 脚本学堂）

所以，动态方式因为会结束掉多余的进程，可以回收释放一些内存，所以推荐在内存较少的服务器或者VPS上使用。具体最大数量根据 内存/20M 得到。
比如说512M的VPS，建议pm.max_spare_servers设置为20（512*0.8/20）。至于pm.min_spare_servers，则建议根据服务器的负载情况来设置，比较合适的值在5~10之间。

然后对于比较大内存的服务器来说，设置为静态的话会提高效率。
因为频繁开关php-fpm进程也会有时滞，所以内存够大的情况下开静态效果会更好。数量也可以根据 内存/30M 得到。
比如说2GB内存的服务器，可以设置为50；4GB内存可以设置为100等。

比如，如果是512M的vps，设置的参数如下：
 

代码示例:
pm=dynamic
pm.max_children=20
pm.start_servers=5
pm.min_spare_servers=5
pm.max_spare_servers=20
可以最大的节省内存并提高执行效率。


pm.max_children = 100
pm.start_servers = 30
pm.min_spare_servers = 20
pm.max_spare_servers = 100
pm.max_requests = 500

