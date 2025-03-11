`timescale 1ns / 1ps

module tb_matrix_mult;

    // Parameters
    parameter MAX_SIZE = 16; // Maximum supported matrix size

    // Inputs
    reg clk;
    reg rst;
    reg [31:0] A [0:MAX_SIZE-1][0:MAX_SIZE-1];
    reg [31:0] B [0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Outputs
    wire [31:0] C [0:MAX_SIZE-1][0:MAX_SIZE-1];

    // Matrix size (use fixed size instead of dynamic loop)
    integer N;
    
    // File handles
    integer input_file, output_file;

    // Instantiate the module under test
    matrix_mult #(MAX_SIZE) uut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .C(C)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test stimulus
    initial begin
        // Open the input file
        input_file = $fopen("input_matrix.txt", "r");
        if (input_file == 0) begin
            $display("Error: Could not open input file!");
            $finish;
        end

        // Read matrix size (N)
        $fscanf(input_file, "%d", N);

        if (N > MAX_SIZE) begin
            $display("Error: Matrix size exceeds MAX_SIZE!");
            $finish;
        end

        // Read matrix A (Loop with MAX_SIZE as fixed upper bound)
        for (integer i = 0; i < MAX_SIZE; i = i + 1) begin
            for (integer j = 0; j < MAX_SIZE; j = j + 1) begin
                if (i < N && j < N) // Only read valid values
                    $fscanf(input_file, "%d", A[i][j]);
                else
                    A[i][j] = 0; // Zero padding
            end
        end

        // Read matrix B
        for (integer i = 0; i < MAX_SIZE; i = i + 1) begin
            for (integer j = 0; j < MAX_SIZE; j = j + 1) begin
                if (i < N && j < N) // Only read valid values
                    $fscanf(input_file, "%d", B[i][j]);
                else
                    B[i][j] = 0; // Zero padding
            end
        end

        // Close the input file
        $fclose(input_file);

        // Initialize reset
        rst = 1;
        #20;
        rst = 0; // Release reset

        // Wait for the result
        #(10 * MAX_SIZE * MAX_SIZE);

        // Open the output file
        output_file = $fopen("result.txt", "w");
        if (output_file == 0) begin
            $display("Error: Could not open output file!");
            $finish;
        end

        // Write the result matrix C to the output file
        for (integer i = 0; i < MAX_SIZE; i = i + 1) begin
            for (integer j = 0; j < MAX_SIZE; j = j + 1) begin
                if (i < N && j < N) // Only write valid results
                    $fwrite(output_file, "%d ", C[i][j]);
            end
            if (i < N) // Only write a new line for valid rows
                $fwrite(output_file, "\n");
        end

        // Close the output file
        $fclose(output_file);

        // End simulation
        $finish;
    end

endmodule
