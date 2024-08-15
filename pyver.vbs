' v0.1.1

' 自动切换全局Python版本
' 放置于C:\Windows 或其它系统path环境变量目录下
' 用法例如>>> pyver 311

' 未来计划
'    1 - 查询当前python全局版本 pyver show      √ 0.1.0
'    2 - 同时修改注册表中的默认 python 解释器
'    3 - 用指令自动下载安装指定 python 版本并添加到 PATH 环境变量。
'    4 - 提供指令将项目中的文本编码统一为指定格式，脚本2utf8.py已完成。为了适配pipreqs。
'    5 - 提供指令自动在当前目录下生成当前Python全局版本的【.python-version】文件。
'    6 - 将项目整理合并为单一的一个指令。包括【统一编码】【冻结版本】【冻结依赖库】。
'    7 - 展示可用版本列表                              
'    8 - 复制当前激活版本的安装路径

' 假如切换到纯Python版本
'    1 - 可以由python执行版本切换时临时创建并运行该vbs，结束时删除。


Set args = WScript.Arguments

If args.count > 0 Then
    arg = args(0)                                                                   ' 获取传入的目标 Python 版本
Else
    arg = False
End If

If arg = False Then
    show_version(arg)
ElseIf IsNumeric(arg) Then
    change_version(arg)
ElseIf arg = "show" Then
    show_version(arg)
ElseIf arg = "list" Then
    msgbox "功能开发中..."
End If


Sub change_version(arg)
    ' 更换全局 Python 版本
    key_word = "Python" & arg
    Set objShell     = CreateObject("WScript.Shell")
    Set objSystemEnv = objShell.Environment("System")
    path_sys         = objSystemEnv("Path")
    path_list_sys    = split(path_sys, ";")

    path_list_py = Array()
    num  = 0
    For Each path In path_list_sys                                              ' 遍历系统PATH变量路径列表，找出目标版本的两个完整路径
        If Instr(path, key_word) Then          
            Redim Preserve path_list_py(num)
            path_list_py(num) = path
            num = num + 1
            If num >= 2 Then
                Exit For
            End If
        End If
    Next

    If UBound(path_list_py) = -1 Then
        MsgBox arg & "版本在Path环境变量中不存在！"
        WScript.Quit
    End If

    For Each path In path_list_py                                               ' 在系统PATH变量中删除指定Python版本的信息
        path_sys = Replace(path_sys, path & ";", "")
        objSystemEnv("Path") = path_sys
    Next

    For Each path In path_list_py                                               ' 在系统PATH变量中将指定Python版本的信息添加到开头
        path_sys = path & ";" & path_sys
    Next
    objSystemEnv("Path") = path_sys
    MsgBox "当前 Python 全局版本为：" & arg
End Sub


Sub show_version(arg)
    ' 查询当前全局 Python 版本
    Set objShell     = CreateObject("WScript.Shell")
    Set objSystemEnv = objShell.Environment("System")
    path_sys         = objSystemEnv("Path")
    path_list_sys    = split(path_sys, ";")                                     ' 路径列表
    
    For Each path In path_list_sys      
        shoud_exit = False   
        dir_list    = split(path, "\")
        For Each d In dir_list                                                  ' 注意这里暗含一个问题，就是当python被安装于带有【Python紧跟数字】的目录内部时，会出现BUG。最佳改法为反向遍历该数组。
            If InStr(d, "Python") Then
                If IsNumeric(Replace(d, "Python", "")) Then
                    shoud_exit = True
                    msg = "当前激活的 Python 版本号为: "
                    MsgBox msg & Replace(d, "Python", "")
                    Exit For
                End If
            End If
        Next
        If shoud_exit Then
            Exit For
        End If
    Next
End Sub







