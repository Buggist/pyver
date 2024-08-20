Pyver
===========================

极简的 Python 版本管理器（WINDOWS）

优点如下:
    1. 仅仅是切换全局 Python 版本，不做任何其它的事情，没有新的概念需要你去了解。
    2. 操作指令极其简单。
    3. 不需要花时间处理各种莫名其妙的报错。
    4. 不会强迫你去学习一大堆这辈子都没机会用到的指令和概念。

它能与 Python 内置的 venv 功能很好地协作，从而实现跨 Python 版本的项目级 Python 环境管理。

我的全部 Python 项目都是通过这一工作流来进行环境管理的。
并且这是我包括 pyenv、 conda 在内体验过最舒适的Python环境管理工作流。


工作流程
---------------------------

1 - 准备工作
~~~~~~~~~~~~~~~~~~~~~~~~~~
1. 手动安装需要用到的各个 Python 版本
2. 将 pyver.vbs 拷贝到任意系统PATH环境变量目录下 *(如-> c:\\windows\\)*

2 - 管理员身份运行命令行
~~~~~~~~~~~~~~~~~~~~~~~~~~
  ``>> pyver 311`` *（切换全局 Python 版本到 3.11）*

  ``>> pyver 38``  *（切换全局 Python 版本到 3.8）*

  ``>> pyver show``  *（显示当前全局 Python 版本）*

注意，要在命令行中以切换后的 Python 版本运行命令，请开启新的命令行。*（不要在执行版本切换的命令行中运行Python）*

至此切换全局 Python 版本已经实现了。后面的步骤是可选的，是为了对项目执行更细颗粒度的环境隔离。

3 - 创建对应 Python 版本的虚拟环境
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*（例如已经切换到 Python 3.11）*

``>> python -m venv 311-MyProject`` *（在当前目录下为 MyProject 项目创建专属虚拟环境）*

也可以再切换到其它 Python 版本创建属于其它 Python 版本的虚拟环境：

  ``>> pyver 312``

  ``>> python -m venv 312-NewProject``

  ``>> python -m venv 312-AnotherProject``

建议将所有虚拟环境统一存放在一个目录，并在名称中标出 Python 版本：

.. image:: /source/image.png

如何在控制台中启用虚拟环境：

  ``>> start 3xx-MyProjectName\Scripts\activate.bat``

如何在 IDE 中指定使用虚拟环境的解释器进行调试：

  ``3xx-MyProjectName\Scripts\python.exe``


 
