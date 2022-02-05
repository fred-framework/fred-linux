cmake_minimum_required(VERSION 3.0)
project(fred-server LANGUAGES C)

# default installation path
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set (CMAKE_INSTALL_PREFIX "/opt/fredsys/"
           CACHE PATH "default install path" FORCE)
endif()

#select the release build type by default to get optimization flags
if(NOT CMAKE_BUILD_TYPE)
   set(CMAKE_BUILD_TYPE "Release")
   message(STATUS "Build type not specified: defaulting to release.")
endif(NOT CMAKE_BUILD_TYPE)
set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu99 -fpic -D LOG_GLOBAL_LEVEL=LOG_LEV_FULL -D HW_TASKS_A64 -Wno-unused-but-set-variable")

file(GLOB SRC_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.c */*.c)

add_executable(${PROJECT_NAME} ${SRC_FILES})

target_include_directories(${PROJECT_NAME}
 PRIVATE
    .
    hw_support
    shared_kernel
    shared_user
    srv_core
    srv_core_mocks
    srv_support
    utils
)

install(TARGETS ${PROJECT_NAME}
        DESTINATION bin
)
