#source cmake list file
#there are two general options:
#    1. everything lives in src directory and we do it all here
#    2. subdirs (requires user to create some of the structure)
#pro-con is easyness vs. choice of what to build

#here is a basic example for option 1.
#    Plugin_name
#    add_library(<fill in which library>)
#    target_link_library(<more nonsense>)

#"DataFlowDumper" lib linking
add_library(DataFlowDumper_module SHARED DataFlowDumper_module.cc)
target_link_libraries(DataFlowDumper_module ${module_lib_list})


