# FIND_LIBS 函数
# 查找指定目录下的库文件，并将库名和库路径分别返回给调用者
# 参数:
#   lib_dir - 查找库文件的目录
#   suffix - 库文件的扩展名（如.so, .dll, .a等）
#   return_lib_name_list - 用于存储找到的库文件名的变量名（在父作用域中设置）
#   return_lib_path_list - 用于存储找到的库文件路径的变量名（在父作用域中设置）

FUNCTION(FIND_LIBS lib_dir suffix return_lib_name_list return_lib_path_list)
    # 清除可能存在的缓存变量
    UNSET(return_lib_name_list CACHE)
    UNSET(return_lib_path_list CACHE)

    # 使用GLOB模式查找指定目录下的库文件
    FILE(GLOB lib_path_list ${lib_dir}/*.${suffix})

    # 遍历找到的库文件路径，提取库名并添加到列表中
    FOREACH(_lib_path ${lib_path_list})
        GET_FILENAME_COMPONENT(_lib_name ${_lib_path} NAME_WE)
        LIST(APPEND lib_name_list ${_lib_name})
    ENDFOREACH()

    # 将结果返回给调用者
    SET(return_lib_name_list ${lib_name_list} PARENT_SCOPE)
    SET(return_lib_path_list ${lib_path_list} PARENT_SCOPE)
ENDFUNCTION()


#  MAKE_LIBS_TARGET 函数
# 根据库名和库路径创建CMake的库目标
# 参数:
#   lib_name_list - 库名列表
#   lib_path_list - 对应的库文件路径列表
#   lib_type - 库的类型（SHARED或STATIC）
# 定义一个函数MAKE_LIBS_TARGET，接收三个参数：库名列表、库路径列表和库类型
FUNCTION(MAKE_LIBS_TARGET lib_name_list lib_path_list lib_type)
    # 可选：打印调试信息，显示库名列表
    # MESSAGE("DEBUG lib_name_list=${lib_name_list}")
    # 可选：打印调试信息，显示库路径列表
    # MESSAGE("DEBUG lib_path_list=${lib_path_list}")
    # 可选：打印调试信息，显示库类型
    # MESSAGE("DEBUG lib_type=${lib_type}")

    # 检查库类型是否为"SHARED"或"STATIC"，如果不是，则报告致命错误
    IF(NOT lib_type STREQUAL "SHARED" AND NOT lib_type STREQUAL "STATIC")
        MESSAGE(FATAL_ERROR "unknown lib type ${lib_type}")
    ENDIF()

    # 计算库名列表的长度
    LIST(LENGTH lib_name_list num_lib_name)
    # 计算库路径列表的长度
    LIST(LENGTH lib_path_list num_lib_path)
    # 检查库名列表和库路径列表的长度是否相等，如果不等，则报告致命错误
    IF(NOT num_lib_name EQUAL num_lib_path)
        MESSAGE(FATAL_ERROR "number of name and path of libs not equal")
    ENDIF()

    # 遍历库名列表和库路径列表
    FOREACH(i RANGE 0 ${num_lib_name})
        # 如果索引等于库名列表的长度，则跳出循环（但通常这里不会执行，因为范围已限定）
        IF(${i} EQUAL ${num_lib_name})
            BREAK()
        ENDIF()

        # 从库名列表中获取当前索引的库名
        LIST(GET lib_name_list ${i} _lib_name)
        # 从库路径列表中获取当前索引的库路径
        LIST(GET lib_path_list ${i} _lib_path)

        # 添加一个导入的、全局的库目标
        ADD_LIBRARY(${_lib_name} ${lib_type} IMPORTED GLOBAL)

        # 设置库目标的IMPORTED_LOCATION属性为库文件的路径
        SET_PROPERTY(
                TARGET ${_lib_name}
                PROPERTY IMPORTED_LOCATION ${_lib_path}
        )

        # 仅在Windows平台上，且库类型为SHARED时执行
        IF(CMAKE_SYSTEM_NAME STREQUAL "Windows" AND lib_type STREQUAL "SHARED")
            # 获取库文件所在的目录
            GET_FILENAME_COMPONENT(_lib_dir ${_lib_path} DIRECTORY)
            # 尝试设置库的IMPORTED_IMPLIB属性，这在Windows平台上用于指向DLL的导入库（.lib文件）
            # 注意：这里假设导入库的名字与DLL的名字相同，仅扩展名不同，这可能不是普遍适用的规则
            SET_PROPERTY(
                    TARGET ${_lib_name}
                    PROPERTY IMPORTED_IMPLIB ${_lib_dir}/${_lib_name}.lib # 可能是这种命名规则，但并非所有情况都如此
            )
        ENDIF()
    ENDFOREACH()

ENDFUNCTION()




# FIND_HDRS 函数
# 查找指定目录下的头文件，并返回这些头文件所在的目录列表
# 注意：此函数实际上并不按预期工作，因为它总是将hdr_dir添加到结果列表中
# 参数:
#   hdr_dir - 查找头文件的目录
#   return_hdr_dir_list - 用于存储头文件所在目录的变量名（在父作用域中设置）

FUNCTION(FIND_HDRS hdr_dir return_hdr_dir_list)
    # 清除之前可能存在的名为hdr_dir_list的缓存变量（虽然这里可能并不完全必要，因为接下来会立即设置它）
    UNSET(hdr_dir_list CACHE)
    # 初始化一个空列表，用于存储头文件的目录
    SET(hdr_dir_list)
    # 使用FILE(GLOB_RECURSE)命令递归查找给定目录(hdr_dir)下所有.h和.hpp文件
    FILE(
            GLOB_RECURSE hdr_path_list
            ${hdr_dir}/*.h  # 查找所有.h文件
            ${hdr_dir}/*.hpp # 查找所有.hpp文件
    )
    # 这里有一个逻辑错误：原本意图是设置包含头文件的目录列表，但错误地设置为了初始的hdr_dir
    # SET(hdr_dir_list ${hdr_dir}) 应该是移除或替换为正确的逻辑

    # 遍历找到的每个头文件路径
    FOREACH(_hdr_path ${hdr_path_list})
        # 获取头文件路径的目录部分
        GET_FILENAME_COMPONENT(_hdr_dir ${_hdr_path} PATH)
        # 将每个头文件的目录添加到hdr_dir_list列表中
        LIST(APPEND hdr_dir_list ${_hdr_dir})
    ENDFOREACH(_hdr_path ${hdr_path_list})
    # 去除hdr_dir_list列表中的重复项
    LIST(REMOVE_DUPLICATES hdr_dir_list)
    # 将处理后的目录列表设置到父作用域中的变量return_hdr_dir_list
    SET(return_hdr_dir_list ${hdr_dir_list} PARENT_SCOPE)
ENDFUNCTION()



# 打印列表中的每个项目
# 参数:
#   list_item - 要打印的列表
#   title - 列表的标题
#   prefix - 每个项目前的前缀
FUNCTION(PRINT_LIST list_item title prefix)
    # 如果列表为空，则直接返回
    IF(NOT list_item OR (list_item STREQUAL ""))
        RETURN()
    ENDIF()

    # 打印标题
    MESSAGE("┌────────────────── ${title}")

    # 遍历列表并打印每个项目
    FOREACH(item ${list_item})
        MESSAGE("│ ${prefix} ${item}")
    ENDFOREACH()

    # 打印结束标记
    MESSAGE("└──────────────────]\n")
ENDFUNCTION()