## MeiTuan_Swift
![](https://img.shields.io/badge/Language-Swift3.0.x-orange.svg)
![](https://img.shields.io/badge/Platform-iOS9.3.x-green.svg)
![](https://img.shields.io/badge/Xcode-7.3.x-red.svg)
[![](https://img.shields.io/badge/License-MIT-000000.svg)](https://raw.githubusercontent.com/JornWu/MeiTuan_Swift/master/LICENSE)
[![](https://img.shields.io/badge/Download-master-blue.svg)](https://github.com/JornWu/MeiTuan_Swift/archive/master.zip)
<br />
该项目为美团高仿版，只适用于学习，不可用于其他商业用途。

### 1、概述
这只一个基于Swift开发的美团高仿项目，旨在学习练习Swift在iOS开发的应用，已经实现了有意义部分的大多数功能，数据均来自美团的开放平台。
这个项目涵盖了iOS开发所涉及的大多数功能和技巧，当然，由于非正式开发，有些部分做的有些粗糙，不过，很多部分还是值得借鉴。
内部的网络加载使用的NSOperation，集成AF和SD以及MJ等大多主流第三方库，还是采用MVC设计模式，Model采用主流的JsonExport来创建，方便又快捷。
还实现了二维码扫描的功能，当然参考大神了教程，然后采用Swift翻译和更加Swift2.0进行调整。
由于Swift中的enum和struct非常强大，苹果公司也在推从使用Struct来替代部分class，所以，本app在部分功能上采用的struct或enum来实现，更加的快捷
和轻量化。 <br />

本APP使用xcode7.3.1，pod iOS 最低版本为9.0，语言Swift2.3。（其实是从xcode7.2.1(Swift2.0)升到xcode7.3.1(Swift2.3), xcode8.0(Swift3.0)将会后续更新）
AF -> 3.0、 SD->3.8、UIKit等。详情请看项目，打开运行注意适配, 设备为iphone6 plus显示最佳。
本APP采用MVC的经典模式，结合storyboard（ViewController）和xib（View）和code开发,适合大多复杂APP的开发模式，便于更新和维护。
本APP仍在有必要的功能上更新. <br />

注意：打开项目时，要不是在真机仿真，要在viewDidLoad()里先注释掉“beginScanning()”这行代码，要不然程序会崩溃。

<pre>
如有问题或者好的idea请咨询：
QQ: 1249233155
Email: jornwucn@gmail.com 
微博：<a href="https://weibo.com/u/5077687473">Jorn丶Wu</a>
简书：<a href="https://www.jianshu.com/u/c718dbf8e4d0">Jorn丶Wu</a>
博客：<a href="https://blog.sina.com.cn/u/5077687473">梦迹灬何寻</a>
</pre>

### 2、获取
一、<a href="https://github.com/JornWu/MeiTuan_Swift/archive/master.zip">直接下载ZIP</a> <br />
二、<a href="github-mac://openRepo/https://github.com/JornWu/MeiTuan_Swift">Open in Desktop</a> <br />
