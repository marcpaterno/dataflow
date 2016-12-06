#CMakeLists for "$exp" with specific directory tree
include(helpers.cmake)
cmake_minimum_required(VERSION 2.8.9)
project(study_area)
set(CMAKE_CXX_FLAGS "-std=c++14")
# The following line is needed on Linux, and forbidden on OSX
#set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--no-undefined")
#message(STATUS "build path: $ENV{BUILD_PATH}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "$ENV{BUILD_PATH}/lib")

#reading in cmake cache variables from build script
set(in_src ${IS_IN_SRC})
set(work_dir ${WORKING_DIR})
set(build_dir_list ${BUILD_DIRS})

#include directories
find_inc_dirs()
foreach(inc_dir ${inc_dirs_list})
include_directories(${inc_dir})
endforeach(inc_dir ${inc_dirs_list})

#using these jank maps to link libs
find_lib_dirs()
foreach(lib_prod ${lib_prod_list})
    #message(STATUS "new product")
    #message(STATUS "${lib_prod}")
    #message(STATUS "${map_${lib_prod}}")
    file(GLOB so_list ${map_${lib_prod}}/*.dylib)
    #message(STATUS "${so_list}")
    foreach(so ${so_list})
        #message(STATUS "${so}")
        string(REGEX REPLACE "^.*/lib([^/]*)\\.dylib$" "\\1" var ${so})
        #message(STATUS ${var})
        set(${var} ${so})
    endforeach(so ${so_list})
endforeach(lib_prod ${lib_prod_list})
    #root special case!
    #message(STATUS "$ENV{ROOTSYS}")
    #
    # Note that ROOT dynamic libraries on OSX have filename extension
    # .so, not .dylib.
    file(GLOB root_lib_list $ENV{ROOTSYS}/lib/*.so)
    foreach(root_so ${root_lib_list})
        #message(STATUS "${root_so}")
        string(REGEX REPLACE "^/.*lib(.*)\\.so$" "\\1" root_var ${root_so})
        #message(STATUS ${root_var})
        set(${root_var} ${root_so})
    endforeach(root_so ${root_lib_list})

#lib lists per plugin
set(service_lib_list)
set(module_lib_list)
set(source_lib_list)

list(INSERT service_lib_list 0
      ${art_Framework_Services_Registry}
      ${art_Persistency_Common}
      ${art_Utilities}
      ${canvas_Persistency_Common}
      ${canvas_Utilities}
      ${fhiclcpp}
      ${cetlib}
      ${boost_filesystem}
      ${boost_system}
      )
list(INSERT module_lib_list 0
      ${art_Framework_Core}
      ${art_Framework_Principal}
      ${art_Persistency_Common}
      ${art_Persistency_Provenance}
      ${art_Utilities}
      ${canvas_Persistency_Common}
      ${canvas_Persistency_Provenance}
      ${canvas_Utilities}
      ${fhiclcpp}
      ${cetlib}
      ${Core}
      ${boost_filesystem}
      ${boost_system}
      )
list(INSERT source_lib_list 0
      ${art_Framework_IO_Sources}
      ${Boost_FILESYSTEM_LIBRARY}
      ${Boost_SYSTEM_LIBRARY}
      ${art_Framework_Core}
      ${art_Framework_Principal}
      ${art_Persistency_Common}
      ${art_Persistency_Provenance}
      ${art_Utilities}
      ${canvas_Persistency_Common}
      ${canvas_Persistency_Provenance}
      ${canvas_Utilities}
      ${fhiclcpp}
      ${cetlib}
      ${Core}
      ${boost_filesystem}
      ${boost_system}
      )


#adding sources

#if passed an arg
if( NOT build_dir_list STREQUAL "no args")
    message(STATUS "specified dirs are: ${build_dir_list}")
    #add each build dir
    foreach(build_dir ${build_dir_list})
        #add_subdirectory(src/${build_dir})
        add_subdirectory($ENV{SRC_PATH]/${build_dir})
    endforeach(build_dir ${build_dir_list})
#if no args passed
elseif( build_dir_list STREQUAL "no args")
message(STATUS "no specified dirs...")
    #if outside srcs
    if(NOT in_src)
        message(STATUS "not in src dir... building everything...")
        add_subdirectory($ENV{SRC_PATH})
        #if in sources
    elseif(in_src)
        message(STATUS "somewhere in src... building current dir...")
        add_subdirectory(${work_dir})
    endif(NOT in_src)
endif( NOT build_dir_list STREQUAL "no args")
