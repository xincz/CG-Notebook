cmake_minimum_required(VERSION 3.17)
project(StartTest)

set(CMAKE_CXX_STANDARD 14)

link_directories("D:/freeglut/lib/x64")
link_directories("D:/glew/lib/Release/x64")

include_directories("D:/freeglut/include")
include_directories("D:/glew/include")


add_executable(StartTest main.cpp)
#target_link_libraries(StartTest -lOpenGL32 -lfreeGLUT)
#target_link_libraries(StartTest -lfreeglut)
target_link_libraries(StartTest libopengl32.a libfreeglut.a glew32.lib)
