# -*- coding=utf-8 -*-
import urllib
import urllib2
import sys

class MyLibrary():
    def Is_Translate(self,english,chinese):
        u'''

        检查输入的英文单词在进行baidu搜索时，是否调用了baidu英文翻译引擎
    
        '''
        #添加中文支持
        reload(sys)
        sys.setdefaultencoding('utf8')

        #url地址
        #url='https://www.baidu.com/s'
        url='http://www.baidu.com/s'
        #参数
        values={
                'ie':'UTF-8',
                'wd':'test'   
                }
        #进行参数封装
        data=urllib.urlencode(values)
        #组装完整url
        #req=urllib2.Request(url,data)
        url=url+'?'+data

        #访问完整url
        #response = urllib2.urlopen(req)
        response = urllib2.urlopen(url)
        html=response.read()

        x=chinese in html
        print x

def test():
    lib=MyLibrary()
    lib.Is_Translate( "Test", "测验")

if __name__ == '__main__':
    test()
    print 'finished'