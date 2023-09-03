# The default stagger value is corne, which corresponds to 2.375,
# but you can change it by running `make all STAGGER=5.5`
STAGGER ?= corne

# The default keycap spacing profile is `choc`, but you can change
# to `mx` or `custom`.
#
# Keep in mind that all keycaps in the repo are choc keycaps. This
# only adjusts the distance at which they are placed to get the most
# optimal trackpoint cut.
PROFILE ?= choc

# If you use PROFILE=custom, you can adjust the value below to change
# the spacing of the keys to a non-standard value.
SPREADX ?= 20
SPREADY ?= 20

# Set to true to draw the trackpoint cylinder used for cutting out the hole
DEBUG ?= false

# These options require OpenScad snapshot
OPENSCAD="/Applications/OpenSCAD Snapshot.app/Contents/MacOS/OpenSCAD" --enable=manifold

# This will work with the stable openscad, but will be a bit slow
#OPENSCAD="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

# Don't change anything below here unless you know what you are doing.
OPENSCAD_OPTIONS=--export-format binstl
OPENSCAD_CMD=$(OPENSCAD) $(OPENSCAD_OPTIONS)

# Directories
SRC_DIR := src
STL_DIR := stl

# Source files
SRCS := $(wildcard $(SRC_DIR)/gen_*.scad)

# Base names without prefix and suffix
BASE_NAMES := $(patsubst $(SRC_DIR)/gen_%.scad,%,$(SRCS))

# Outputs to generate
OUTPUTS := preview sprued top_left top_right bottom_left bottom_right

# Variables for the each target output
TARGETS_GEN_ALL := $(foreach base,$(BASE_NAMES),$(foreach output,$(OUTPUTS),$(STL_DIR)/$(base)/$(base)_$(PROFILE)_$(STAGGER)_$(output).stl))

TARGETS_GEN_PREVIEWS := $(foreach base,$(BASE_NAMES),$(STL_DIR)/$(base)/$(base)_$(PROFILE)_$(STAGGER)_preview.stl)

TARGETS_GEN_SPRUED := $(foreach base,$(BASE_NAMES),$(STL_DIR)/$(base)/$(base)_$(PROFILE)_$(STAGGER)_sprued.stl)

# Default rule
all: $(TARGETS_GEN) combined

# Convert stagger to integer or string parameter
STAGGER_VAL=$(shell if echo $(STAGGER) | grep -qE '^[-+]?[0-9]*\.?[0-9]+$$'; then echo $(STAGGER); else echo \\\\\"$(STAGGER)\\\\\"; fi)

SETTINGS_VAL=-D key_stagger=$(STAGGER_VAL) -D key_profile=\"$(PROFILE)\" -D key_spread_x=$(SPREADX) -D key_spread_y=$(SPREADY) -D debug=$(DEBUG)

# Rule to generate the target names
define GEN_TARGETS
$(STL_DIR)/$(1)/$(1)_$(PROFILE)_$(STAGGER)_preview.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"preview\" $(SETTINGS_VAL) -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(PROFILE)_$(STAGGER)_sprued.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"sprued\" $(SETTINGS_VAL) -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(PROFILE)_$(STAGGER)_top_left.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"top_left\" $(SETTINGS_VAL) -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(PROFILE)_$(STAGGER)_top_right.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"top_right\" $(SETTINGS_VAL) -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(PROFILE)_$(STAGGER)_bottom_left.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"bottom_left\" $(SETTINGS_VAL) -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(PROFILE)_$(STAGGER)_bottom_right.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"bottom_right\" $(SETTINGS_VAL) -o $$@ $$<

# Top level targets, such as `cs_r2_r3_homing_bar`
$(1): $(foreach output,$(OUTPUTS),$(STL_DIR)/$(base)/$(base)_$(PROFILE)_$(STAGGER)_$(output).stl)

endef

# Generate targets for all source files
$(foreach base,$(BASE_NAMES),$(eval $(call GEN_TARGETS,$(base))))

previews: $(TARGETS_GEN_PREVIEWS)

sprued: $(TARGETS_GEN_SPRUED)

combined: $(foreach base,$(filter cs_% mbk,$(BASE_NAMES)), $(foreach output,$(OUTPUTS),$(STL_DIR)/$(base)/$(base)_$(PROFILE)_$(STAGGER)_$(output).stl))
	mkdir -p $(STL_DIR)/combined
	$(OPENSCAD) $(SETTINGS_VAL) -o $(STL_DIR)/combined/combined_set_$(PROFILE)_$(STAGGER)_1.stl src/combine_set_1.scad
	$(OPENSCAD) $(SETTINGS_VAL) -o $(STL_DIR)/combined/combined_set_$(PROFILE)_$(STAGGER)_2.stl src/combine_set_2.scad

# Clean target
clean:
	rm -f $(TARGETS_GEN_ALL)

# Help target
help:
	@echo "Individual targets:\n"
	@$(foreach base,$(sort $(BASE_NAMES)), \
		echo "  $(base):"; \
		$(foreach target,$(TARGETS_GEN_ALL), \
			echo "    $(target)"; \
		) \
		echo; \
	)
	@echo "all:"
	@echo "  Generate everything."
	@echo
	@echo "combined:"
	@echo "  Generate optimized stls that contain all unique variations."
	@echo
	@echo "sprued:"
	@echo "  Generate only sprued stls."
	@echo
	@echo "preview:"
	@echo "  Generate only preview stls."
	@echo