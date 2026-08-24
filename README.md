# Asynchronous MOD-10 Counter

## Overview
This repository contains the SystemVerilog implementation of an asynchronous MOD-10 (decade) counter. The design utilizes a chain of JK flip-flops configured to toggle on clock edges, counting upward from 0 to 9. Upon reaching the state of 10 (binary 1010), the counter utilizes combinatorial logic to trigger an active-low asynchronous reset, returning the count to 0.

## Repository Contents
* **design.sv**: Contains the structural/RTL SystemVerilog code for the MOD-10 counter (`async_mod_10_counter`) and the custom JK flip-flop module (`jk_ff`).
* **testbench.sv**: The testbench for driving the clock and monitoring the outputs.
* **waveform_result.pdf**: Simulation waveforms verifying the counter's behavior and reset logic.

## Truth Table and Reset Logic

The counter evaluates outputs `Q3` (MSB) through `Q0` (LSB). The active-low reset signal (`res`) is generated using a NAND gate on `Q3` and `Q1`: `res = ~(Q[3] & Q[1])`. 

When the count reaches 10 (binary 1010), `res` momentarily transitions to 0, clearing all flip-flops before the next clock edge.

| Decimal | Q3 (MSB) | Q2 | Q1 | Q0 (LSB) | res | State Note |
| :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| 0 | 0 | 0 | 0 | 0 | 1 | Valid State |
| 1 | 0 | 0 | 0 | 1 | 1 | Valid State |
| 2 | 0 | 0 | 1 | 0 | 1 | Valid State |
| 3 | 0 | 0 | 1 | 1 | 1 | Valid State |
| 4 | 0 | 1 | 0 | 0 | 1 | Valid State |
| 5 | 0 | 1 | 0 | 1 | 1 | Valid State |
| 6 | 0 | 1 | 1 | 0 | 1 | Valid State |
| 7 | 0 | 1 | 1 | 1 | 1 | Valid State |
| 8 | 1 | 0 | 0 | 0 | 1 | Valid State |
| 9 | 1 | 0 | 0 | 1 | 1 | Valid State |
| 10 | 1 | 0 | 1 | 0 | 0 | Transient State (Triggers Reset) |

## Simulation
To run the simulation, you can use any standard Verilog/SystemVerilog simulator (such as Icarus Verilog, ModelSim, or EDA Playground). Compile both `design.sv` and `testbench.sv`, then execute to view the waveform generation.
