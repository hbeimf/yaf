#coding=utf-8
import sys
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.action_chains import ActionChains #引入ActionChains鼠标操作类
import time


"""
huize | 慧择网

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
        # 保存主窗口句柄， id 号
        self.main_window_handle = self.browser.current_window_handle


    def reboot_browser(self):
        self.browser.quit()
        self.init_browser()


    def run(self) :
        self.xyz_go()
        self.reboot_browser()
        self.xyz_go_v2()


    def save(self, name, category, row):
        print name
        print category
        print row


    #新一站销量
    def xyz_go_v2(self):
        url = "http://www.xyz.cn/mall/jiankangxian/104-72-1.html"
        self.open_window(url)
        time.sleep(5)
        a = self.browser.find_element_by_id("SALES")
        # 发送点击事件,点击销量
        ActionChains(self.browser).click(a).perform()
        time.sleep(0.5)
        self.xyz_gogo("新一站", "销量")



    # 新一站综合
    def xyz_go(self):
        url = "http://www.xyz.cn/mall/jiankangxian/104-72-1.html"
        self.open_window(url)
        self.xyz_gogo("新一站", "综合")


    def xyz_gogo(self, name, category):
        rows = self.xyz_find_data()
        for row in rows:
            print row['name']
            print row['link']
            print row['company']
            print row['sales_volume']
            print row['comment_number']
            print row['minimum_premium']

            reply = self.xyz_find_data1(row['link'])
            time.sleep(2)
            row['underwriting_age'] = reply['underwriting_age']
            row['guarantee_period'] = reply['guarantee_period']

            print row['underwriting_age']
            print row['guarantee_period']

            self.save(name, category, row)
        time.sleep(1)

    def xyz_find_data1(self, url):
        self.open_window(url)
        items = self.browser.find_elements_by_class_name("hc-form-item")

        data = {}
        for item in items:
            con = item.get_attribute("innerHTML")
            if con.find("承保年龄") == -1:
              pass
            else:
              underwriting_age = item.find_element_by_class_name("hc-form-item__content").get_attribute("innerHTML")
              data['underwriting_age'] = underwriting_age
            if con.find("保障期间") == -1:
                pass
            else:
                guarantee_period = item.find_element_by_class_name("hc-form-item__content").get_attribute("innerHTML")
                data['guarantee_period'] = guarantee_period

        return data

    def xyz_find_data(self):
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

        dev_prodList = self.browser.find_element_by_id("dev_prodList")
        # divs = dev_prodList.find_elements_by_class_name("hazardC_pro_con_main")
        lis = dev_prodList.find_elements_by_class_name("hazardC_pro_con_item")

        # print len(lis)
        for li in lis:
            data = {}

            div = li.find_element_by_class_name("hazardC_pro_con_main")

            # 产品名称和链接
            # 由于标签不规范， 有的h3里有一个a, 有的有2个，所以要加个判断
            a = div.find_element_by_tag_name("h3").find_elements_by_tag_name("a")
            if len(a) > 1 :
                name = a[1].get_attribute("innerHTML")
                link = a[1].get_attribute("href")

            else:
                name = a[0].get_attribute("innerHTML")
                link = a[0].get_attribute("href")


            # print name.strip()
            # print link
            data['link'] = link
            data['name'] = name.strip()

            # 保险公司名称
            a_tag = div.find_element_by_class_name('hazardC_pro_con_company') \
                    .find_element_by_tag_name("a").get_attribute("innerHTML")
            # print a_tag.strip()
            data['company'] = a_tag.strip()

            #销量
            sales = div.find_element_by_class_name("hazardC_pro_proDucts_sales") \
                    .get_attribute("innerHTML")
            # print sales.strip()
            data['sales_volume'] = sales.strip()

            # 评价
            all_a = div.find_elements_by_tag_name("a")
            for a in all_a:
                con = a.get_attribute("innerHTML")
                if con.find("评价") == -1:
                  pass
                else:
                  # print con.strip()
                  data['comment_number'] = con.strip()

            # 钱数
            footer_div = li.find_element_by_class_name("hazardC_pro_con_footer")
            money = footer_div.find_element_by_class_name("money").find_element_by_class_name("num") \
                    .find_element_by_class_name("typo-size24").get_attribute("innerHTML")
            # print money
            data['minimum_premium'] = money

            # 保障项列表
            list1 = li.find_element_by_class_name("hazardC_pro_proDucts_main") \
                        .find_elements_by_tag_name("li")

            sub_list = []
            for ll in list1:
                name1 = ll.find_element_by_class_name("hazardC_pro_products_detail") \
                        .get_attribute("innerHTML")
                money1 = ll.find_element_by_class_name("hazradC_pro_products_money") \
                        .get_attribute("innerHTML")

                # print "--"
                # print name1.strip()
                # print money1.strip()
                # print "=="
                fields = {
                    'name':name1.strip(),
                    'money':money1.strip()
                }
                sub_list.append(fields)

            data['list'] = sub_list

            rows.append(data)



            # print "------------------------"

        return rows


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


if __name__ == '__main__' :
    Instance = FetchWeb()
    Instance.run()


