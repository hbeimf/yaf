#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
demo
'''

# python 包机制doc
# http://www.cnblogs.com/phinecos/archive/2010/05/07/1730027.html

from lib.MySQL import MySQL

class Demo:

    def start(self):
        print 'start run ...'

        db = MySQL()
        db.test()

        sql = '''SELECT * from time_lists limit 1
        '''
        reply = db.fetch_all(sql)
        print reply




if __name__ == '__main__':
    Demo().start()
