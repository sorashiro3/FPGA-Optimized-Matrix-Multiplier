# Matrix Multiplication in Verilog  

This project implements a **parameterized matrix multiplication module** in Verilog, allowing variable matrix sizes. It includes a testbench for simulation and saves the computed results to `result.txt`.  

## Files  

- **`matrix_mult.v`** – Matrix multiplication module.  
- **`tb_matrix_mult.v`** – Testbench for simulation.  
- **`input_matrix.txt`** – Input matrices A and B.  
- **`result.txt`** – Output matrix C.  

## Usage  

### Simulation  

1. **Compile and run** `tb_matrix_mult.v` using a Verilog simulator (e.g., ModelSim, Icarus Verilog).  
2. The testbench reads input matrices from `input_matrix.txt`.  
3. Computed results are saved in `result.txt`.  

### Synthesis  

- Use **Quartus Prime** or another synthesis tool to synthesize `matrix_mult.v` for FPGA implementation.  

## Dependencies  

- **Verilog simulator** (e.g., ModelSim, Icarus Verilog) – for simulation.  
- **Quartus Prime** – for FPGA synthesis.  

## License  

This project is licensed under the **MIT License** – free to use and modify. 
