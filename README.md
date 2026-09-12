# UART Communication System Using Verilog HDL

## RTL Design and Simulation of UART Transmitter and Receiver

### Overview

This project implements an 8-bit UART (Universal Asynchronous Receiver/Transmitter) communication system using Verilog HDL.

The design consists of:

- UART Transmitter (TX)
- UART Receiver (RX)
- Verilog testbenches
- UART TX-to-RX loopback verification

### Features

- 8-bit data transmission
- Start and stop bits
- LSB-first data transmission
- Configurable `CLKS_PER_BIT`
- UART transmitter and receiver
- Loopback verification
- Multiple data-pattern testing

### Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Visual Studio Code
- macOS

---

## Architecture

The overall UART system consists of a transmitter and receiver connected through a serial data line.

```text
Parallel Data
     |
     v
+-----------+
|  UART TX  |
+-----------+
     |
     | Serial Data
     v
+-----------+
|  UART RX  |
+-----------+
     |
     v
Received Data
---

## Author

**Trishita Bishwas**
