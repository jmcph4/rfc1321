CC=gcc
CFLAGS=-ansi -DMD=5 -DPROTOTYPES=1
SRCS=md5c.c mddriver.c
TARGET=mddriver

build: $(SRCS)
	$(CC) $(SRCS) $(CFLAGS) -o $(TARGET)

build-debug: $(SRCS)
	$(CC) $(SRCS) $(CFLAGS) -g3 -o $(TARGET)

.PHONY: test
test: build
	./$(TARGET) -x | diff - expected.txt

.PHONY: clean
clean:
	rm $(TARGET)
