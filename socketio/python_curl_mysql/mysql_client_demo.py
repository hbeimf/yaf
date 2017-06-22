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
        self.db.test()

        sql = '''SELECT * from time_lists limit 1
        '''
        reply = self.db.fetch_all(sql)
        print reply

        self.test()


    def test(self):
        # print 'ok'
        sql = '''SELECT * FROM time_lists where id < 1000'''
        for row in self.db.iterator(sql):
            print row



if __name__ == '__main__':
    Demo().start()
