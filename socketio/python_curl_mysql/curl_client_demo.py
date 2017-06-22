#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
demo
'''

# python 包机制doc
# http://www.cnblogs.com/phinecos/archive/2010/05/07/1730027.html

from lib.Curl import Curl

class Demo:

    def start(self):
        print 'start run ...'
        curl = Curl()

        # curl.test()
        html = curl.get('http://www.baidu.com')
        print html



if __name__ == '__main__':
    Demo().start()

