# Dockerfile for FullAdder Simulation System

# Step 1: Use a base image with Java pre-installed
FROM openjdk:17-slim

# Step 2: Install dependencies
RUN apt-get update && \
    apt-get install -y curl wget unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Step 3: Install LTSpice CLI (Linux version or Wine-emulated Windows version)
# Assuming using Wine to run LTSpice Windows binary (adjust as per your OS setup)
RUN apt-get update && apt-get install -y wine winetricks && rm -rf /var/lib/apt/lists/*
RUN wget -O /tmp/ltspice.exe "https://ltspice.url/installer/path" && \
    wine /tmp/ltspice.exe /S /D=C:\\LTspice && rm /tmp/ltspice.exe

# Step 4: Create working directory for the project
WORKDIR /usr/src/app

# Step 5: Copy the Java project files into the container
COPY /Volumes/a/digital-logic/FullAdderProject/java /usr/src/app

# Step 6: Create directories for LTSpice netlist exports
RUN mkdir -p /usr/src/app/netlist_exports

# Step 7: Set environment variables
ENV SPICE_EXECUTABLE="wine C:\\LTspice\\XVIIx64.exe"
ENV NETLIST_OUTPUT="/usr/src/app/netlist_exports"

# Step 8: Add build-and-run script
COPY /Users/ryanoates/Desktop/lab2schematixspice/build_and_run.sh /usr/src/app/build_and_run.sh
RUN chmod +x build_and_run.sh

# Step 9: Set the script as the entry point
ENTRYPOINT ["/bin/bash", "./build_and_run.sh"]