root_dir := $(PWD)
src_dir := ./src
inc_dir := ./include
vip_dir := $(PWD)/vip
bld_dir := ./build

export vip_dir

$(bld_dir):
	mkdir -p $(bld_dir)

# AXI simulation
vip_b: clean | $(bld_dir)
	cd $(bld_dir); \
	jg ../script/jg_bridge.tcl

superlint: | $(bld_dir)
	cd $(bld_dir); \
	jg -superlint ../script/superlint.tcl &

dv: | $(bld_dir) $(syn_dir)
	cp script/synopsys_dc.setup $(bld_dir)/.synopsys_dc.setup; \
	cd $(bld_dir); \
	dc_shell -gui -no_home_init

synthesize: | $(bld_dir) $(syn_dir)
	cp script/synopsys_dc.setup $(bld_dir)/.synopsys_dc.setup; \
	cd $(bld_dir); \
	dc_shell -no_home_init -f ../script/synthesis.tcl

spyglass: | $(bld_dir)
	cd $(bld_dir); \
	spyglass -tcl  ../script/Spyglass_CDC.tcl &

.PHONY: clean

clean:
	rm -rf $(bld_dir);