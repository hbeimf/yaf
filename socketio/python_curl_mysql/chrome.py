#coding=utf-8
import sys
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
# from selenium.webdriver.common.action_chains import ActionChains #引入ActionChains鼠标操作类
import time
# import random

# # import MySQLdb

# import hashlib   # md5

# from urllib import quote # http://blog.csdn.net/haoni123321/article/details/15814111

# import lib.Curl
# import json

# doc
# http://www.open-open.com/doc/view/8629346acd5d4d2eb0324ccf16374c9f
# http://www.cnblogs.com/shizioo/p/3813929.html
# http://my.oschina.net/yangyanxing/blog/280871?p=1
# http://www.cnblogs.com/fnng/p/3202299.html
# sublime ctrl + H 替换字符串快捷键

"""
demo

"""

class FetchWeb :
    def __init__(self):
        print("start...")
        reload(sys)                         # 2
        sys.setdefaultencoding('utf-8')
        self.browser = webdriver.Firefox()
        # self.browser = webdriver.PhantomJS()
        # 保存主窗口句柄， id 号
        self.main_window_handle = self.browser.current_window_handle


    def __del__(self) :
        self.browser.quit()
        print("close")

    def run(self) :
        self.go()

    def go(self):
        url = "http://www.xyz.cn/mall/jiankangxian/104-72-1.html"
        self.open_window_with_jquery(url)
        # self.goto_page_bottom()
        # self.goto_page_top()
        self.find_data()

        time.sleep(5)


    def find_data(self):
        print "find data"

        dev_prodList = self.browser.find_element_by_id("dev_prodList")
        divs = dev_prodList.find_elements_by_class_name("hazardC_pro_con_main")

        # print len(divs)
        for div in divs:
            # 由于标签不规范， 有的h3里有一个a, 有的有2个，所以要加个判断
            a = div.find_element_by_tag_name("h3").find_elements_by_tag_name("a")
            if len(a) > 1 :
                name = a[1].get_attribute("innerHTML")
                link = a[1].get_attribute("href")

            else:
                name = a[0].get_attribute("innerHTML")
                link = a[0].get_attribute("href")


            print name.strip()
            print link




    """
    获取列表信息
    """
    # def find_list_info(self):
    #     try:
    #         main_div = self.browser.find_element_by_id("wxbox")
    #         # print(main_div)
    #         # div_tags = main_div.find_elements_by_class_name("txt-box")
    #         div_tags = main_div.find_elements_by_class_name("wx-rb") #  wx-rb3
    #         # print(div_tags)

    #         list_info = []
    #         for div in div_tags:
    #             class_attr = div.get_attribute("class")
    #             if class_attr == "wx-rb wx-rb3":

    #                 title = div.find_element_by_class_name("txt-box").find_element_by_tag_name("h4").find_element_by_tag_name("a").get_attribute("innerHTML")
    #                 # print(title)
    #                 desc = div.find_element_by_class_name("txt-box").find_element_by_tag_name("p").get_attribute("innerHTML")
    #                 # print(desc)
    #                 img = div.find_element_by_class_name("img_box2").find_element_by_tag_name("img").get_attribute("src")
    #                 # print(img)
    #                 link = div.find_element_by_class_name("txt-box").find_element_by_tag_name("h4").find_element_by_tag_name("a").get_attribute("href")
    #                 # print(link)
    #                 # print("")
    #                 dict_info = {"title":title, "description":desc, "imglink":img, "original_url":link}
    #                 list_info.append(dict_info)
    #                 # print(dict_info)
    #         self.list_info = list_info
    #     except:
    #         print("except list info ...")

    # def save_img(self, imgDir) :
    #     self.browser.save_screenshot(imgDir)

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


if __name__ == '__main__' :
    Instance = FetchWeb()
    Instance.run()


# http://www.open-open.com/doc/view/8629346acd5d4d2eb0324ccf16374c9f
# http://www.open-open.com/doc/view/8629346acd5d4d2eb0324ccf16374c9f

# http://www.blogjava.net/qileilove/articles/410728.html
# http://blog.sina.com.cn/s/blog_6a65271b0101ictj.html
