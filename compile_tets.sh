#/bin/bash

# Compile all the test cases using TCC 
for testcase in c-testsuite/tests/single-exec/*.c; do
    ./tcc -c "$testcase" -o "${testcase%%.*}"".o" -Os  
done

# Scan compiled files for not valid rv32 instructions
for ctestcase in c-testsuite/tests/single-exec/*.o; do
    riscv64-linux-gnu-objdump -dr $ctestcase | awk '{if ($3 ~/0x/) print $3}' | sort -u
done
