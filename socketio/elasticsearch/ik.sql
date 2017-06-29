http://blog.csdn.net/liuzhenfeng/article/details/39404435


-- 1、到github网站下载源代码，网站地址为：

https://github.com/medcl/elasticsearch-analysis-ik

-- 右侧下方有一个按钮“Download ZIP"，点击下载源代码elasticsearch-analysis-ik-master.zip。








mvn clean package





-- http://www.cnblogs.com/xing901022/p/5910139.html
-- http://www.cnblogs.com/xing901022/p/5910139.html
-- http://blog.csdn.net/jam00/article/details/52983056


-- https://github.com/medcl/elasticsearch-analysis-ik/releases?after=v1.10.1


-rw-rw-r--  1 maomao maomao 27364449  8月 31  2016 elasticsearch-2.4.0.tar.gz
-rw-rw-r--  1 maomao maomao   121402  6月 29 11:06 elasticsearch-analysis-ik-1.9.5.zip




-- https://www.elastic.co/downloads/past-releases/elasticsearch-5-4-2
https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.2.zip

-- elasticsearch
https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.2.tar.gz

-- ik 分词
https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.4.2/elasticsearch-analysis-ik-5.4.2.zip

-- head 插件
https://github.com/mobz/elasticsearch-head



Running with built in server

git clone git://github.com/mobz/elasticsearch-head.git
cd elasticsearch-head
npm install
npm run start
open http://localhost:9100/








-- =====================================================================


http://localhost:9200/{index 库名}/_analyze?analyzer=standard&pretty=true&text=我是中国人

http://localhost:9200/website/_analyze?analyzer=standard&pretty=true&text=该请求只需满足以下两点即可完成分词热更&analyzer=ik

http://localhost:9200/website/_analyze?analyzer=standard&pretty=true&text=我是中国人&analyzer=ik_smart

{
  "tokens" : [ {
    "token" : "我",
    "start_offset" : 0,
    "end_offset" : 1,
    "type" : "<IDEOGRAPHIC>",
    "position" : 0
  }, {
    "token" : "是",
    "start_offset" : 1,
    "end_offset" : 2,
    "type" : "<IDEOGRAPHIC>",
    "position" : 1
  }, {
    "token" : "中",
    "start_offset" : 2,
    "end_offset" : 3,
    "type" : "<IDEOGRAPHIC>",
    "position" : 2
  }, {
    "token" : "国",
    "start_offset" : 3,
    "end_offset" : 4,
    "type" : "<IDEOGRAPHIC>",
    "position" : 3
  }, {
    "token" : "人",
    "start_offset" : 4,
    "end_offset" : 5,
    "type" : "<IDEOGRAPHIC>",
    "position" : 4
  } ]
}



http://localhost:9200/_analyze?analyzer=standard&pretty=true&text=sojson在线工具

{
  "tokens" : [ {
    "token" : "sojson",
    "start_offset" : 0,
    "end_offset" : 6,
    "type" : "<ALPHANUM>",
    "position" : 0
  }, {
    "token" : "在",
    "start_offset" : 6,
    "end_offset" : 7,
    "type" : "<IDEOGRAPHIC>",
    "position" : 1
  }, {
    "token" : "线",
    "start_offset" : 7,
    "end_offset" : 8,
    "type" : "<IDEOGRAPHIC>",
    "position" : 2
  }, {
    "token" : "工",
    "start_offset" : 8,
    "end_offset" : 9,
    "type" : "<IDEOGRAPHIC>",
    "position" : 3
  }, {
    "token" : "具",
    "start_offset" : 9,
    "end_offset" : 10,
    "type" : "<IDEOGRAPHIC>",
    "position" : 4
  } ]
}




http://www.sojson.com/blog/82.html







cp /web/elasticsearch/elasticsearch-analysis-ik-master/target/elasticsearch-analysis-ik-1.8.0.jar ./

jar xf elasticsearch-analysis-ik-1.8.0.jar


index.analysis.analyzer.ik.type : "ik"


-- =======================================

http://blog.csdn.net/guo_jia_liang/article/details/52980716?locationNum=2&fps=1

https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v1.10.1/elasticsearch-analysis-ik-1.10.1.zip





cp /web/elasticsearch/elasticsearch-analysis-ik-1.10.1/elasticsearch-analysis-ik-1.10.1.jar ./


-- ==========================================================
http://blog.csdn.net/fenglailea/article/details/52471254

http://www.cnblogs.com/xing901022/p/5910139.html





https://github.com/medcl/elasticsearch-analysis-ik/tree/v1.10.1


git clone https://github.com/medcl/elasticsearch-analysis-ik.git



script.inline: true
script.indexed: true
script.file: true

#index.analysis.analyzer.ik.type: "ik"


