

| Offset  | Name | Description |
| ------------- | ------------- | - |
| 0x00 | Control Register | Main control register for Servo PWM controller  |
| 0x04 | Reserved | |
| 0x08 | UI Clock Ticks Register | Defines number of clock ticks per Unit Interval (UI) |
| 0x0C | Frame UI Count Register | Defines width of frame in number of UI |
| 0x10 | Reserved | |
| 0x14 | Reserved | |
| 0x18 | Reserved | |
| 0x1C | Reserved | |
| 0x20 | Channel 0 UI Count Register | Defines number of UI the pulse is high in each frame |
| 0x24 | Channel 1 UI Count Register | Defines number of UI the pulse is high in each frame |
| 0x24 | Channel 2 UI Count Register | Defines number of UI the pulse is high in each frame |
| 0x2C | Channel 3 UI Count Register | Defines number of UI the pulse is high in each frame |

### Transmit Byte Register
| 31:20 | 19:16 | 15:8 | 7:4 | 3:0 |
| - | - | - | - | - |
| Reserved | Channel Active | Reserved | IOB | Channel Enable |

- Channel Active - Read Only status bit indicating that the channel is actively being driven.
- IOB - Tied to IOB pin of the IO Cell. Leave set to zero.
- Channel Enable - When set to 1, will cause the state machine to generate pulses. When a channel is first enabled, by design the state machine will generate pulses without glitches. Similarly when a channel is disabled, the state machine will complete the current frame before stopping.

### UI Clock Ticks Register
| 31:8 | 7:0 |
| - | - |
| Reserved | UI Clock Ticks Count |

- UI Clock Ticks Count - Defines the number of clock ticks per Unit Interval (UI)

### Frame UI Ticks Register
| 31:16 | 15:0 |
| - | - |
| Reserved | Frame UI Count |

- Frame UI Count - Defines the width of a frame in number of UI

### Channel 0 UI Count Register
### Channel 1 UI Count Register
### Channel 2 UI Count Register
### Channel 3 UI Count Register
| 31:12 | 11:0 |
| - | - |
| Reserved | Channel UI Count |

- Channel UI Count - Defines the width of the pulse in number of UI. By design, changing this register value will not take effect until the start of the next frame. This is to prevent glitches being accidently generated.
