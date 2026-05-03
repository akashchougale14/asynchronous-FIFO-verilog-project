# asynchronous-FIFO-verilog-project
A robust Verilog/SystemVerilog implementation of an Asynchronous FIFO (Dual-Clock FIFO) designed for safe data transfer between different clock domains, featuring Gray code pointer synchronization and metastability mitigation."
Asynchronous FIFO (Verilog)

Overview

This project implements an asynchronous FIFO in Verilog to transfer data between two different clock domains.

How it Works

The FIFO uses two pointers:

- Write pointer ("wr_ptr") to store data
- Read pointer ("rd_ptr") to fetch data

Since read and write clocks are different, direct comparison can cause metastability issues. To handle this, pointer values are synchronized across clock domains, typically using Gray code (only one bit changes at a time).

- FIFO is empty when both pointers are equal
- FIFO is full when write pointer catches up to read pointer

Simulation

Simulated in ModelSim using a testbench:

- Reset initializes FIFO ("empty = 1")
- Data is written using "wr_en"
- Data is read using "rd_en"
- Output follows FIFO order

"Waveform" (docs/waveform.png)

Tools Used

- Verilog HDL
- ModelSim

Note

Basic functionality (reset, write, read) is verified. Full condition testing can be extended further.
