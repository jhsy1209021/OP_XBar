#DO NOT MODIFY THIS FILE
set ABVIP_INST_DIR /usr/cad/cadence/VIPCAT/cur/tools/abvip
set vip_dir $::env(vip_dir)

# Stress XBar FIFO, try to fill up every fifos
set master_maxpend 64
set slave_maxpend 4

abvip -set_location $ABVIP_INST_DIR
set_visualize_auto_load_debugging_tables on
analyze -f $vip_dir/bridge_duv/jg.f -sv09
elaborate -top top \
-param top.axi_master_0.MAX_PENDING $master_maxpend -param top.axi_master_1.MAX_PENDING $master_maxpend\
-param top.axi_slave_0.MAX_PENDING $slave_maxpend -param top.axi_slave_1.MAX_PENDING $slave_maxpend\
-param top.axi_slave_2.MAX_PENDING $slave_maxpend -param top.axi_slave_3.MAX_PENDING $slave_maxpend\
-param top.axi_slave_4.MAX_PENDING $slave_maxpend -param top.axi_slave_5.MAX_PENDING $slave_maxpend\

clock aclk_m
clock aclk_s
reset ~aresetn_m ~aresetn_s

#Master0 assertion setup
assert -disable top.axi_master_0.genPropChksRDInf.genNoRdTblOverflow.genSlv.slave_ar_rd_tbl_no_overflow
assert -disable top.axi_master_0.genPropChksWRInf.genNoWrTblOverflow.genSlv.slave_aw_wr_tbl_no_overflow
assert -disable top.axi_master_0.genPropChksWRInf.genNoWrDatTblOverflow.genSlv.slave_w_wr_tbl_no_overflow
assert -disable top.axi_master_0.genStableChks.genStableChksWRInf.genAXI4Full.slave_b_buser_stable
assert -disable top.axi_master_0.genStableChks.genStableChksRDInf.genAXI4Full.slave_r_ruser_stable 
assert -disable top.axi_master_0.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave
assume -disable top.axi_master_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assume -disable top.axi_master_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assume -disable top.axi_master_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_fixed_arlen

#Master1 assertion setup
assert -disable top.axi_master_1.genPropChksRDInf.genNoRdTblOverflow.genSlv.slave_ar_rd_tbl_no_overflow
assert -disable top.axi_master_1.genPropChksWRInf.genNoWrTblOverflow.genSlv.slave_aw_wr_tbl_no_overflow
assert -disable top.axi_master_1.genPropChksWRInf.genNoWrDatTblOverflow.genSlv.slave_w_wr_tbl_no_overflow
assert -disable top.axi_master_1.genStableChks.genStableChksWRInf.genAXI4Full.slave_b_buser_stable
assert -disable top.axi_master_1.genStableChks.genStableChksRDInf.genAXI4Full.slave_r_ruser_stable 
assert -disable top.axi_master_1.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave
assume -disable top.axi_master_1.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assume -disable top.axi_master_1.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assume -disable top.axi_master_1.genPropChksRDInf.genAXI4Full.master_ar_araddr_fixed_arlen

#Slave0 assertion setup
assert -disable top.axi_slave_0.genPropChksRDInf.genNoRdTblOverflow.master_ar_rd_tbl_no_overflow
assert -disable top.axi_slave_0.genPropChksWRInf.genNoWrTblOverflow.master_aw_wr_tbl_no_overflow
assert -disable top.axi_slave_0.genPropChksWRInf.genNoWrDatTblOverflow.master_w_wr_tbl_no_overflow
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.master_aw_awprot_stable
assert -disable top.axi_slave_0.genPropChksRDInf.genAXI4Full.master_ar_arcache_no_ra_wa_for_uncacheable
assert -disable top.axi_slave_0.genPropChksWRInf.genAXI4Full.master_aw_awcache_no_ra_wa_non_modifiable
assert -disable top.axi_slave_0.genNoExChks.master_ar_arlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_0.genNoExChks.master_aw_awlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.master_ar_arprot_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arlock_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arcache_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arqos_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arregion_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_aruser_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awlock_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awcache_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awqos_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awregion_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awuser_stable
assert -disable top.axi_slave_0.genStableChks.genStableChksWRInf.genAXI4Full.master_w_wuser_stable
assert -disable top.axi_slave_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assert -disable top.axi_slave_0.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assert -disable top.axi_slave_0.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_aligned
assert -disable top.axi_slave_0.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_awlen
assume -disable top.axi_slave_0.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave

#Slave1 assertion setup
assert -disable top.axi_slave_1.genPropChksRDInf.genNoRdTblOverflow.master_ar_rd_tbl_no_overflow
assert -disable top.axi_slave_1.genPropChksWRInf.genNoWrTblOverflow.master_aw_wr_tbl_no_overflow
assert -disable top.axi_slave_1.genPropChksWRInf.genNoWrDatTblOverflow.master_w_wr_tbl_no_overflow
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.master_aw_awprot_stable
assert -disable top.axi_slave_1.genPropChksRDInf.genAXI4Full.master_ar_arcache_no_ra_wa_for_uncacheable
assert -disable top.axi_slave_1.genPropChksWRInf.genAXI4Full.master_aw_awcache_no_ra_wa_non_modifiable
assert -disable top.axi_slave_1.genNoExChks.master_ar_arlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_1.genNoExChks.master_aw_awlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.master_ar_arprot_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arlock_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arcache_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arqos_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arregion_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_aruser_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awlock_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awcache_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awqos_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awregion_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awuser_stable
assert -disable top.axi_slave_1.genStableChks.genStableChksWRInf.genAXI4Full.master_w_wuser_stable
assert -disable top.axi_slave_1.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assert -disable top.axi_slave_1.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assert -disable top.axi_slave_1.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_aligned
assert -disable top.axi_slave_1.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_awlen
assume -disable top.axi_slave_1.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave

#Slave2 assertion setup
assert -disable top.axi_slave_2.genPropChksRDInf.genNoRdTblOverflow.master_ar_rd_tbl_no_overflow
assert -disable top.axi_slave_2.genPropChksWRInf.genNoWrTblOverflow.master_aw_wr_tbl_no_overflow
assert -disable top.axi_slave_2.genPropChksWRInf.genNoWrDatTblOverflow.master_w_wr_tbl_no_overflow
assert -disable top.axi_slave_2.genStableChks.genStableChksWRInf.master_aw_awprot_stable
assert -disable top.axi_slave_2.genPropChksRDInf.genAXI4Full.master_ar_arcache_no_ra_wa_for_uncacheable
assert -disable top.axi_slave_2.genPropChksWRInf.genAXI4Full.master_aw_awcache_no_ra_wa_non_modifiable
assert -disable top.axi_slave_2.genNoExChks.master_ar_arlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_2.genNoExChks.master_aw_awlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_2.genStableChks.genStableChksRDInf.master_ar_arprot_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arlock_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arcache_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arqos_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arregion_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_aruser_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awlock_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awcache_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awqos_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awregion_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awuser_stable
assert -disable top.axi_slave_2.genStableChks.genStableChksWRInf.genAXI4Full.master_w_wuser_stable
assert -disable top.axi_slave_2.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assert -disable top.axi_slave_2.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assert -disable top.axi_slave_2.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_aligned
assert -disable top.axi_slave_2.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_awlen
assume -disable top.axi_slave_2.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave

#Slave3 assertion setup
assert -disable top.axi_slave_3.genPropChksRDInf.genNoRdTblOverflow.master_ar_rd_tbl_no_overflow
assert -disable top.axi_slave_3.genPropChksWRInf.genNoWrTblOverflow.master_aw_wr_tbl_no_overflow
assert -disable top.axi_slave_3.genPropChksWRInf.genNoWrDatTblOverflow.master_w_wr_tbl_no_overflow
assert -disable top.axi_slave_3.genStableChks.genStableChksWRInf.master_aw_awprot_stable
assert -disable top.axi_slave_3.genPropChksRDInf.genAXI4Full.master_ar_arcache_no_ra_wa_for_uncacheable
assert -disable top.axi_slave_3.genPropChksWRInf.genAXI4Full.master_aw_awcache_no_ra_wa_non_modifiable
assert -disable top.axi_slave_3.genNoExChks.master_ar_arlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_3.genNoExChks.master_aw_awlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_3.genStableChks.genStableChksRDInf.master_ar_arprot_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arlock_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arcache_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arqos_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arregion_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_aruser_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awlock_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awcache_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awqos_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awregion_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awuser_stable
assert -disable top.axi_slave_3.genStableChks.genStableChksWRInf.genAXI4Full.master_w_wuser_stable
assert -disable top.axi_slave_3.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assert -disable top.axi_slave_3.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assert -disable top.axi_slave_3.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_aligned
assert -disable top.axi_slave_3.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_awlen
assume -disable top.axi_slave_3.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave

#Slave4 assertion setup
assert -disable top.axi_slave_4.genPropChksRDInf.genNoRdTblOverflow.master_ar_rd_tbl_no_overflow
assert -disable top.axi_slave_4.genPropChksWRInf.genNoWrTblOverflow.master_aw_wr_tbl_no_overflow
assert -disable top.axi_slave_4.genPropChksWRInf.genNoWrDatTblOverflow.master_w_wr_tbl_no_overflow
assert -disable top.axi_slave_4.genStableChks.genStableChksWRInf.master_aw_awprot_stable
assert -disable top.axi_slave_4.genPropChksRDInf.genAXI4Full.master_ar_arcache_no_ra_wa_for_uncacheable
assert -disable top.axi_slave_4.genPropChksWRInf.genAXI4Full.master_aw_awcache_no_ra_wa_non_modifiable
assert -disable top.axi_slave_4.genNoExChks.master_ar_arlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_4.genNoExChks.master_aw_awlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_4.genStableChks.genStableChksRDInf.master_ar_arprot_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arlock_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arcache_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arqos_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arregion_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_aruser_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awlock_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awcache_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awqos_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awregion_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awuser_stable
assert -disable top.axi_slave_4.genStableChks.genStableChksWRInf.genAXI4Full.master_w_wuser_stable
assert -disable top.axi_slave_4.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assert -disable top.axi_slave_4.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assert -disable top.axi_slave_4.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_aligned
assert -disable top.axi_slave_4.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_awlen
assume -disable top.axi_slave_4.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave

#Slave5 assertion setup
assert -disable top.axi_slave_5.genPropChksRDInf.genNoRdTblOverflow.master_ar_rd_tbl_no_overflow
assert -disable top.axi_slave_5.genPropChksWRInf.genNoWrTblOverflow.master_aw_wr_tbl_no_overflow
assert -disable top.axi_slave_5.genPropChksWRInf.genNoWrDatTblOverflow.master_w_wr_tbl_no_overflow
assert -disable top.axi_slave_5.genStableChks.genStableChksWRInf.master_aw_awprot_stable
assert -disable top.axi_slave_5.genPropChksRDInf.genAXI4Full.master_ar_arcache_no_ra_wa_for_uncacheable
assert -disable top.axi_slave_5.genPropChksWRInf.genAXI4Full.master_aw_awcache_no_ra_wa_non_modifiable
assert -disable top.axi_slave_5.genNoExChks.master_ar_arlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_5.genNoExChks.master_aw_awlock_no_excl_access_throttle_cnstr
assert -disable top.axi_slave_5.genStableChks.genStableChksRDInf.master_ar_arprot_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arlock_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arcache_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arqos_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_arregion_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksRDInf.genAXI4Full.master_ar_aruser_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awlock_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awcache_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awqos_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awregion_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksWRInf.genAXI4Full.master_aw_awuser_stable
assert -disable top.axi_slave_5.genStableChks.genStableChksWRInf.genAXI4Full.master_w_wuser_stable
assert -disable top.axi_slave_5.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_aligned
assert -disable top.axi_slave_5.genPropChksRDInf.genAXI4Full.master_ar_araddr_wrap_arlen
assert -disable top.axi_slave_5.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_aligned
assert -disable top.axi_slave_5.genPropChksWRInf.genAXI4Full.master_aw_awaddr_wrap_awlen
assume -disable top.axi_slave_5.genPropChksRDInf.genAXI4Full.genRdIlOff.slave_r_ar_rid_no_interleave


#data integrity
assume {((axi_slave_0.rready == 0) && (axi_slave_0.rvalid == 1)) |=> $stable(axi_slave_0.rdata)}
assume {((axi_slave_1.rready == 0) && (axi_slave_1.rvalid == 1)) |=> $stable(axi_slave_1.rdata)}
assume {((axi_slave_2.rready == 0) && (axi_slave_2.rvalid == 1)) |=> $stable(axi_slave_2.rdata)}
assume {((axi_slave_3.rready == 0) && (axi_slave_3.rvalid == 1)) |=> $stable(axi_slave_3.rdata)}
assume {((axi_slave_4.rready == 0) && (axi_slave_4.rvalid == 1)) |=> $stable(axi_slave_4.rdata)}
assume {((axi_slave_5.rready == 0) && (axi_slave_5.rvalid == 1)) |=> $stable(axi_slave_5.rdata)}


prove -all
