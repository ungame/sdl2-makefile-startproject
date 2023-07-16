CC = g++
SRC_DIR = src
SRC_FILES = ${shell where /R ${SRC_DIR} *.cpp}
COMPILER_FLAGS = -c -std=c++14 -m64 -g -Wall
INCLUDE_DIR = include
INCLUDE_PATHS = -I ${INCLUDE_DIR}
LINKER_FLAGS = -lmingw32 -lSDL2main -lSDL2 -lSDL2_image
BUILD_DIR = build
MAIN_FILE=main

RM = rm -rf
MKDIR = mkdir -p
MOVE = mv

ifeq ($(OS), Windows_NT)
	RM = rmdir /q /s
	MKDIR = mkdir
	MOVE = move
endif

startproject:
	$(MKDIR) ${SRC_DIR} ${INCLUDE_DIR} ${BUILD_DIR}

.PHONY: build
build:
	${CC} ${SRC_FILES} ${COMPILER_FLAGS} ${INCLUDE_PATHS}
	- $(MKDIR) ${BUILD_DIR}
	$(MOVE) *.o ${BUILD_DIR}


link:
	${CC} ${BUILD_DIR}/*.o -o ${BUILD_DIR}/${MAIN_FILE} ${LINKER_FLAGS}

run:
	${BUILD_DIR}/${MAIN_FILE}

clear:
	$(RM) ${BUILD_DIR}
	$(MKDIR) build

all: clear build link run

purge:
	$(RM) ${INCLUDE_DIR}
	$(RM) ${SRC_DIR}
	$(RM) ${BUILD_DIR}
