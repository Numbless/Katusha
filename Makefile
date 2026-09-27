TARGET_BASE = katusha_benchmark

# System installation paths
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

# Automatic hardware architecture detection
UNAME_M := $(shell uname -m)

ifeq ($(UNAME_M),x86_64)
    TARGET = $(TARGET_BASE)_x86_64
else ifeq ($(UNAME_M),aarch64)
    TARGET = $(TARGET_BASE)_arm64
else ifneq ($(filter riscv%,$(UNAME_M)),)
    TARGET = $(TARGET_BASE)_riscv64
else
    TARGET = unknown
endif

all:
	@echo "======================================================================"
	@echo " KATUSHA Benchmark — Architecture Detection & Deployment Wrapper"
	@echo "======================================================================"
	@echo "Current system architecture detected: $(UNAME_M)"
	@if [ "$(TARGET)" = "unknown" ]; then \
		echo "[Warning] Architecture '$(UNAME_M)' is not officially supported."; \
	else \
		echo "Selected binary payload for target deploy: $(TARGET)"; \
		echo "Execute 'sudo make install' to register this utility globally."; \
	fi
	@echo "======================================================================"

install:
	@if [ "$(TARGET)" = "unknown" ]; then \
		echo "[Error] Cannot install the benchmarking suite on an unsupported architecture."; \
		exit 1; \
	fi
	@if [ ! -f $(TARGET) ]; then \
		echo "[Error] Pre-compiled binary payload '$(TARGET)' was not found in this directory."; \
		echo "Please ensure you have not modified or deleted the release assets package."; \
		exit 1; \
	fi
	install -m 755 $(TARGET) $(BINDIR)/$(TARGET_BASE)
	@echo "[Success] KATUSHA Benchmark registered successfully as '$(BINDIR)/$(TARGET_BASE)'"

uninstall:
	@if [ -f "$(BINDIR)/$(TARGET_BASE)" ]; then \
		rm -f $(BINDIR)/$(TARGET_BASE); \
		echo "[Success] The benchmarking utility was completely removed from the environment paths."; \
	else \
		echo "[Info] KATUSHA Benchmark is not currently installed in '$(BINDIR)/'. Nothing to do."; \
	fi

clean:
	@echo "Cleanup operation skipped: not required for pre-compiled static release deployment packages."

.PHONY: all clean install uninstall
