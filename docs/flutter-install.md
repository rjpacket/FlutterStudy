### 下载

打开[Flutter官网](https://flutter.io/docs/development/tools/sdk/archive#windows)，下载目前(2019/02/20)的稳定版本1.0.0。下载完成解压到D盘备用。

### 更新环境变量

打开计算机的环境变量配置，新增下载的flutter sdk的bin目录，例如我sdk放在了D:\Program Files\flutter，那么我新增的环境变量为D:\Program Files\flutter\bin。

### 测试

新打开cmd界面，输入flutter，如果得到下面的界面表示flutter已经安装成功了。

### 安装flutter依赖

继续在cmd敲入 flutter doctor。可以看到如下提示：

上面第一个 × 是没有android licenses，照着敲一遍flutter doctor --android-licenses，全部选 y 就好。

继续运行 flutter doctor，如下


这两个 × 是因为Android Studio没有安装plugin。

### Android Studio安装plugin

打开Android Studio，File -> Setting -> Plugins -> Browse repositories...


搜索flutter，已经有108万人安装了，点击install

安装完成后需要重启一次Android Studio，重启完成继续执行一次flutter doctor

好了到这里，flutter的开发环境就搭好了，老规矩，来个hello world测试一下。

### Hello world

点开Android Studio的 File -> New 可以看到 New Flutter Project... 选项

点选Flutter Application，Next，

为项目取一个名字，注意flutter要求名字全部小写。配置好flutter sdk，即D:\Program Files\flutter，Next

写好applicationId，Finish。

一个新的项目就建好了，来看下项目的目录结构

入口就是 main.dart，直接run，看下真机效果

好了，可以开始你的flutter之旅了。