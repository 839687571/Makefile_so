Linux下编译动态库、静态库的Makefile的demo

1、目录：
bin		编译输出的库文件
lib		依赖的第三方库文件，这里主要是静态库
include 	依赖的第三方库文件的头文件
src		当前库的代码

2、命令
静态库：
make 
动态库：
make so