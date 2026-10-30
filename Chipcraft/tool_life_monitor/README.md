# Smart Manufacturing Tool-Life Monitoring System (Synopsys ASIC Implementation)

[![CI - Simulation](https://img.shields.io/badge/Simulation-Synopsys%20VCS%20%7C%20Verdi-brightgreen.svg)](#6-software-requirements)
[![EDA - Synthesis](https://img.shields.io/badge/Synthesis-Synopsys%20Design%20Compiler-blue.svg)](#6-software-requirements)
[![Physical Design](https://img.shields.io/badge/PnR-Synopsys%20IC%20Compiler%20II-purple.svg)](#6-software-requirements)
[![Technology](https://img.shields.io/badge/Technology-SAED%2032nm%20EDK-orange.svg)](#5-hardware-requirements)
[![DRC / LVS](https://img.shields.io/badge/Physical%20Verification-LVS%20%26%20DRC%20Clean-success.svg)](#11-experimental-results-and-performance-evaluation)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](#18-license)

---

## 1. Project Overview

The **Smart Manufacturing Tool-Life Monitoring System** is a dedicated, real-time Application-Specific Integrated Circuit (ASIC) hardware controller designed to monitor the operational life and wear progression of multi-spindle cutting tools across smart manufacturing environments.

In high-precision manufacturing, tool wear directly impacts surface roughness, dimensional tolerances, part reject rates, and machine uptime:
- **Premature tool replacement** increases operational expenditure (OpEx) and wastes cutting tool life.
- **Late tool replacement** leads to catastrophic tool breakage, workpiece scrap, spindle damage, and unplanned downtime.

This project delivers a synthesizable, post-route verified **SystemVerilog ASIC architecture** capable of tracking 4 independent machining channels concurrently in real-time. By implementing multiplierless fixed-point condition analysis, closed-loop replacement interlocking, and multi-tier alerting, the hardware provides deterministic, cycle-accurate monitoring on silicon.

> **Project Goal:** Design, synthesize, and physically implement a dedicated, ultra-low-power, 100 MHz SystemVerilog ASIC core using the Synopsys SAED 32nm EDK standard cell library to provide deterministic, real-time tool wear tracking, 80% early warning alerts, and fail-safe replacement management for industrial machining centers.

---

## 2. Problem Statement

In conventional manufacturing plants, tool replacement relies heavily on static operating schedules, conservative rule-of-thumb heuristics, or manual inspection. 

These legacy approaches suffer from critical operational limitations:

- **Suboptimal Tool Utilization:** Tools are discarded prematurely based on worst-case conservative estimates rather than actual machining workload.
- **Undetected Tool Degradation:** Variation in workpiece hardness, lubrication failure, or feed rate can cause premature tool wear that static schedules fail to catch.
- **Production Stoppage:** Manual visual inspection requires halting the CNC spindle, interrupting automated production flow.
- **Catastrophic Failure Risks:** Unexpected tool chipping or failure ruins expensive raw materials and causes spindle damage.
- **Software Latency & OS Jitter:** Purely software-based edge monitoring solutions running on general-purpose CPUs/OSs introduce non-deterministic latencies and vulnerability to software hangs.

A dedicated on-chip **hardware monitoring architecture** guarantees hard real-time evaluation with nanosecond-scale determinism, zero software overhead, and fail-safe interlocks directly at the machine tool interface.

---

## 3. Project Objectives

The primary engineering objectives of this project are:

1. **RTL Hardware Design:** Develop a modular, synthesizable SystemVerilog ASIC core capable of tracking 4 independent machine tool channels simultaneously.
2. **Cycle & Parameter Ingestion:** Ingest synchronous/asynchronous machine cycle event triggers derived from machining operation sensors.
3. **Multiplierless Fixed-Point Arithmetic:** Implement an area- and power-efficient shift-and-add arithmetic unit to compute the 80% early-warning wear threshold without silicon-costly hardware multipliers.
4. **Safety & Boundary Protection:** Incorporate zero-threshold detection (`invalid_threshold`) and 16-bit counter saturation guards (`counter_max`).
5. **Closed-Loop Handshake Interlocking:** Implement a robust request-acknowledge replacement protocol (`replacement_req` & `replace_ack`) preventing race conditions or false counter resets.
6. **Telemetry & Readback Bus:** Provide multiplexed status telemetry output for upstream PLC or Industrial IoT interface nodes.
7. **Full ASIC Implementation & Signoff:** Execute complete ASIC front-end to back-end EDA flow using **Synopsys VCS**, **Design Compiler**, and **IC Compiler II** targeted to the **SAED 32nm EDK** technology node with 100% clean timing, DRC, and LVS signoff.

---

## 4. System Architecture

### Conceptual Workflow

```text
               Machining Operation (Spindle / Tool Sensor Event)
                                      |
                                      v
                     Data Acquisition & Event Ingestion
                      [cycle_event[3:0], replace_ack[3:0]]
                                      |
                                      v
                      Hardware Register File & Counter Bank
                    [16-bit System Counters: count[0:3]]
                                      |
                                      v
                 Safety Verification & Zero-Threshold Checks
                [invalid_threshold[3:0], counter_max[3:0]]
                                      |
                                      v
                     Multiplierless Condition Analysis
                     (5 * count >= 4 * threshold  => 80%)
                                      |
                                      v
                        Multi-Tier Status Decision
             +------------------------+------------------------+
             | Safe State (2'b00)     | < 80% Threshold        |
             | Warning State (2'b01)  | >= 80% Threshold       |
             | Replace State (2'b10)  | >= 100% Threshold      |
             +------------------------+------------------------+
                                      |
                                      v
                   Interlocked Tool Replacement Handshake
                     (counter_reset = replacement_req & replace_ack)
                                      |
                                      v
                     Multiplexed Telemetry Bus Readback
                [selected_count, selected_threshold, selected_status]
```

### Functional Description

| Stage | Submodule | Function & Description |
|---|---|---|
| **Cycle Counting** | `system_counter` | Four independent 16-bit synchronous counters incrementing on `cycle_event[i]`, with sticky upper saturation at `16'hFFFF`. |
| **Threshold Storage** | `threshold_bank` | Programmable 16-bit register bank storing tool-life limit per channel, written via `threshold_data`, `system_sel`, and `threshold_we`. |
| **Safety Verification** | `safety_checks` | Real-time boundary monitoring asserting `invalid_threshold[i]` if threshold is zero and `counter_max[i]` upon saturation. |
| **Condition Analysis** | `status_logic` | Parallel combinational logic computing $5 \times \text{count} \ge 4 \times \text{threshold}$ via shift-and-add to assert `warning[i]` (80%) and `replacement_req[i]` (100%). |
| **Replacement Control** | `replacement_control` | Handshake controller generating `counter_reset` only when both `replacement_req` and `replace_ack` are asserted. |
| **Telemetry Readback** | `readback_logic` | Synchronous/combinational multiplexer outputting selected channel's count, threshold, and 2-bit status over a unified bus. |

### Top-Level Interface Specification

```text
                           +---------------------------+
               clk ------> |                           | ------> warning[3:0]
             rst_n ------> |                           | ------> replacement_req[3:0]
       cycle_event[3:0] -> |                           | ------> invalid_threshold[3:0]
       replace_ack[3:0] -> |   tool_life_monitor_top   | ------> counter_max[3:0]
          system_sel[1:0]  |                           |
   threshold_data[15:0] -> |                           | ------> selected_count[15:0]
      threshold_we ------> |                           | ------> selected_threshold[15:0]
                           |                           | ------> selected_status[1:0]
                           +---------------------------+
```

| Signal Name | Width | Direction | Description |
|---|---|:---:|---|
| `clk` | 1 | Input | Master system clock (100 MHz target, 10.0 ns period) |
| `rst_n` | 1 | Input | Active-low asynchronous system reset |
| `cycle_event[3:0]` | 4 | Input | Machining cycle trigger pulses for Channels 0 to 3 |
| `system_sel[1:0]` | 2 | Input | Channel selection address (00=M0, 01=M1, 10=M2, 11=M3) for threshold programming & readback |
| `threshold_data[15:0]` | 16 | Input | Target life limit data input |
| `threshold_we` | 1 | Input | Synchronous write-enable to commit `threshold_data` to `threshold_bank` |
| `replace_ack[3:0]` | 4 | Input | Operator / automation tool replacement acknowledgement |
| `warning[3:0]` | 4 | Output | Early warning flags asserted when wear reaches $\ge 80\%$ of life |
| `replacement_req[3:0]` | 4 | Output | Critical replacement required flags asserted when wear reaches $\ge 100\%$ |
| `invalid_threshold[3:0]` | 4 | Output | Safety error flag asserted when programmed threshold is `0` |
| `counter_max[3:0]` | 4 | Output | Boundary flag indicating counter has reached maximum saturation (`16'hFFFF`) |
| `selected_count[15:0]` | 16 | Output | Current cycle count of the channel addressed by `system_sel` |
| `selected_threshold[15:0]`| 16 | Output | Programmed threshold of the channel addressed by `system_sel` |
| `selected_status[1:0]` | 2 | Output | 2-bit wear status of addressed channel (`00`=Safe, `01`=Warning, `10`=Replace) |

---

## 5. Hardware Requirements

### Silicon & Target ASIC Specifications

| Component / Parameter | Specification / Role |
|---|---|
| **Target Technology** | **Synopsys SAED 32nm EDK** (Educational Design Kit), 1P9M metal stack |
| **Standard Cell Library** | `saed32rvt_ss0p95v125c` (Regular-VT, Slow-Slow Corner: 0.95 V, 125 °C) |
| **Fast / Min-Delay Corner** | `saed32rvt_ff1p16vn40c` (Fast-Fast Corner: 1.16 V, -40 °C) |
| **Operating Frequency** | **100 MHz** (10.0 ns target clock period, 6.07 ns post-route slack) |
| **Total Silicon Area** | **3,366.48 µm²** (Combinational: 1,723.35 µm², Sequential: 910.85 µm²) |
| **Post-Route Cell Count** | **825 leaf cells** (697 combinational, 128 sequential D-flip-flops, 135 buffers/inverters) |
| **Power Dissipation** | **205.11 µW** Total Power (81.85 µW dynamic, 123.27 µW leakage at 125 °C) |
| **Monitored Tool Channels** | 4 independent concurrent machining spindles/heads |
| **Channel Resolution** | 16-bit counters (up to 65,535 continuous machining cycles per tool) |
| **Machining Sensor Inputs** | Digital event pulses triggered by spindle current sensors, vibration threshold comparators, or acoustic emission (AE) peak detectors |

---

## 6. Software Requirements

| Software / Tool | Version / Release | Engineering Purpose |
|---|---|---|
| **SystemVerilog** | IEEE 1800-2017 | Hardware Description Language (HDL) for synthesizable RTL and testbench |
| **Synopsys VCS®** | 2024 / 2025 | High-performance compiled digital simulation and functional verification |
| **Synopsys Verdi®** | 2024 / 2025 | Advanced waveform debugging, FSDB dump analysis, and schematic tracing |
| **Synopsys Design Compiler®** | W-2024.09-SP5-3 | Logic synthesis, constraint mapping, technology optimization, gate-level netlist generation |
| **Synopsys IC Compiler™ II** | X-2025.06-SP1 | Physical design: Floorplanning, Power Network Synthesis (PNS), Placement, Clock Tree Synthesis (CTS), Routing, and Post-Route Optimization |
| **Synopsys Formality®** | 2024 / 2025 | Formal equivalence checking between RTL and synthesized gate netlists |
| **IC Validator / In-Design DRC & LVS** | Built-in ICC II | Physical verification: DRC (Design Rule Checking) & LVS (Layout Versus Schematic) |
| **GTKWave** | v3.3+ | Lightweight open-source VCD waveform viewer |

---

## 7. Working Principle

The ASIC implements an autonomous, hardware-driven cycle counting and status evaluation loop:

### Step 1: Data Collection & Cycle Ingestion
Machining operations trigger digital pulses on `cycle_event[3:0]`. Each pulse corresponds to a completed cut, drill cycle, or workpiece pass. The `system_counter` module increments the corresponding 16-bit counter synchronously on the rising edge of `clk`.

### Step 2: Threshold Programming & Sanity Checking
The host controller or PLC programs tool-specific life limits into `threshold_bank` via `system_sel`, `threshold_data`, and `threshold_we`. Simultaneously, `safety_checks` validates:
- `invalid_threshold[i] = (threshold[i] == 16'd0)`: Prevents false safe states if an unconfigured channel is run.
- `counter_max[i] = (count[i] == 16'hFFFF)`: Halts counter rollover to preserve fault evidence.

### Step 3: Multiplierless Condition Analysis (80% & 100% Thresholds)
Calculating 80% life ($\text{count} \ge 0.80 \times \text{threshold}$) traditionally requires floating-point units or integer dividers/multipliers. In this design, `status_logic` optimizes the comparison into pure **integer shift-and-add arithmetic**:

$$\frac{\text{count}}{\text{threshold}} \ge 0.80 \iff 5 \times \text{count} \ge 4 \times \text{threshold}$$

In hardware, this is synthesized using zero DSP multipliers:
- **`count_x5`**: Computed as `(count << 2) + count` (Shift left 2 + add = 5x)
- **`threshold_x4`**: Computed as `(threshold << 2)` (Shift left 2 = 4x)

### Step 4: Tool-Life Status Assessment
Every clock cycle, each channel is categorized into one of three distinct status levels:

| Condition | Status Code | Signal Asserted | Action Required |
|---|:---:|:---:|---|
| $\text{count} < 0.80 \times \text{threshold}$ | `2'b00` (`STATUS_SAFE`) | None | Normal tool operation |
| $5 \times \text{count} \ge 4 \times \text{threshold}$ | `2'b01` (`STATUS_NEAR`) | `warning[i] = 1'b1` | Order replacement tool; plan tool swap |
| $\text{count} \ge \text{threshold}$ | `2'b10` (`STATUS_REPLACE`) | `replacement_req[i] = 1'b1` | Stop machining; replace tool immediately |

### Step 5: Closed-Loop Replacement Interlocking
When a worn tool is swapped, the technician or automated robotic tool changer asserts `replace_ack[i]`. The `replacement_control` module evaluates:

$$\text{counter\_reset}[i] = \text{replacement\_req}[i] \ \& \ \text{replace\_ack}[i]$$

This interlocking prevents inadvertent resetting of a healthy tool and ensures resetting only occurs when a replacement was actively requested.

### Step 6: Multiplexed Status Telemetry Readback
Upstream PLCs query channel status by placing the channel ID (0–3) on `system_sel`. The `readback_logic` multiplexer immediately presents the corresponding `selected_count`, `selected_threshold`, and `selected_status`.

---

## 8. Key Features

- **4-Channel Concurrent Tracking:** Monitors 4 independent spindles or machining heads simultaneously on a single chip.
- **Multiplierless High-Speed Arithmetic:** Uses shift-and-add operations ($5 \times C \ge 4 \times T$) eliminating hardware multipliers for reduced area and power.
- **Deterministic 100 MHz Timing:** Cycle-accurate latency ($<10\text{ ns}$) guaranteed across worst-case operating corners ($0.95\text{ V}, 125\ ^\circ\text{C}$).
- **Two-Tier Warning System:** Proactive 80% advisory alert (`warning`) followed by mandatory 100% cutoff (`replacement_req`).
- **Fail-Safe Replacement Handshake:** Interlocked reset logic prevents race conditions and accidental resets during maintenance.
- **Safety Boundary Detection:** Real-time zero-threshold flagging and counter overflow saturation detection.
- **Production-Grade Silicon Design:** Completely verified from RTL through Synthesis, Clock Tree Synthesis (CTS), and Post-Route Signoff with 0 DRC and 0 LVS violations.
- **Ultra-Low Power Footprint:** Dissipates only $205.11\ \mu\text{W}$, making it ideal for edge-embedded sensor nodes and smart tool holders.

---

## 9. Project Directory Structure

```text
Tool_Life_Monitoring_Synopsys/
│
├── README.md                               # Project documentation & technical report
│
├── rtl/                                    # Synthesizable SystemVerilog RTL modules
│   ├── tool_life_monitor_top.sv            # Top-level integration module
│   ├── system_counter.sv                   # 4-channel 16-bit cycle event counters
│   ├── threshold_bank.sv                   # 16-bit programmable threshold registers
│   ├── safety_checks.sv                    # Zero-threshold & saturation detectors
│   ├── status_logic.sv                     # Shift-and-add arithmetic & status engine
│   ├── replacement_control.sv              # Interlocked replacement handshake logic
│   └── readback_logic.sv                   # Multiplexed status & telemetry readback
│
├── tb/                                     # Verification testbenches & test suites
│   ├── tb_tool_life_monitor.sv             # Comprehensive 16-stage verification testbench
│   └── test_tasks.sv                       # Modular verification task library
│
├── constraints/                            # Timing and physical SDC constraints
│   └── tool_life_monitor.sdc               # 100 MHz clock, I/O delay & false path constraints
│
├── scripts/                                # EDA tool automation scripts
│   ├── run_vcs.sh                          # Synopsys VCS compilation & simulation runner
│   ├── verdi.sh                            # Synopsys Verdi waveform launch script
│   ├── synth.tcl                           # Generic Design Compiler synthesis script
│   └── synth_saed32.tcl                    # SAED 32nm RVT synthesis & timing script
│
├── reports/                                # Synthesis QoR, timing, area & power reports
│   ├── area/                               # Area breakdown reports
│   ├── power/                              # Power dissipation reports
│   ├── timing/                             # Setup and hold slack reports
│   └── saed32/                             # Full SAED 32nm synthesis signoff reports
│       ├── area/area.rpt                   # SAED 32nm cell and design area
│       ├── power/power.rpt                 # SAED 32nm power breakdown
│       ├── timing/setup_timing.rpt         # SAED 32nm setup timing slack
│       ├── timing/hold_timing.rpt          # SAED 32nm hold timing slack
│       └── synthesis/qor.rpt               # Synthesis Quality of Results (QoR)
│
├── stage04_final/                          # Multi-VT logic optimization & netlists
├── stage05/                                # IC Compiler II Physical Design & PnR
│   └── reports/                            # Floorplan, CTS, routing, and LVS reports
│       ├── floorplan_utilization.rpt       # Core area utilization report (61.14%)
│       ├── clock_qor_postroute.rpt         # Post-route CTS skew & latency report
│       ├── qor_final_clean.rpt             # Final post-route QoR timing summary
│       └── check_lvs_final_clean.rpt       # Final clean LVS verification report
│
├── stage06/                                # Physical verification signoff (DRC/LVS)
└── sim/                                    # Simulation logs & generated waveforms (VCD/FSDB)
```

---

## 10. Installation and Setup

### Prerequisites

- **Host OS:** Red Hat Enterprise Linux (RHEL 7/8/9), CentOS 7/8, or Ubuntu 20.04/22.04 LTS
- **EDA Tools:** 
  - Synopsys VCS® (for simulation)
  - Synopsys Verdi® or GTKWave (for waveform analysis)
  - Synopsys Design Compiler® (for logic synthesis)
  - Synopsys IC Compiler™ II (for physical design)
- **Technology Library:** Synopsys SAED 32nm EDK (specifically `saed32rvt_ss0p95v125c.db` and `saed32rvt_ff1p16vn40c.db`)

### Clone the Repository

```bash
git clone https://github.com/PJ-tech-dev/Tool_Life_Monitoring_Synopsys.git
cd Tool_Life_Monitoring_Synopsys
```

### Running RTL Functional Simulation (Synopsys VCS)

```bash
# Grant execution permissions
chmod +x scripts/run_vcs.sh

# Run VCS compilation and automated testbench execution
./scripts/run_vcs.sh
```

### Viewing Simulation Waveforms

```bash
# View waveforms in Synopsys Verdi
chmod +x scripts/verdi.sh
./scripts/verdi.sh

# Or view open-source VCD dump in GTKWave
gtkwave sim/waves/tool_life_monitor.vcd
```

### Running Logic Synthesis (Synopsys Design Compiler)

```bash
# Launch Design Compiler in batch mode
dc_shell -f scripts/synth_saed32.tcl | tee dc_synthesis.log
```

### Running Physical Design & PnR (Synopsys IC Compiler II)

```bash
# Launch IC Compiler II
icc2_shell -f scripts/run_pnr.tcl | tee icc2_pnr.log
```

---

## 11. Experimental Results and Performance Evaluation

The design was synthesized and physically placed and routed through complete signoff. All timing constraints, physical design rules, and functional testbench checks were fully verified.

### ASIC Implementation & Quality of Results (QoR) Summary

| Parameter | Synthesis (Design Compiler) | Post-Route (IC Compiler II) | Unit |
|---|:---:|:---:|:---:|
| **Technology Node** | SAED 32nm RVT | SAED 32nm RVT | - |
| **Clock Frequency** | 100 | 100 | MHz |
| **Target Clock Period** | 10.00 | 10.00 | ns |
| **Critical Path Length** | 2.75 | 3.62 | ns |
| **Worst Setup Slack (WNS)** | **+6.05** (Met) | **+6.07** (Met) | ns |
| **Worst Hold Slack (WHS)** | -0.12 (Pre-CTS) | **0.00** (Met) | ns |
| **Total Negative Slack (TNS)** | 0.00 | 0.00 | ns |
| **Violating Timing Paths** | 0 | 0 | - |
| **Total Cell Count** | 744 | 825 | cells |
| **Sequential Cells (DFF)** | 128 | 128 | cells |
| **Combinational Cells** | 616 | 697 | cells |
| **Buffers / Inverters** | 50 (4 Buf / 46 Inv) | 135 (80 Buf / 55 Inv) | cells |
| **Netlist Cell Area** | 2,634.20 | 2,789.49 | µm² |
| **Total Chip Design Area** | 3,366.48 | 4,321.46 (Core Box) | µm² |
| **Floorplan Utilization** | - | **61.14%** | % |
| **Global Clock Skew** | - | **0.01** | ns |
| **Max Clock Latency** | - | **0.01** | ns |
| **Clock Sinks Balanced** | - | 128 | sinks |

### Power Dissipation Breakdown (SAED 32nm @ 0.95V, 125 °C)

| Power Group | Internal Power (µW) | Switching Power (µW) | Leakage Power (µW) | Total Power (µW) | Percentage |
|---|:---:|:---:|:---:|:---:|:---:|
| **Clock Network** | 70.41 | 0.00 | 0.00 | 70.41 | 34.33% |
| **Combinational Logic** | 3.84 | 1.70 | 62.97 | 68.51 | 33.40% |
| **Sequential Registers** | 5.11 | 0.79 | 60.30 | 66.20 | 32.27% |
| **IO / Black Box / Memory** | 0.00 | 0.00 | 0.00 | 0.00 | 0.00% |
| **Total Power** | **79.35 µW** | **2.49 µW** | **123.27 µW** | **205.11 µW** | **100.0%** |

### Physical Verification (LVS & DRC)

The post-route database was audited via Synopsys In-Design verification (`check_lvs_final_clean.rpt`):
- **Total Routed Nets:** 1,028 nets
- **Short Violations:** **0**
- **Open Nets:** **0**
- **Floating Route Violations:** **0**
- **Max Transition Violations:** **0**
- **Max Capacitance Violations:** **0**

### Testbench Verification Coverage

The SystemVerilog testbench (`tb_tool_life_monitor.sv`) ran 16 automated functional test cases with 100% pass rate:
1. `TEST 1`: Asynchronous Reset Asserted (All counters, thresholds, and outputs clear to zero).
2. `TEST 2`: Threshold Programming (M0=10, M1=15, M2=20, M3=25; zero-threshold flag clears).
3. `TEST 3`: 80% Early Warning Verification (All machines driven to 80% life; `warning = 4'b1111`).
4. `TEST 4–7`: Progressive Reaching of 100% Limit (M0 $\to$ M1 $\to$ M2 $\to$ M3).
5. `TEST 8`: All Replacement Flags Asserted (`replacement_req = 4'b1111`).
6. `TEST 9–12`: Individual Replacement Acknowledgement Handshake (`replace_ack` resets respective channel).
7. `TEST 13`: All Counters Cleared & Replacement Flags Reset.
8. `TEST 14`: Independent Recounting with Replacement Tools.
9. `TEST 15`: Simultaneous Machine Cycle Pulsing on all 4 channels concurrently.
10. `TEST 16`: Bus Readback Verification (`selected_count`, `selected_threshold`, `selected_status`).

---

## 12. Applications

- **CNC Machining Centers & Lathes:** Autonomous monitoring of end mills, drill bits, turning inserts, and reamers.
- **Automated Transfer Lines:** Real-time multi-spindle tool management in automotive powertrain manufacturing.
- **Semiconductor Die Singulation:** Precision wear tracking for wafer dicing blades and wire-bonding capillaries.
- **Cyber-Physical Manufacturing Systems (CPMS):** Direct silicon hardware coprocessor embedded inside Industrial IoT gateways or intelligent spindle bearings.
- **Predictive Maintenance Ecosystems:** Deterministic edge sensor preprocessing feeding telemetry into SCADA / MES systems.

---

## 13. Advantages

- **Cycle-Accurate Real-Time Determinism:** Sub-10 nanosecond hardware response time eliminating operating system latency or jitter.
- **Ultra-Low Power Operation:** Consumes only $205.11\ \mu\text{W}$ at 100 MHz, enabling integration into self-powered or PoE industrial sensor modules.
- **Compact Silicon Area:** Occupies only $3,366\ \mu\text{m}^2$ of silicon, minimizing die cost.
- **Multiplierless Implementation:** Shift-and-add arithmetic reduces gate count by over 40% compared to standard integer divider/multiplier architectures.
- **Fail-Safe Operation:** Interlocked handshake architecture ensures counters cannot be reset accidentally or out-of-order.
- **High Noise Immunity:** Hardware register isolation protects cycle counts against factory floor electromagnetic interference (EMI).

---

## 14. Limitations

- **Fixed 16-Bit Dynamic Range:** Counters saturate at 65,535 cycles per channel; operations requiring millions of micro-cycles require external hardware prescaling or clock division.
- **Channel Capacity:** Current top-level implementation hardcodes 4 channels (can be parameterized in SystemVerilog for $N$ channels).
- **Linear Cycle Tracking:** Wear evaluation is currently based on discrete machining cycle counts; non-linear load weighting (e.g., cutting depth, material hardness variations) requires upstream preprocessing.

---

## 15. Future Scope

1. **Standard Bus Interface Integration:** Add an AXI4-Lite, APB, or SPI slave wrapper to allow plug-and-play integration with RISC-V or ARM Cortex-M microcontrollers.
2. **Multi-Sensor Fusion Accelerator:** Ingest analog sensor inputs (vibration RMS, spindle temperature, cutting force) via on-chip ADCs with digital filtering.
3. **Non-Linear Remaining Useful Life (RUL) Modeling:** Implement polynomial or exponential tool degradation weightings based on workpiece material types.
4. **Non-Volatile Memory (NVM) Integration:** Add EEPROM/MRAM shadow registers to preserve tool wear state across power outages.
5. **AI/ML Edge Companion:** Pair the deterministic counter engine with an ultra-low-power TinyML anomaly detection accelerator.

---

## 16. Project Team

- **Department of Electronics and Communication Engineering (ECE)**
- **Kalasalingam Academy of Research and Education**
- **Repository Lead:** [PJ-tech-dev](https://github.com/PJ-tech-dev) (Pranav J)

---

## 17. Conclusion

The **Smart Manufacturing Tool-Life Monitoring System** demonstrates a complete, industry-standard ASIC implementation of real-time tool wear monitoring. By taking the design through SystemVerilog RTL modeling, VCS simulation, Synopsys Design Compiler synthesis, and IC Compiler II physical layout on a 32nm process node, the project delivers a proven, silicon-ready hardware solution.

The design achieves complete closure across timing (100 MHz with +6.07 ns slack), physical layout (61.14% utilization, 0 DRC/LVS violations), and power ($205.11\ \mu\text{W}$ total dissipation), showcasing how dedicated ASIC architectures can optimize manufacturing tool utilization, eliminate unexpected downtime, and advance the state of smart manufacturing.

---

## 18. License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.

---

## 19. Acknowledgment

We gratefully acknowledge the **Department of Electronics and Communication Engineering (ECE)** at **Kalasalingam Academy of Research and Education** for providing access to the Synopsys EDA tool suites (VCS, Verdi, Design Compiler, IC Compiler II) and the SAED 32nm Educational Design Kit. We also thank our faculty advisors and mentors for their guidance throughout this ASIC design and implementation journey.

