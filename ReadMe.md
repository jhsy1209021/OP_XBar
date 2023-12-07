# OP_XBar - XBar made Out-of-Parameters

## Introduction
This XBar supports out-standing access, and some properties, listed below, can be config using parameters.
- AXI4-Related
    - ID_WIDTH: Master's ID Width
    - IDS_WIDTH: Slaves's ID Width
    - ADDR_WIDTH: Address(Read & Write) Width
    - LEN_WIDTH: Burst Length Payload Width
    - SIZE_WIDTH: Data Size Payload Width
    - DATA_WIDTH: Data Width Payload Width
    - STRB_WIDTH: Data Strobe Payload Width
- Others
    - pending_depth: FIFO depth of every channels in XBar
    - masters: Number of master want to connect
    - slaves: Number of slave want to connect
    - address_map_base: Base address of each slaves
    - address_map_end: End address of each slaves

## Structure

## Usage