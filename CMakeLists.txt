# 设置CMake的最低版本要求  
CMAKE_MINIMUM_REQUIRED(VERSION 3.21)  
  
# 定义项目名称  
PROJECT(LearningOpenGL)  
  
# 打印构建系统名称（如Linux, Windows等）  
MESSAGE("build system: ${CMAKE_SYSTEM_NAME}")  
# 打印当前二进制目录的路径  
MESSAGE("${CMAKE_CURRENT_BINARY_DIR}")  
  
# 设置C++标准为C++17  
SET(CMAKE_CXX_STANDARD 17)  
SET(CMAKE_C_STANDARD 17)  
  
# 设置安装前缀为当前二进制目录下的build类型子目录中的install文件夹  
# 注意：CMAKE_BUILD_TYPE可能在此时未定义，通常在使用多配置生成器（如Visual Studio）时有效  
SET(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}/install)  
  
# 注释掉的行用于设置不同类型输出文件的目录，但在此例中未启用  
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin) # 二进制可执行文件  
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin) # 共享库  
# set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib) # 静态库  
  
# 帮助VSCode找到compiler_commands.json文件 
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
  
# 在源代码中添加编译器ID的定义  
ADD_COMPILE_DEFINITIONS(CXX_COMPILER_ID_${CMAKE_CXX_COMPILER_ID})  
ADD_COMPILE_DEFINITIONS(C_COMPILER_ID_${CMAKE_C_COMPILER_ID})  
# 将构建类型转换为大写并作为编译定义  
# STRING(TOUPPER ${CMAKE_BUILD_TYPE} build_type_str)  
# ADD_COMPILE_DEFINITIONS(${build_type_str})  
  
# 如果是在Windows上使用MSVC编译器，则设置所有符号默认导出  
IF(CMAKE_SYSTEM_NAME STREQUAL "Windows" AND CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")  
    MESSAGE("compiler tool chain MSVC, all symbols will export by default")  
    SET(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)  
ENDIF()  
  
# 引入自定义的CMake宏文件  
# INCLUDE(cmake/macro.cmake)  
  
# 引入另一个自定义的CMake文件，可能是用于导入外部项目或库  
# INCLUDE(import.cmake)  
  
# 添加子目录，这些子目录应该包含自己的CMakeLists.txt文件  
# ADD_SUBDIRECTORY(src)  
ADD_SUBDIRECTORY(App)
# ADD_SUBDIRECTORY(test)