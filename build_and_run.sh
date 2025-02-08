#!/bin/bash

# Step 1: Compile Java files
javac -cp . /Volumes/a/digital-logic/FullAdderProject/java/src/core/*.java /Volumes/a/digital-logic/FullAdderProject/java/src/spice/*.java

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Java compilation failed. Exiting."
    exit 1
fi

echo "Java compilation succeeded."

# Step 2: Generate the SPICE netlist
java -cp /Volumes/a/digital-logic/FullAdderProject/java/src spice.NetlistExporter

if [ $? -ne 0 ]; then
    echo "Netlist generation failed. Exiting."
    exit 1
fi

echo "Netlist generated successfully."

# Step 3: Run LTSpice simulation and validate
bash /Users/ryanoates/Desktop/lab2schematixspice/spice_cli.sh

if [ $? -ne 0 ]; then
    echo "LTSpice simulation and validation failed. Exiting."
    exit 1
fi

echo "LTSpice simulation and validation completed successfully."