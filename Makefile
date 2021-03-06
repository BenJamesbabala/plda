CC=g++
MPICC=mpicxx

CFLAGS=-O3 -Wall -Wno-sign-compare
OBJ_PATH = ./obj

all: lda infer mpi_lda

clean:
	rm -rf $(OBJ_PATH)
	rm -f lda mpi_lda infer

OBJ_SRCS := cmd_flags.cc common.cc document.cc model.cc accumulative_model.cc sampler.cc
ALL_OBJ = $(patsubst %.cc, %.o, $(OBJ_SRCS))
OBJ = $(addprefix $(OBJ_PATH)/, $(ALL_OBJ))

$(OBJ_PATH)/%.o: %.cc
	@ mkdir -p $(OBJ_PATH) 
	$(CC) -c $(CFLAGS) $< -o $@

lda: lda.cc $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) $< -o $@

infer: infer.cc $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) $< -o $@

mpi_lda: mpi_lda.cc $(OBJ)
	$(MPICC) $(CFLAGS) $(OBJ) $< -o $@
