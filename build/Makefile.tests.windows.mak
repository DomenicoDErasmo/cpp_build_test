COMPILER		:= clang++
CURRENT_DIR		:= $(subst /,\,${CURDIR})
SRC				:= tests
SRC_EXTENSION	:= cpp
INCLUDE_FLAGS 	:= -I code
SRC_SUBDIRS 	:= $(subst $(CURRENT_DIR),,$(shell dir $(SRC) /S /AD /B | findstr /i src))

# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))
SRC_FILES 		:= $(call rwildcard,$(SRC)/,*.$(SRC_EXTENSION)) # Get all .cpp files
OBJ				:= obj
OBJ_FILES		:= $(SRC_FILES:%=$(OBJ)/%.o)
BIN 			:= bin
EXECUTABLE		:= $(BIN)\$(SRC).exe

build: scaffold link

.PHONY: scaffold
scaffold:
	@echo Scaffolding folder structure...
	-@setlocal enableextensions enabledelayedexpansion && mkdir $(BIN) 2>NUL || cd .
	-@setlocal enableextensions enabledelayedexpansion && mkdir $(addprefix $(OBJ), $(SRC_SUBDIRS)) 2>NUL || cd .
	@echo Done.

$(OBJ)/%.$(SRC_EXTENSION).o: %.$(SRC_EXTENSION) # compile .cpp to .cpp.o object
	@echo   $<...
	@clang $< $(COMPILER_FLAGS) -c -o $@ $(INCLUDE_FLAGS)

.PHONY: link
link: $(OBJ_FILES)
	$(COMPILER) $(OBJ_FILES) -o $(BIN)/$(SRC).exe

.PHONY: clean
clean:
	if exist .\$(EXECUTABLE) del .\$(EXECUTABLE)
	rmdir /s /q .\obj\$(SRC)
