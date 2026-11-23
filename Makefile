NVCC := nvcc
TARGET := convert_batch
SRC := convert_batch.cu
NVCCFLAGS := -std=c++17 -O2
LIBS := -ltiff

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(SRC) convert_batch.hpp
	$(NVCC) $(NVCCFLAGS) $(SRC) -o $(TARGET) $(LIBS)

clean:
	rm -f $(TARGET)
