<?xml version="1.0" encoding="UTF-8"?>
<wavelist version="3">
  <insertion-point-position>50</insertion-point-position>
  <wave>
    <expr>aclk_m</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>aclk_s</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>&lt;embedded&gt;::top.axi_master_0.genPropChksWRInf.genAXI4FullWrResp.slave_b_aw_bid_match</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>axi_master_0.aclk</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>axi_master_0.aresetn</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>axi_master_0.bvalid</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>axi_master_0.wr_bid_match</expr>
    <label/>
    <radix/>
  </wave>
  <group collapsed="true">
    <expr/>
    <label>axi_master_1</label>
    <wave>
      <expr>axi_master_1.aclk</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_master_1.aresetn</expr>
      <label/>
      <radix/>
    </wave>
    <group collapsed="true">
      <expr/>
      <label>Write Channels(axi_master_1)</label>
      <group collapsed="true">
        <expr/>
        <label>AW</label>
        <wave>
          <expr>axi_master_1.awvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_1.awready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_1.awlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awaddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.awuser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>W</label>
        <wave>
          <expr>axi_master_1.wvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_1.wready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.wid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_1.wlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.wstrb</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.wuser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.wdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>B</label>
        <wave>
          <expr>axi_master_1.bvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_1.bready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.bid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.bresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.buser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
    <group collapsed="true">
      <expr/>
      <label>Read Channels(axi_master_1)</label>
      <group collapsed="true">
        <expr/>
        <label>AR</label>
        <wave>
          <expr>axi_master_1.arvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_1.arready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.arid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.arlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_1.arlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.araddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.arsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.arburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.arprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.arcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.arqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.arregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.aruser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>R</label>
        <wave>
          <expr>axi_master_1.rvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_1.rready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.rid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_1.rlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.rresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.ruser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_1.rdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
  </group>
  <group collapsed="false">
    <expr/>
    <label>axi_master_0</label>
    <wave>
      <expr>axi_master_0.aclk</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_master_0.aresetn</expr>
      <label/>
      <radix/>
    </wave>
    <group collapsed="false">
      <expr/>
      <label>Write Channels(axi_master_0)</label>
      <group collapsed="false">
        <expr/>
        <label>AW</label>
        <wave>
          <expr>axi_master_0.awvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_0.awready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.awid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.awlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.awaddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.awburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>W</label>
        <wave>
          <expr>axi_master_0.wvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_0.wready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.wid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_0.wlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.wstrb</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.wuser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.wdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="false">
        <expr/>
        <label>B</label>
        <wave>
          <expr>axi_master_0.bvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_0.bready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.bid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.bresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
      </group>
    </group>
    <group collapsed="true">
      <expr/>
      <label>Read Channels(axi_master_0)</label>
      <group collapsed="true">
        <expr/>
        <label>AR</label>
        <wave>
          <expr>axi_master_0.arvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_0.arready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.arid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.arlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_0.arlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.araddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.arsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.arburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.arprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.arcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.arqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.arregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.aruser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>R</label>
        <wave>
          <expr>axi_master_0.rvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_0.rready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.rid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_master_0.rlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.rresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.ruser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_master_0.rdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
  </group>
  <group collapsed="true">
    <expr/>
    <label>axi_slave_0</label>
    <wave>
      <expr>axi_slave_0.aclk</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_slave_0.aresetn</expr>
      <label/>
      <radix/>
    </wave>
    <group collapsed="false">
      <expr/>
      <label>Write Channels(axi_slave_0)</label>
      <group collapsed="true">
        <expr/>
        <label>AW</label>
        <wave>
          <expr>axi_slave_0.awvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_0.awready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_0.awlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awaddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.awuser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>W</label>
        <wave>
          <expr>axi_slave_0.wvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_0.wready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.wid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_0.wlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.wstrb</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.wuser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.wdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>B</label>
        <wave>
          <expr>axi_slave_0.bvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_0.bready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.bid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.bresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.buser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
    <group collapsed="true">
      <expr/>
      <label>Read Channels(axi_slave_0)</label>
      <group collapsed="true">
        <expr/>
        <label>AR</label>
        <wave>
          <expr>axi_slave_0.arvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_0.arready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.arid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.arlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_0.arlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.araddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.arsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.arburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.arprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.arcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.arqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.arregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.aruser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>R</label>
        <wave>
          <expr>axi_slave_0.rvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_0.rready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.rid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_0.rlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.rresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.ruser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_0.rdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
  </group>
  <group collapsed="true">
    <expr/>
    <label>axi_slave_1</label>
    <wave>
      <expr>axi_slave_1.aclk</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_slave_1.aresetn</expr>
      <label/>
      <radix/>
    </wave>
    <group collapsed="true">
      <expr/>
      <label>Write Channels(axi_slave_1)</label>
      <group collapsed="true">
        <expr/>
        <label>AW</label>
        <wave>
          <expr>axi_slave_1.awvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_1.awready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_1.awlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awaddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.awuser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>W</label>
        <wave>
          <expr>axi_slave_1.wvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_1.wready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.wid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_1.wlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.wstrb</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.wuser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.wdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>B</label>
        <wave>
          <expr>axi_slave_1.bvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_1.bready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.bid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.bresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.buser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
    <group collapsed="true">
      <expr/>
      <label>Read Channels(axi_slave_1)</label>
      <group collapsed="true">
        <expr/>
        <label>AR</label>
        <wave>
          <expr>axi_slave_1.arvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_1.arready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.arid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.arlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_1.arlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.araddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.arsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.arburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.arprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.arcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.arqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.arregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.aruser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>R</label>
        <wave>
          <expr>axi_slave_1.rvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_1.rready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.rid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_1.rlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.rresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.ruser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_1.rdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
  </group>
  <group collapsed="true">
    <expr/>
    <label>axi_slave_2</label>
    <wave>
      <expr>axi_slave_2.aclk</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_slave_2.aresetn</expr>
      <label/>
      <radix/>
    </wave>
    <group collapsed="true">
      <expr/>
      <label>Write Channels(axi_slave_2)</label>
      <group collapsed="true">
        <expr/>
        <label>AW</label>
        <wave>
          <expr>axi_slave_2.awvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_2.awready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_2.awlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awaddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.awuser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>W</label>
        <wave>
          <expr>axi_slave_2.wvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_2.wready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.wid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_2.wlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.wstrb</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.wuser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.wdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>B</label>
        <wave>
          <expr>axi_slave_2.bvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_2.bready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.bid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.bresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.buser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
    <group collapsed="true">
      <expr/>
      <label>Read Channels(axi_slave_2)</label>
      <group collapsed="true">
        <expr/>
        <label>AR</label>
        <wave>
          <expr>axi_slave_2.arvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_2.arready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.arid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.arlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_2.arlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.araddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.arsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.arburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.arprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.arcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.arqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.arregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.aruser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>R</label>
        <wave>
          <expr>axi_slave_2.rvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_2.rready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.rid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_2.rlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.rresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.ruser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_2.rdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
  </group>
  <group collapsed="true">
    <expr/>
    <label>axi_slave_3</label>
    <wave>
      <expr>axi_slave_3.aclk</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_slave_3.aresetn</expr>
      <label/>
      <radix/>
    </wave>
    <group collapsed="true">
      <expr/>
      <label>Write Channels(axi_slave_3)</label>
      <group collapsed="true">
        <expr/>
        <label>AW</label>
        <wave>
          <expr>axi_slave_3.awvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_3.awready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_3.awlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awaddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.awuser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>W</label>
        <wave>
          <expr>axi_slave_3.wvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_3.wready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.wid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_3.wlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.wstrb</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.wuser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.wdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>B</label>
        <wave>
          <expr>axi_slave_3.bvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_3.bready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.bid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.bresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.buser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
    <group collapsed="true">
      <expr/>
      <label>Read Channels(axi_slave_3)</label>
      <group collapsed="true">
        <expr/>
        <label>AR</label>
        <wave>
          <expr>axi_slave_3.arvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_3.arready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.arid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.arlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_3.arlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.araddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.arsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.arburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.arprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.arcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.arqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.arregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.aruser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>R</label>
        <wave>
          <expr>axi_slave_3.rvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_3.rready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.rid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_3.rlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.rresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.ruser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_3.rdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
  </group>
  <group collapsed="true">
    <expr/>
    <label>axi_slave_4</label>
    <wave>
      <expr>axi_slave_4.aclk</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_slave_4.aresetn</expr>
      <label/>
      <radix/>
    </wave>
    <group collapsed="true">
      <expr/>
      <label>Write Channels(axi_slave_4)</label>
      <group collapsed="true">
        <expr/>
        <label>AW</label>
        <wave>
          <expr>axi_slave_4.awvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_4.awready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_4.awlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awaddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.awuser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>W</label>
        <wave>
          <expr>axi_slave_4.wvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_4.wready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.wid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_4.wlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.wstrb</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.wuser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.wdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>B</label>
        <wave>
          <expr>axi_slave_4.bvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_4.bready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.bid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.bresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.buser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
    <group collapsed="true">
      <expr/>
      <label>Read Channels(axi_slave_4)</label>
      <group collapsed="true">
        <expr/>
        <label>AR</label>
        <wave>
          <expr>axi_slave_4.arvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_4.arready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.arid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.arlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_4.arlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.araddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.arsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.arburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.arprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.arcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.arqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.arregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.aruser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>R</label>
        <wave>
          <expr>axi_slave_4.rvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_4.rready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.rid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_4.rlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.rresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.ruser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_4.rdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
  </group>
  <group collapsed="true">
    <expr/>
    <label>axi_slave_5</label>
    <wave>
      <expr>axi_slave_5.aclk</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_slave_5.aresetn</expr>
      <label/>
      <radix/>
    </wave>
    <group collapsed="true">
      <expr/>
      <label>Write Channels(axi_slave_5)</label>
      <group collapsed="true">
        <expr/>
        <label>AW</label>
        <wave>
          <expr>axi_slave_5.awvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_5.awready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_5.awlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awaddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.awuser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>W</label>
        <wave>
          <expr>axi_slave_5.wvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_5.wready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.wid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_5.wlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.wstrb</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.wuser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.wdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>B</label>
        <wave>
          <expr>axi_slave_5.bvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_5.bready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.bid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.bresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.buser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
    <group collapsed="true">
      <expr/>
      <label>Read Channels(axi_slave_5)</label>
      <group collapsed="true">
        <expr/>
        <label>AR</label>
        <wave>
          <expr>axi_slave_5.arvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_5.arready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.arid</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.arlen</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_5.arlock</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.araddr</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.arsize</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.arburst</expr>
          <label/>
          <radix>axi_master_1.excl_burst[0].burst</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.arprot</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.arcache</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.arqos</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.arregion</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.aruser</expr>
          <label/>
          <radix/>
        </wave>
      </group>
      <group collapsed="true">
        <expr/>
        <label>R</label>
        <wave>
          <expr>axi_slave_5.rvalid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_5.rready</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.rid</expr>
          <label/>
          <radix/>
        </wave>
        <wave>
          <expr>axi_slave_5.rlast</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.rresp</expr>
          <label/>
          <radix>axi_master_1.bresp</radix>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.ruser</expr>
          <label/>
          <radix/>
        </wave>
        <wave collapsed="true">
          <expr>axi_slave_5.rdata</expr>
          <label/>
          <radix/>
        </wave>
      </group>
    </group>
  </group>
  <spacer/>
  <wave>
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.full</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.push</expr>
    <label/>
    <radix/>
  </wave>
  <wave collapsed="true">
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.AWID</expr>
    <label/>
    <radix/>
  </wave>
  <wave collapsed="true">
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.AWADDR</expr>
    <label/>
    <radix/>
  </wave>
  <wave collapsed="true">
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.AWLEN</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.empty</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.pop</expr>
    <label/>
    <radix/>
  </wave>
  <wave collapsed="true">
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.slave_grant_me_write_addr</expr>
    <label/>
    <radix/>
    <wave>
      <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.slave_grant_me_write_addr[5]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.slave_grant_me_write_addr[4]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.slave_grant_me_write_addr[3]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.slave_grant_me_write_addr[2]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.slave_grant_me_write_addr[1]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.slave_grant_me_write_addr[0]</expr>
      <label/>
      <radix/>
    </wave>
  </wave>
  <wave>
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.some_slaves_grant_me_write_addr</expr>
    <label/>
    <radix/>
  </wave>
  <wave collapsed="true">
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.front_AWID</expr>
    <label/>
    <radix/>
  </wave>
  <wave collapsed="true">
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.front_AWADDR</expr>
    <label/>
    <radix/>
  </wave>
  <wave collapsed="true">
    <expr>axi_duv_bridge.slave_interfaces[0].generate_slave_interfaces.master_forward_aw_fifo.front_AWLEN</expr>
    <label/>
    <radix/>
  </wave>
  <spacer/>
  <wave>
    <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.write_addr_forward_arbiter.grant_master_number</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.full</expr>
    <label/>
    <radix/>
  </wave>
  <wave>
    <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.push</expr>
    <label/>
    <radix/>
  </wave>
  <wave collapsed="true">
    <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.AWID</expr>
    <label/>
    <radix/>
    <wave>
      <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.AWID[7]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.AWID[6]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.AWID[5]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.AWID[4]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.AWID[3]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.AWID[2]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.AWID[1]</expr>
      <label/>
      <radix/>
    </wave>
    <wave>
      <expr>axi_duv_bridge.master_interfaces[0].generate_master_interfaces.master_forward_aw_fifo.AWID[0]</expr>
      <label/>
      <radix/>
    </wave>
  </wave>
</wavelist>
