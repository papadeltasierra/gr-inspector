# Copyright 2013 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# GNU Radio is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# GNU Radio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GNU Radio; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.

if(DEFINED __INCLUDED_GR_USEQT5_CMAKE)
    return()
endif()
set(__INCLUDED_GR_USEQT5_CMAKE TRUE)

# This file is derived from the default "UseQt4" file provided by
# CMake.  This version sets the variables "QT_INCLUDE_DIRS",
# "QT_LIBRARIES", and "QT_LIBRARIES_PLUGINS" depending on those
# requested during the "find_package(Qt4 ...)" function call, but
# without actually adding them to the include or library search
# directories ("include_directories" or "link_directories").  The
# adding in is done by the CMakeLists.txt build scripts in the using
# project.

# Copyright from the original file, as required by the license.
################################################################
# CMake - Cross Platform Makefile Generator
# Copyright 2000-2011 Kitware, Inc., Insight Software Consortium
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# * Neither the names of Kitware, Inc., the Insight Software Consortium,
#   nor the names of their contributors may be used to endorse or promote
#   products derived from this software without specific prior written
#   permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# # A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
################################################################

ADD_DEFINITIONS(${QT_DEFINITIONS})
SET_PROPERTY(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS_DEBUG QT_DEBUG)
SET_PROPERTY(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS_RELEASE QT_NO_DEBUG)
SET_PROPERTY(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS_RELWITHDEBINFO QT_NO_DEBUG)
SET_PROPERTY(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS_MINSIZEREL QT_NO_DEBUG)
IF(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
  SET_PROPERTY(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS QT_NO_DEBUG)
ENDIF()

SET(QT_INCLUDE_DIRS ${QT_INCLUDE_DIR})
SET(QT_LIBRARIES "")
SET(QT_LIBRARIES_PLUGINS "")

IF (QT_USE_QTMAIN)
  IF (Q_WS_WIN)
    SET(QT_LIBRARIES ${QT_LIBRARIES} ${QT_QTMAIN_LIBRARY})
  ENDIF (Q_WS_WIN)
ENDIF (QT_USE_QTMAIN)

IF(QT_DONT_USE_GUI)
  SET(QT_USE_GUI 0)
ELSE(QT_DONT_USE_GUI)
  SET(QT_USE_GUI 1)
ENDIF(QT_DONT_USE_GUI)

# Do we need to add these as a dependency somehow?
IF(QT_DONT_USE_WIDGETS)
  SET(QT_USE_WIDGETS 0)
ELSE(QT_DONT_USE_WIDGETS)
  SET(QT_USE_WIDGETS 1)
ENDIF(QT_DONT_USE_WIDGETS)

IF(QT_DONT_USE_CORE)
  SET(QT_USE_CORE 0)
ELSE(QT_DONT_USE_CORE)
  SET(QT_USE_CORE 1)
ENDIF(QT_DONT_USE_CORE)

IF (QT_USE_QT3SUPPORT)
  ADD_DEFINITIONS(-DQT3_SUPPORT)
ENDIF (QT_USE_QT3SUPPORT)

# list dependent modules, so dependent libraries are added
SET(QT_QT3SUPPORT_MODULE_DEPENDS QTGUI QTSQL QTXML QTNETWORK CORE)
SET(QT_QTSVG_MODULE_DEPENDS QTGUI QTXML CORE)
SET(QT_QTUITOOLS_MODULE_DEPENDS QTGUI QTXML CORE)
SET(QT_QTHELP_MODULE_DEPENDS QTGUI QTSQL QTXML QTNETWORK CORE)
IF(QT_QTDBUS_FOUND)
  SET(QT_PHONON_MODULE_DEPENDS QTGUI QTDBUS CORE)
ELSE(QT_QTDBUS_FOUND)
  SET(QT_PHONON_MODULE_DEPENDS QTGUI CORE)
ENDIF(QT_QTDBUS_FOUND)
SET(QT_QTDBUS_MODULE_DEPENDS QTXML CORE)
SET(QT_QTXMLPATTERNS_MODULE_DEPENDS QTNETWORK CORE)
SET(QT_QAXCONTAINER_MODULE_DEPENDS QTGUI CORE)
SET(QT_QAXSERVER_MODULE_DEPENDS QTGUI CORE)
SET(QT_QTSCRIPTTOOLS_MODULE_DEPENDS QTGUI CORE)
SET(QT_QTWEBKIT_MODULE_DEPENDS QTXMLPATTERNS QTGUI CORE)
SET(QT_QTDECLARATIVE_MODULE_DEPENDS QTSCRIPT QTSVG QTSQL QTXMLPATTERNS QTGUI CORE)
SET(QT_QTMULTIMEDIA_MODULE_DEPENDS QTGUI CORE)
SET(QT_OPENGL_MODULE_DEPENDS QTGUI CORE)
SET(QT_QTSCRIPT_MODULE_DEPENDS CORE)
SET(QT_GUI_MODULE_DEPENDS CORE)
SET(QT_QTTEST_MODULE_DEPENDS CORE)
SET(QT_QTXML_MODULE_DEPENDS CORE)
SET(QT_QTSQL_MODULE_DEPENDS CORE)
SET(QT_QTNETWORK_MODULE_DEPENDS CORE)

function(echo_all_cmake_variable_values)
  message(STATUS “”)
  get_cmake_property(vs VARIABLES)
  foreach(v ${vs})
    message(STATUS “${v}=’${${v}}'”)
  endforeach(v)
  message(STATUS “”)
endfunction()



# Qt modules  (in order of dependence)
# FOREACH(module QT3SUPPORT QTOPENGL QTASSISTANT QTDESIGNER QTMOTIF QTNSPLUGIN
#                QAXSERVER QAXCONTAINER QTDECLARATIVE QTSCRIPT QTSVG QTUITOOLS QTHELP
#                QTWEBKIT PHONON QTSCRIPTTOOLS QTMULTIMEDIA QTXMLPATTERNS QTGUI QTTEST
#                QTDBUS QTXML QTSQL QTNETWORK QTCORE)
FOREACH(module QT3SUPPORT OpenGL QTASSISTANT QTDESIGNER QTMOTIF QTNSPLUGIN
               QAXSERVER QAXCONTAINER QTDECLARATIVE QTSCRIPT QTSVG QTUITOOLS QTHELP
               QTWEBKIT PHONON QTSCRIPTTOOLS QTMULTIMEDIA QTXMLPATTERNS Gui QTTEST
               QTDBUS QTXML QTSQL QTNETWORK Core Widgets)

  STRING(TOUPPER ${module} up_module)
  MESSAGE(QT_USE_${up_module})
  IF (QT_USE_${up_module} OR QT_USE_${up_module}_DEPENDS)
    MESSAGE("Using...")
    IF (Qt5${module}_FOUND)
      MESSAGE("Found...")
      IF(QT_USE_${up_module})
        # STRING(REPLACE "QT" "" qt_module_def "${module}")
        ADD_DEFINITIONS(-DQT_${up_module_def}_LIB)
	SET(QT_INCLUDE_DIRS ${QT_INCLUDE_DIRS} ${Qt5${module}_INCLUDE_DIRS})
      ENDIF(QT_USE_${up_module})
      SET(QT_LIBRARIES ${QT_LIBRARIES} ${Qt5${module}_LIBRARIES})
      SET(QT_LIBRARIES_PLUGINS ${QT_LIBRARIES_PLUGINS} ${Qt5${module}_PLUGINS})
      IF(QT_IS_STATIC)
        SET(QT_LIBRARIES ${QT_LIBRARIES} ${QT_${up_module}_LIB_DEPENDENCIES})
      ENDIF(QT_IS_STATIC) 
      FOREACH(depend_module QT_${up_module}_MODULE_DEPENDS})
        SET(QT_USE_${depend_module}_DEPENDS 1)
      ENDFOREACH(depend_module QT_${up_module}_MODULE_DEPENDS})
    ELSE (Qt5${module}_FOUND)
      MESSAGE("Qt ${module} library not found.")
    ENDIF (Qt5${module}_FOUND)
  ENDIF (QT_USE_${up_module} OR QT_USE_${up_module}_DEPENDS)
  
ENDFOREACH(module)

echo_all_cmake_variable_values()
