################################
# MAKEFILE FOR MYFIRSTGAME PROJECT!
# -----------------------------------
#
# This makefile compiles all the source code and
# stores the object files .o and dependency files .d
# into a directory called build.
#
# Este makefile compila todo el código fuente y 
# almacente los archivos objeto .o y archivos 
# de dependencia .d en el directorio llamado buil.
#
#	AUTOR: ANTONIO CARRETERO SAHUQUILLO
################################








################################
# MAKEFILE VARIABLES | VARIABLES DEL MAKEFILE
################################

## PROJECT NAME | NOMBRE DEL PROYECTO ##
PROJECT = snakee

## WORKSPACE DIRECTORIES | DIRECTORIOS DEL ESPACIO DEL TRABAJO ##
SRCD = ./src
INCD = ./inc
BUILDD = ./build
OBJD = ./build/obj
DEPD = ./build/dep
BIND = ./bin

## COMPILATOR AND COMPILATOR FLAGS | COMPILADOR Y OPCIONES DE COMPILACIÓN ##
CC = gcc
CFLAGS = -g -O2 -Wall
CFLAGS += -m32
CFLAGS += -I $(INCD)

## FILE NAMES AND ROUTES | NMBRE DE LOS ARCHIVOS Y RUTAS ##
SRC = $(wildcard $(SRCD)/*.c)

OBJ = $(SRC:$(SRCD)/%.c=$(OBJD)/%.o)
DEP = $(OBJ:.o=.d)


## DEPENDENCY FILES INCLUDE | INCLUSIÓN DE ARCHIVOS DE DEPENDENCIA ##
-include $(DEP)





################################
# MAKE PROCESSES | PROCESOS MAKE
################################
.phony: all clean

## ALL PROCESS | PROCESO ALL ##
all: build_msg build_ws $(BIND)/$(PROJECT).elf

build_msg:
	@echo -e
	@echo -------- BUILDING PROJECT --- CONSTRUYENDO PROYECTO --------
	@echo -e

build_ws:
	@if [ ! -d "$(BIND)" ] || [ ! -d "$(BUILDD)" ] || [ ! -d "$(OBJD)" ] || [ ! -d "$(DEPD)" ]; then \
		echo Creating necessary directories... --- Creando directorios necesarios... ; \
		mkdir -p $(BIND) $(BUILDD) $(OBJD) $(DEPD); \
		echo Directories created! --- Directorios creados!; \
		echo -e; \
	fi

$(BIND)/$(PROJECT).elf: $(OBJ)
	@echo -e
	@echo Linking final executable file... --- Enlazando el ejecutable final...
	@$(CC) $(CFLAGS) $(OBJ) -o $@
	@echo Executable created! : $@
	@echo ¡Ejecutable creado! : $@
	@echo -e

$(OBJD)/%.o : $(SRCD)/%.c
	@echo Generating $@ and $(@:.o=.d) file in $(BUILDD)/... --- Generando el archivo $@ y $(@:.o=.d) en $(BUILDD)/
	@$(CC) $(CFLAGS) -MMD -c $< -o $@
	@mv $(@:.o=.d) $(DEPD)
	@echo Generated object and dependency file! --- ¡Archivo objeto y dependencia generada!
	@echo -e


## CLEAN PROCESS | PROCESO CLEAN ##
clean: clean_msg clean_ws

clean_msg:
	@echo -e
	@echo -------- CLEAN WORKSPACE --- LIMPIAR ESPACIO DE TRABAJO --------
	@echo -e

clean_ws:
	@echo Deleting unnecessary directories... --- Eliminando directorios innecesarios...
	@rm -rf $(BIND) $(BUILDD)
	@echo Workspace cleaned! --- ¡Espacio de trabajo limpio!
	@echo -e