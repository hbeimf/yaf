#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
demo
'''


def ppstr(o, i):
    if o > 0 and i > 0:
        stdout('>' if o % 100 else ' [%d - %d]\n' % (o - 100, o))

# python 包机制doc
# http://www.cnblogs.com/phinecos/archive/2010/05/07/1730027.html

from lib.MySQL import MySQL

class Demo:

    def start(self):
        print 'start run ...'

        self.db = MySQL()
        # self.db.test()

        sql = '''SELECT * from bx_list limit 1
        '''
        reply = self.db.fetch_all(sql)
        print reply

        # self.test()
        sql = """
            INSERT INTO `bx_list` (`company`, `guarantee_period`, `website_name`, `link`, `order_type`, `minimum_premium`, `name`, `comment_number`, `sales_volume`, `list`, `underwriting_age`) VALUES ('', '1年', '中民', 'http://www.zhongmin.cn/Health/Product/HospitalProductT639-0-21-0.html', '人气', '￥199', '平安e家保-医疗保障B计划（100万）', ' 销量：1589份&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;评论：78', ' 销量：1589份&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;评论：78', '[{\"the_sum_insured\": \"100\\u4e07\\u5143\", \"safeguard_term\": \"\\u533b\\u7597\\u603b\\u9650\\u989d\"}, {\"the_sum_insured\": \"100\\u4e07\\u5143\\uff08\\u8ba1\\u5165\\u603b\\u9650\\u989d\\uff09\", \"safeguard_term\": \"\\u4f4f\\u9662\\u533b\\u7597\\u53ca\\u7279\\u6b8a\\u95e8\\u8bca\"}, {\"the_sum_insured\": \"100\\u4e07\\u5143\\uff08\\u8ba1\\u5165\\u603b\\u9650\\u989d\\uff09\", \"safeguard_term\": \"\\u4f4f\\u9662\\u524d\\u540e7\\u5929\\u95e8\\u6025\\u8bca\"}, {\"the_sum_insured\": \"\", \"safeguard_term\": \"\\u5065\\u884c\\u5929\\u4e0b\\u5065\\u5eb7\\u7ba1\\u7406\\u8ba1\\u5212\"}]', '出生满28天至60周岁')
        """
        self.db.execute(sql)

    # def test(self):
    #     # print 'ok'
    #     sql = '''SELECT * FROM time_lists where id < 1000'''
    #     for row in self.db.iterator(sql):
    #         print row



if __name__ == '__main__':
    Demo().start()
