# ============================= main =============================

# 设置变量，但初始为空，用于后续可能添加的内部静态库、内部动态库、外部静态库和外部动态库  
SET(lib_inn_static)  
SET(lib_inn_shared)  
SET(lib_ext_static)  
SET(lib_ext_shared)  

# 合并所有库到一个列表中  
SET(  
    lib_all  
    ${lib_inn_static}  
    ${lib_inn_shared}  
    ${lib_ext_static}  
    ${lib_ext_shared}  
)

# 添加主可执行文件main  
ADD_EXECUTABLE(main main.cpp)  

# 如果lib_all非空，则链接所有库到main，并安装main到bin目录  
IF(lib_all)  
    TARGET_LINK_LIBRARIES(main ${lib_all})  
    # 安装内部库（动态和静态）到相应目录  
    # 注意：这里有一个错误，应该是${lib_inn_shared}和${lib_inn_static}，但脚本中使用了${lib_inn}  
    INSTALL(  
        TARGETS ${lib_inn_shared} ${lib_inn_static}  
        RUNTIME DESTINATION bin  
        ARCHIVE DESTINATION lib  
    )  
    # 修正为只安装main  
    INSTALL(TARGETS main RUNTIME DESTINATION bin)  
ENDIF() 