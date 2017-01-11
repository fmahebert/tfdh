
CXX := clang++
CPPFLAGS :=
CXXFLAGS := -O3 -Wall -Wextra -std=c++11 -march=native
LIBS = -lm -lgsl

SRCS := $(wildcard src/*.cpp)
OBJS := $(subst src,build,$(SRCS:.cpp=.o))
DEPS := $(subst src,build,$(SRCS:.cpp=.d))

# when linking executables, only want object files corresponding to headers
HEADERS := $(wildcard src/*.h)
POSSIBLE_HEADER_OBJS := $(subst src,build,$(HEADERS:.h=.o))
HEADER_OBJS := $(filter $(POSSIBLE_HEADER_OBJS), $(OBJS))

all: exec

# we want all object files compiled before we link, but we only link in
# those object files that correspond to a header.
exec: $(OBJS) | bin
	@ echo "  CXXLD     tfdh"
	@ $(CXX) $(CXXFLAGS) $(LIBS) $(HEADER_OBJS) build/tfdh.o -o bin/tfdh

build/%.o: src/%.cpp | build
	@ echo "  CXX       $*.cpp"
	@ $(CXX) $(CPPFLAGS) $(CXXFLAGS) -c src/$*.cpp -o build/$*.o -MMD

build:
	@ mkdir -p build

bin:
	@ mkdir -p bin

clean:
	@ $(RM) $(OBJS) $(DEPS) bin/tfdh

immaculate: clean
	@ $(RM) -r build bin

-include $(DEPS)

