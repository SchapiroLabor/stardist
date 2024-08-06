# Use the official micromamba image as a base
FROM continuumio/miniconda3:main
LABEL maintainer="Miguel A. Ibarra-Arellano"

# Set the base layer for micromamba
USER root
COPY environment.yml .

# Update package manager and install essential build tools
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    ffmpeg \
    libsm6 \
    libxext6 \
    procps

# Activate conda
RUN conda init

# Install dependencies with micromamba, clean afterwards
RUN conda env create -f environment.yml \
    && conda clean --all --yes

# Add environment to PATH
ENV PATH="/opt/conda/envs/stardist/bin:$PATH"

# Set the working directory
WORKDIR /stardist