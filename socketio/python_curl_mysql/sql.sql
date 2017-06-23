
-- bx_data

CREATE TABLE `bx_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '0' COMMENT '产品名称',
  `link` varchar(255) NOT NULL DEFAULT '0' COMMENT '链接',
  `company` varchar(255) NOT NULL DEFAULT '0' COMMENT '保险公司',
  `order_type` varchar(255) NOT NULL DEFAULT '0' COMMENT '排序类型',
  `sales_volume` varchar(255) NOT NULL DEFAULT '0' COMMENT '销量',
  `comment_number` varchar(255) NOT NULL DEFAULT '0' COMMENT '评论数',
  `minimum_premium` varchar(255) NOT NULL DEFAULT '0' COMMENT '最低保费',
  `underwriting_age` varchar(255) NOT NULL DEFAULT '0' COMMENT '承保年龄',
  `guarantee_period` varchar(255) NOT NULL DEFAULT '0' COMMENT '保障期限',
  `list` varchar(2000) NOT NULL DEFAULT '0' COMMENT '保障项列表 {json}',
  `website_name` varchar(255) NOT NULL DEFAULT '0' COMMENT '采集站',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


