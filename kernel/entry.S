# kalorona-posix
# entry.S
# To create a stack for C-compiled program and handover control to C world.
# Reference:
#   - xv6-riscv/kernel/entry.S

# Binary format;
.section text
.global entry
__entry:
    # Create the stack for C world;
    # There will be MAX_CPU stacks;
    # Load data to the right stack;

    # Set the stack pointer;
    la sp, init_stack
    li a0, 4096
    # Read the hartid to a1, indicating the current hardware id the program running on;
    csrr a1, mhartid
    # In C, stack pointer decreases gradually with the more data loaded into the stack;
    addi a1, a1, 1
    mul a0, a1, a0
    add sp, sp, a0
    # Go!
    call kernel_entrypoint
# Doing nothing;
spin:
    j spin