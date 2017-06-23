#coding=utf-8
import sys
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
# from selenium.webdriver.common.action_chains import ActionChains #引入ActionChains鼠标操作类
import time
import re

import html2text

import json

from lib.MySQL import MySQL

"""
huize |

"""

class FetchWeb :
    def __init__(self):
        print("start...")
        reload(sys)                         # 2
        sys.setdefaultencoding('utf-8')
        self.db = MySQL()
        self.init_browser()

    def __del__(self) :
        self.browser.quit()
        print("close")

    def init_browser(self):
        # self.browser = webdriver.Firefox()
        self.browser = webdriver.PhantomJS()
        # self.browser = webdriver.Chrome()
        # 保存主窗口句柄， id 号
        self.main_window_handle = self.browser.current_window_handle


    def reboot_browser(self):
        self.browser.quit()
        self.init_browser()


    def run(self) :
        self.huize_go()
        # self.reboot_browser()
        # self.huize_go_v2()



    # 慧择网 默认
    def huize_go(self):
        url = "http://www.huize.com/product/ins-2041-0-0"
        self.open_window(url)
        self.huize_gogo("慧择网", "默认")


    # 中民 人气
    # def huize_go_v2(self):
    #     url = "http://www.zhongmin.cn/health/health-1g-1m-1o63s-1c-1e-1od2ot1bpg1.html"
    #     self.open_window(url)
    #     self.huize_gogo("中民", "人气")


    def huize_gogo(self, name, category):
        rows = self.huize_find_data(name, category)

        for row in rows:
            print row['link']
            self.open_window(row['link'])
            time.sleep(1)
            trialAreas = self.browser.find_element_by_id("trialAreas")
            dls = trialAreas.find_elements_by_tag_name("dl")

            print len(dls)

            uls = self.browser.find_element_by_id("protectArea") \
                        .find_elements_by_tag_name("ul")

            lis = uls[0].find_elements_by_tag_name("li")

            print len(lis)




            time.sleep(1)

        time.sleep(1)

    def huize_find_data(self, website_name, order_type):
        rows = []

        lis = self.browser.find_element_by_class_name("hz-product-list") \
                    .find_elements_by_class_name("hz-product-item")

        # print len(lis)
        for li in lis:
            data = {
                'link':'', # 产品链接
                'name': '', # 产品名称
                'company': '', # 保险公司
                'order_type': order_type, # 排序类型，
                'sales_volume': '', # 销量，
                'comment_number': '',# 评论数，
                'minimum_premium': '', # 最低保费
                'underwriting_age':'', # 承保年龄
                'guarantee_period':'' , #保障期限
                'list': [], #保障项列表
                'website_name': website_name
            }

            # 产品名称和链接
            h2_a = li.find_element_by_tag_name("h2").find_element_by_tag_name("a")

            name = h2_a.get_attribute("innerHTML").strip()
            link = h2_a.get_attribute("href")
            data['link'] = link
            data['name'] = name

            print data['link']
            print data['name']

            # 保险公司
            data['company'] = li.find_element_by_class_name("company-logo").find_element_by_tag_name("img") \
                .get_attribute("title")

            print data['company']

            # 销量 评论 最低保费
            ps = li.find_elements_by_tag_name("p")
            for p in ps:
                sales_volume = p.get_attribute("innerHTML")
                if sales_volume.find("销量") == -1:
                    pass
                else:
                    data['sales_volume'] = sales_volume
                    print data['sales_volume']

                if sales_volume.find("评论") == -1:
                    pass
                else:
                    data['comment_number'] = sales_volume
                    print data['comment_number']

                if sales_volume.find("¥") == -1:
                    pass
                else:
                    data['minimum_premium'] = p.find_element_by_tag_name("span").get_attribute("innerHTML")
                    print data['minimum_premium']

            rows.append(data)

        return rows




    # 获取当前页面的链接
    def current_url(self):
        js = '''
            var url = window.location.href;
            return url;
        '''
        return self.browser.execute_script(js)


    def delete_title_tag(self):
        js = """
            $("h2").remove();
        """
        self.browser.execute_script(js)


    """
    关闭除主窗口之外的其它窗口，然后切换到主窗口
    """
    def close_window_except_main_window(self):
        for handle in self.browser.window_handles:
                if handle != self.main_window_handle:
                    self.browser.switch_to_window(handle)
                    self.browser.close()
        self.browser.switch_to_window(self.main_window_handle)

    #  打开一个页面，并放入 jquery 框架
    def open_window_with_jquery(self, url):
        # 打开窗口链接
        self.browser.get(url)

        # 注入 jquery
        js = """
            var newNode = document.createElement("script");
            newNode.src = "http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js";
            document.body.appendChild(newNode);
        """
        self.browser.execute_script(js)

    def open_window(self, url):
        self.browser.get(url)
        # self.browser.maximize_window()

    def open_new_window(self, url):
        pass

    def goto_page_bottom(self) :
        # 滑动浏览器滚动条
        js = "var q=document.documentElement.scrollTop=100000"
        self.browser.execute_script(js)
        time.sleep(0.5)
        js = "var q=document.documentElement.scrollTop=500000"
        self.browser.execute_script(js)
        time.sleep(0.5)
        js = "var q=document.documentElement.scrollTop=1000000"
        self.browser.execute_script(js)
        time.sleep(0.5)
        js = "var q=document.documentElement.scrollTop=2000000"
        self.browser.execute_script(js)
        print("go to bottom ...")

    def goto_page_top(self):
        time.sleep(0.5)
        js = "var q=document.documentElement.scrollTop=0"
        self.browser.execute_script(js)
        print("go to top ...")

    def strip_tags(self, string, allowed_tags=''):
        return html2text.html2text(string).strip()
        # return string


if __name__ == '__main__' :
    Instance = FetchWeb()
    Instance.run()


