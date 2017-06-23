#coding=utf-8
import sys
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
# from selenium.webdriver.common.action_chains import ActionChains #引入ActionChains鼠标操作类
import time
import re

import html2text

"""
huize | 中民

"""

class FetchWeb :
    def __init__(self):
        print("start...")
        reload(sys)                         # 2
        sys.setdefaultencoding('utf-8')
        self.init_browser()

    def __del__(self) :
        self.browser.quit()
        print("close")

    def init_browser(self):
        self.browser = webdriver.Firefox()
        # self.browser = webdriver.PhantomJS()
        # self.browser = webdriver.Chrome()
        # 保存主窗口句柄， id 号
        self.main_window_handle = self.browser.current_window_handle


    def reboot_browser(self):
        self.browser.quit()
        self.init_browser()


    def run(self) :
        self.zhongmin_go()
        # self.reboot_browser()
        # self.zhongmin_go_v2()


    def save(self, name, category, row):
        print name
        print category
        print row


    #新一站销量
    # def zhongmin_go_v2(self):
    #     url = "http://www.xyz.cn/mall/jiankangxian/104-72-1.html"
    #     self.open_window(url)
    #     time.sleep(5)
    #     a = self.browser.find_element_by_id("SALES")
    #     # 发送点击事件,点击销量
    #     ActionChains(self.browser).click(a).perform()
    #     time.sleep(0.5)
    #     self.zhongmin_gogo("新一站", "销量")



    # 中民 销量
    def zhongmin_go(self):
        url = "http://www.zhongmin.cn/health/health-1g-1m-1o63s-1c-1e-1od1ot1bpg1.html"
        self.open_window(url)
        self.zhongmin_gogo("中民", "销量")


    def zhongmin_gogo(self, name, category):
        rows = self.zhongmin_find_data()
        # for row in rows:
        #     print row['name']
        #     print row['link']
        #     print row['company']
        #     print row['sales_volume']
        #     print row['comment_number']
        #     print row['minimum_premium']

        #     reply = self.zhongmin_find_data1(row['link'])
        #     time.sleep(2)
        #     row['underwriting_age'] = reply['underwriting_age']
        #     row['guarantee_period'] = reply['guarantee_period']

        #     print row['underwriting_age']
        #     print row['guarantee_period']

        #     self.save(name, category, row)
        time.sleep(1)

    def zhongmin_find_data(self):
        # time.sleep(2)
        print "find data"
        rows = []

        # data = {
        #     'link':'', # 产品链接
        #     'name': '', # 产品名称
        #     'company': '', # 保险公司
        #     # 'order_type': '', # 排序类型，
        #     'sales_volume': '', # 销量，
        #     'comment_number': '',# 评论数，
        #     'minimum_premium': '', # 最低保费
        #     'underwriting_age':'', # 承保年龄
        #     'guarantee_period':'' , #保障期限
        #     'list': [], #保障项列表
        # }




        lis = self.browser.find_elements_by_class_name("list_pro_frame")

        # print len(lis)
        for li in lis:
            data = {}

            # 产品名称和链接
            a = li.find_element_by_class_name("list_pro_tit").find_element_by_tag_name("a")
            name = a.get_attribute("innerHTML")
            link = a.get_attribute("href")

            print name.strip()
            print link

            # 价格
            price1 = li.find_element_by_class_name("price1").get_attribute("innerHTML")
            print price1

            # 销量
            list_pro_price_total = li.find_elements_by_class_name("list_pro_price_total")
            for p in list_pro_price_total:
                con = p.get_attribute("innerHTML")
                if con.find("销量") == -1:
                    pass
                else:
                    print con


            # 点击链接 ， 比 python 自带的稳定很多，
            self.browser.execute_script('$(arguments[0]).click()', a)
            time.sleep(3)
            # 切换窗口
            # print len(self.browser.window_handles)
            for handle in self.browser.window_handles:
                if handle != self.main_window_handle:
                    self.browser.switch_to_window(handle)
                    # 从新打开的页面获取数据，然后关闭窗口
                    link = self.current_url()
                    print link

                    # 保障内容
                    type_content = self.browser.find_element_by_class_name("type_content")
                    tables = type_content.find_elements_by_tag_name("table")

                    trs = tables[0].find_elements_by_tag_name("tr")
                    for tr in trs:
                        tds = tr.find_elements_by_tag_name("td")
                        # print len(tds)
                        if len(tds) == 3:
                            print self.strip_tags(tds[0].get_attribute("innerHTML").strip())
                            print self.strip_tags(tds[1].get_attribute("innerHTML").strip())
                            print '----------'



                    # 保障年龄
                    # proChoose = self.browser.find_element_by_class_name("proChoose")

                    # print len(proChoose)
                    # clearfix = proChoose.find_elements_by_class_name("clearfix")
                    # divs = proChoose.find_elements_by_tag_name("div")

                    # print len(divs)
                    # for cc in clearfix:
                    #     html = cc.get_attribute("innerHTML")
                        # print html
                        # title = cc.find_element_by_class_name("tit").get_attribute("innerHTML")
                        # if title.find("保障年龄") == -1:
                        #     pass
                        # else:
                        #     xx = cc.find_element_by_class_name("cur").get_attribute("innerHTML")
                        #     print xx

                        # <span class="tit show">保障年龄：</span>  <ul class="proItems">
                        # <li class="cur"> 出生满30天至60周岁</li>
                        # </ul>

                        # <span class="tit show">保障期限：</span>
                        # <div id="DivLitPayMethod" class="proItems">
                        # <ul class="clearfix mb10">
                        # <li class="cur">1年</li>
                        # </ul>
                        # <p>本计划提供一年期的保障，可续保至80周岁，最早生效日期为购买后次日零时。</p>
                        # </div>

                        # pattern = re.compile(r'<span class="tit show">(.*)</span>(.*)<ul class="proItems">(.*)<li class="cur">(.*)</li>(.*)</ul>')
                        # match = pattern.match(html)
                        # if match:
                        #     print match.group()




                    self.browser.close()
            # 切回主窗口
            self.browser.switch_to_window(self.main_window_handle)




            # self.close_window_except_main_window()




            # print "------------------------"

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


