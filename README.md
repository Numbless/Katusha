<p align="center">
  <img src="logo.jpg" alt="KATUSHA Logo" width="500">
</p>

<h1 align="center">KATUSHA Benchmark</h1>

<p align="center">
  <strong>A high-performance benchmark utility for comprehensive CPU, RAM, and Disk I/O stress-testing</strong>
</p>

<p align="center">
  <a href="#-installation">Installation</a> •
  <a href="#-usage-instructions">Usage Instructions</a> •
  <a href="#-features-and-test-suites">Features</a>
</p>

---

* 💻 **Platforms & Architectures:** 
  * `x86_64` &nbsp;&nbsp; (Intel / AMD Desktop & Servers) — *Statically linked*
  * `ARM64 (aarch64)` &nbsp;&nbsp; (Apple Silicon, Raspberry Pi, Android Smartphones) — *Statically linked*
  * `RISC-V (riscv64)` &nbsp;&nbsp; (Modern RISC-V SBCs & Microcontrollers) — *Statically linked*
* ⚙️ **Core Engine:** &nbsp;&nbsp; ` C++ (ISO C++17) `
* 📊 **Report Export:** &nbsp;&nbsp; ` JSON (raw data) / HTML (interactive charts) `

---

**KATUSHA** is a high-performance C++ utility designed for intensive stress testing and benchmarking of core computer hardware components: the Central Processing Unit (CPU), System Memory (RAM), and the Storage Subsystem (Disk I/O). 

The application offers two operational modes: a versatile Command Line Interface (**CLI**) optimized for automated scripting and CI/CD integration, and an intuitive **interactive text-based interface** with cascading menus for manual performance tuning.

### ⚡ Multi-Architecture Autonomy
All distributed binaries are **completely statically linked (`-static`)**. They contain all necessary standard libraries (`glibc`, `libstdc++`) inside the executable payload. This guarantees successful execution across completely different environments (e.g., standard Linux distros, minimal Alpine Docker containers, and native Android environments) without any missing dependency or linker errors.

---

## ✨ Features and Test Suites

### 1. Processor Testing (CPU)
Evaluates core compute power and multi-threaded throughput via rigorous algorithmic workloads:
- **Mathematical Blocks:** Complex computations utilizing both Integer math and Floating-Point (Float) physics operations.
- **Cryptography & Compression:** Intense cryptographic workloads using the SHA-256 algorithm and data compression benchmarks using the LZ77 method.
- **Search & Sort Algorithms:** Massive memory efficiency tests featuring Bubble Sort, Insertion Sort, Selection Sort, Quick Sort, Merge Sort, and Shell Sort.
- **Multi-Core Stress:** Prime number calculations and raw multithreaded hardware saturation to verify CPU thermal and operational stability.

### 2. Memory Testing (RAM)
Measures memory subsystem bandwidth, speed, and latency during low-level memory manipulations:
- **Standard C Operations:** Benchmarking data processing speed utilizing standard `memcpy`, `memmove`, `memcmp`, and `memchr` functions.
- **Synthetic Patterns:** Pure sequential performance cycles recording raw data reading (Read), writing (Write), and block filling (`memset`).
- **Latency Tracking:** Precision tracking of memory responsiveness under randomized address access scenarios.

### 3. Storage Subsystem Testing (Disk I/O)
Verifies the practical speed thresholds of solid-state drives (SSD) and hard drives (HDD):
- **Linear Operations:** High-throughput Sequential Reading and Sequential Writing using large 1MB data blocks.
- **Random Access (4K):** Crucial 4KB random block reads and writes simulating heavy operating system runtime activity.
- **Queue Depth Saturation (QD32T4):** Multi-threaded random workload executing at a queue depth of 32 across 4 active worker threads.
- **Mixed Workloads:** A realistic execution pattern running concurrent reading and writing operations simultaneously at a 70% to 30% ratio.

---

## 🛠 Tech Stack and Architecture

- **Core Engine:** Native C++ (compiled under strict ISO C++17 with extreme `-O3` pipeline optimizations and native POSIX multi-threading via `-pthread`).
- **Data Export Engine:** Dual-logging framework. It generates structurally pristine **JSON files** for automated pipeline digestion, and rich **HTML reporting pages** complete with adaptive, interactive telemetry charts for graphical data inspection.
- **Architecture:** Modular design isolating performance modules into encapsulated tracker classes (`CpuBenchmark`, `MemoryBenchmark`, `DiskBenchmark`) tied to a static global metric publisher (`Report`).

---

## 🚀 Installation

The application is distributed as a set of pre-compiled cross-architecture binary files and does not require manual local compilation.

### 1. Global Linux Integration (x86_64, ARM64 SBCs, RISC-V)
The repository includes a smart `Makefile` wrapper that automatically detects your machine architecture, picks the corresponding binary (`_x86_64`, `_arm64`, or `_riscv64`), and integrates it globally:

```bash
# Register the correct pre-compiled binary globally to /usr/local/bin
sudo make install

# Cleanly purge the binary from system paths if needed:
sudo make uninstall
```

### 2. Android Execution (via ADB Shell)
Thanks to static linking, the `katusha_benchmark_arm64` binary runs flawlessly on modern Android devices (including Xiaomi HyperOS / MIUI, Samsung OneUI, etc.) directly via ADB without full Linux emulation.

Due to Android security restrictions (`noexec` flags on storage partitions), execution from user folders like `/sdcard` is restricted. Use the system temporary partition instead:

```bash
# 1. Push the ARM64 payload directly to the temporary system partition
adb push katusha_benchmark_arm64 /data/local/tmp/

# 2. Access the device environment
adb shell
cd /data/local/tmp/

# 3. Grant execution flags and launch the engine
chmod +x katusha_benchmark_arm64
./katusha_benchmark_arm64
```

---

## 📖 Usage Instructions

### Interactive Mode
Executing the utility without trailing parameters brings up the interactive text menu:
```bash
./katusha_benchmark

# If globally installed via Makefile on Linux, you can simply run it anywhere:
katusha_benchmark
```

### Automated Mode (CLI)
For pipeline integration, telemetry collections, or automated bash triggers, the application parses raw arguments in a strict parameter format.

#### ⚠️ Linux/Android Report Saving Mechanics
When executed globally from `/usr/local/bin` (or `/data/local/tmp` on Android), the reporting engines (`.json`, `.html`) and large test files (`katusha_test.bin`) are strictly compiled inside your **Current Working Directory (CWD)** where your terminal shell is sitting, and NOT where the binary lives. 
*Ensure your executing shell user possesses valid directory write permissions in your current active directory path.*

#### 1. Command Line Reference Help
To call the integrated manual containing precise execution IDs, software versions, and developer attributes:
```bash
katusha_benchmark -h
# or
katusha_benchmark --help
```

#### 2. Practical CLI Execution Examples
* **CPU Evaluation (Cryptography Suite):**
  Triggers a SHA-256 test pass (ID: 4) at a scale of 2000 complexity cycles across 5 tracking runs without exporting reports to disk:
  ```bash
  katusha_benchmark 1 4 2000 5 n
  ```

* **RAM Evaluation (Memory Copying Speed):**
  Triggers a low-level `memcpy` run (ID: 1) processing a 512MB primary memory matrix, 32MB latency step array, 10 loop cycles across 3 separate runs, and dumps a graphical HTML report (ID: 2):
  ```bash
  katusha_benchmark 2 1 512 32 10 3 y 2
  ```

* **Storage Evaluation (Random 4K Block Writes):**
  Triggers a Random 4K Write pass (ID: 3) spawning a 256MB scratch file, 5 data cycles across 3 sequential runs, and generates both JSON data and HTML graphic reports simultaneously (ID: 3):
  ```bash
  katusha_benchmark 3 3 256 5 3 y 3
  ```

* **Full Passthrough System Ingestion:**
  Sequentially spins up every available hardware diagnostic test block for the CPU, RAM, and Disk using production-grade standard metrics automatically:
  ```bash
  katusha_benchmark 4
  ```
