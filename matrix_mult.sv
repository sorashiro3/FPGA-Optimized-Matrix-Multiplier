module matrix_mult #(parameter N = 2) (
    input  wire clk,
    input  wire rst,
    input  wire [31:0] A [0:N-1][0:N-1], // N x N matrix A
    input  wire [31:0] B [0:N-1][0:N-1], // N x N matrix B
    output reg  [31:0] C [0:N-1][0:N-1]  // N x N result matrix C
);

    reg [31:0] A_reg [0:N-1][0:N-1];
    reg [31:0] B_reg [0:N-1][0:N-1];
    reg [31:0] C_temp [0:N-1][0:N-1];

    integer i, j, k;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all registers
            for (i = 0; i < N; i = i + 1) begin
                for (j = 0; j < N; j = j + 1) begin
                    A_reg[i][j] <= 0;
                    B_reg[i][j] <= 0;
                    C_temp[i][j] <= 0;
                    C[i][j] <= 0;
                end
            end
        end else begin
            // Stage 1: Register inputs
            for (i = 0; i < N; i = i + 1) begin
                for (j = 0; j < N; j = j + 1) begin
                    A_reg[i][j] <= A[i][j];
                    B_reg[i][j] <= B[i][j];
                end
            end

            // Stage 2: Perform multiplication and accumulation
            for (i = 0; i < N; i = i + 1) begin
                for (j = 0; j < N; j = j + 1) begin
                    C_temp[i][j] <= 0; // Initialize accumulator
                    for (k = 0; k < N; k = k + 1) begin
                        C_temp[i][j] <= C_temp[i][j] + A_reg[i][k] * B_reg[k][j];
                    end
                end
            end

            // Stage 3: Register output
            for (i = 0; i < N; i = i + 1) begin
                for (j = 0; j < N; j = j + 1) begin
                    C[i][j] <= C_temp[i][j];
                end
            end
        end
    end

endmodule