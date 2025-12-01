# Usamos o Debian 12 (Bookworm) como base - estável e leve
FROM mcr.microsoft.com/devcontainers/base:debian-12

ENV DEBIAN_FRONTEND=noninteractive

# 1. Instalação de Pacotes
RUN apt-get update && apt-get install -y \
    # Ferramentas Básicas e OSTEP (C padrão + Python)
    build-essential \
    git \
    python3 \
    python3-pip \
    # Ferramentas para xv6 (RISC-V + QEMU + Debugger)
    gdb-multiarch \
    qemu-system-misc \
    gcc-riscv64-linux-gnu \
    binutils-riscv64-linux-gnu \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Correção de Compatibilidade (O "Pulo do Gato")
# O Makefile do xv6 espera nomes específicos de compiladores. 
# Aqui criamos links simbólicos para enganar o Makefile e usar os binários do Debian.
RUN ln -s /usr/bin/riscv64-linux-gnu-gcc /usr/bin/riscv64-unknown-elf-gcc && \
    ln -s /usr/bin/riscv64-linux-gnu-ld /usr/bin/riscv64-unknown-elf-ld && \
    ln -s /usr/bin/riscv64-linux-gnu-objdump /usr/bin/riscv64-unknown-elf-objdump && \
    ln -s /usr/bin/riscv64-linux-gnu-gdb /usr/bin/riscv64-unknown-elf-gdb