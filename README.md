# Asynchronous_FIFO



asynchronous_fifo/

├── README.md
├── Makefile
├── .gitignore
│
├── rtl/                           # Design files
│   ├── async_fifo.v
│   └── fifo_top.v
│
└── tb/
    ├── tb_top.sv                  # Top module
    ├── interface.sv               # Interface
    ├── fifo_pkg.sv                # Package file
    │
    ├── items/                     # Sequence items
    │   ├── write_item.sv
    │   └── read_item.sv
    │
    ├── components/                # Drivers, Monitors, Scoreboard, Env
    │   ├── write_driver.sv
    │   ├── write_monitor.sv
    │   ├── write_agent.sv
    │   ├── read_driver.sv
    │   ├── read_monitor.sv
    │   ├── read_agent.sv
    │   ├── scoreboard.sv
    │   └── environment.sv
    │
    ├── sequences/                 # All sequence files
    │   ├── write_seq.sv
    │   ├── read_seq.sv
    │   └── virtual_seq.sv
    │
    └── tests/                     # Test classes
        ├── base_test.sv
        └── rand_test.sv
