#!/bin/bash
# CLI utility for SPICE simulation and verification

SPICE_EXECUTABLE="ltspice"  # Specify the LTSpice executable name or path
NETLIST_PATH="/Users/ryanoates/Desktop/lab2schematixspice/netlist_exports/full_adder_netlist.sp"
OUTPUT_PATH="/Users/ryanoates/Desktop/lab2schematixspice/netlist_exports/simulation_output.sp"

# Run SPICE simulation
"$SPICE_EXECUTABLE" -b "$NETLIST_PATH" -o "$OUTPUT_PATH"

if [ $? -eq 0 ]; then
    echo "SPICE simulation completed successfully. Output saved to $OUTPUT_PATH."
else
    echo "SPICE simulation failed! Please check the netlist and SPICE executable."
    exit 1
fi

# Java validation (ensure proper Java runtime is installed and configured)
java -cp "/Volumes/a/digital-logic/FullAdderProject/java" spice.SpiceValidation