
CREATE TABLE `system_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父级id',
  `menu_name` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `link` varchar(100) NOT NULL DEFAULT '' COMMENT '链接',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '图标',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '状态[1:启用, 2:禁用]',
  `note` varchar(200) NOT NULL DEFAULT '' COMMENT '备注信息',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `system_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色id',
  `account_name` varchar(100) NOT NULL DEFAULT '' COMMENT '登录账号',
  `passwd` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT 'email',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT 'phone',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '状态[1:启用, 2:禁用]',
  `note` varchar(200) NOT NULL DEFAULT '' COMMENT '备注信息',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `system_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `role_name` varchar(100) NOT NULL DEFAULT '' COMMENT '角色名称',
  `menu_ids` varchar(1000) NOT NULL DEFAULT '' COMMENT '对menu查看权限，{1,2,3}',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '状态[1:启用, 2:禁用]',
  `note` varchar(200) NOT NULL DEFAULT '' COMMENT '备注信息',
  `created_at` int(11) NOT NULL DEFAULT '0' COMMENT '',
  `updated_at` int(11) NOT NULL DEFAULT '0' COMMENT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




mysqldump -uroot -p test > /web/yaf/doc/test.sql



mysqldump -uroot -p gp m_gp_list > /web/yaf/doc/m_gp_list.sql


mysqldump -uroot -p gp > /web/yaf/doc/gp.sql





mysqldump -uroot -p bx_data > /web/yaf/doc/bx_data.sql






