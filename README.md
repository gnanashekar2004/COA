# 32-bit RISC-Like Processor Design in Verilog

## Overview

This project involves the design and synthesis of a 32-bit RISC-like processor using Verilog. The processor supports a range of instructions, addressing modes, and operations suitable for educational purposes in the Computer Organization and Architecture Laboratory course at IIT Kharagpur. The project is divided into several stages, each building on the previous to create a fully functional processor.

## Project Structure

- **ALU Design:** 
  - Implemented in structured Verilog to cover arithmetic and logic operations.
  - Includes a test bench for functional verification through simulation.
  - Tested on an FPGA kit.

- **Instruction Format and Control Unit Design:** 
  - Custom instruction format designed with necessary assumptions documented.
  - Schematic diagram of the data path and detailed design of the control unit provided.

- **Register Bank Integration:** 
  - 16 general-purpose 32-bit registers implemented.
  - Integrated with the ALU module.
  - Top-level module created for testing register operations.

- **Memory Implementation and Processor Integration:** 
  - Memory implemented as a one-dimensional register array.
  - Data path implemented using structural design methodology.
  - Control path implemented using a behavioral FSM design.
  - Fully integrated processor design tested on FPGA.

- **Test Benches:** 
  - Test benches written for two of the following problems:
    - Finding the GCD of two integers.
    - Sorting a set of 10 integers using bubble sort.
