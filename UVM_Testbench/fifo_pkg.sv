`ifndef FIFO_PKG_SV
`define FIFO_PKG_SV

package fifo_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // 1. Data Items / Transactions
  `include "write_item.sv"
  `include "read_item.sv"

  // 2. Drivers & Monitors
  `include "write_driver.sv"
  `include "read_driver.sv"
  `include "write_monitor.sv"
  `include "read_monitor.sv"

  // 3. Agents
  `include "write_agent.sv"
  `include "read_agent.sv"

  // 4. Scoreboard
  `include "scoreboard.sv"

  // 5. Environment
  `include "environment.sv"

  // 6. Sequences & Virtual Sequences
  `include "write_seq.sv"
  `include "read_seq.sv"
  `include "virtual_seq.sv"

  // 7. Tests
  `include "base_test.sv"
  `include "rand_test.sv"

endpackage : fifo_pkg

`endif
