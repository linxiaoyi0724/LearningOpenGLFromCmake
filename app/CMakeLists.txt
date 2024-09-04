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


# ============================= LearningOpenGL =============================
# 设置learnopengl项目中的源文件列表
SET(
        LearningOpenGL_src_list
        LearningOpenGL/drawTriangle.cpp
)

# 初始化内部静态库列表（这里没有列出任何静态库）
SET(lib_inn_static)

# 初始化内部动态库列表，包括glad和stb_image（用于OpenGL加载和图像加载）
SET(lib_inn_shared glad stb_image)

# 初始化外部静态库列表，仅包括opengl32（Windows特有的OpenGL实现）
SET(lib_ext_static opengl32)

# 初始化外部动态库列表，包括glfw3（用于创建窗口和处理输入）和assimp-vc143-mtd（用于模型加载）
# 注意：assimp-vc143-mtd表明这可能是特定于Visual Studio 2015（VC14）和MT（多线程）运行时的Assimp库版本
SET(lib_ext_shared glfw3 assimp-vc143-mtd)

# 合并所有库（静态和动态，内部和外部）
SET(
        lib_all
        ${lib_inn_static}
        ${lib_inn_shared}
        ${lib_ext_static}
        ${lib_ext_shared}
)

# 遍历每个源文件，为每个文件创建一个可执行文件
FOREACH(_src_file ${learnopengl_src_list})
    # 从文件名中提取不含路径和扩展名的名称
    GET_FILENAME_COMPONENT(_src_name ${_src_file} NAME_WE)
    # 添加可执行文件目标
    ADD_EXECUTABLE(${_src_name} ${_src_file})
    # 如果lib_all非空，将所有库链接到该可执行文件
    IF(lib_all)
        TARGET_LINK_LIBRARIES(${_src_name} ${lib_all})
    ENDIF()
    # 安装该可执行文件到bin目录
    INSTALL(TARGETS ${_src_name} RUNTIME DESTINATION bin)
ENDFOREACH()

# 如果lib_all非空，则处理库的安装
IF(lib_all)
    # 对于内部库（静态和动态），将它们安装到bin和lib目录
    # 注意：这里可能需要额外的步骤来确保动态库（DLL/so）被正确安装为运行时文件
    INSTALL(
            TARGETS ${lib_inn_shared} ${lib_inn_static}
            RUNTIME DESTINATION bin
            ARCHIVE DESTINATION lib
    )
    # 对于外部动态库，CMake的IMPORTED_RUNTIME_ARTIFACTS可能不是正确的命令，这里可能是个错误或示例不完整
    # 通常，外部库（特别是预编译的库）需要被标记为IMPORTED目标，并使用TARGET_LINK_LIBRARIES等命令链接
    # 但这里尝试安装外部动态库的方式可能不正确或需要更详细的配置
    # INSTALL(IMPORTED_RUNTIME_ARTIFACTS ${lib_ext_shared}) # 这行可能不起作用，需要替换为适当的安装命令
ENDIF()