module dual_edge_detector (input clk , reset , in , output reg out);

localparam idle = 2'b00,
           state_0 = 2'b01,
           state_1 = 2'b10,
           state_3 = 2'b11;

reg [1:0] next_state , state;


// state register ----------------------
always@(posedge clk or negedge reset) begin
if(~reset)
     state <= 0;
else
     state <= next_state;

end
//-------------------------------------

always@(*) begin
next_state = idle; // default
case (state)

idle : begin
            out = 1'b0;  // moore output
           if (in)
                 next_state = state_0;
                 // out = 1'b0;  mealy output
           else
                   next_state = idle;
                   // out = 1'b0;  mealy output
         end
state_0 : begin
          out = 1'b0;  // moore output
           if (~in)
                 next_state = state_1;
                   // next_state = idle;
                 // out = 1'b1;  mealy output
           else
                   next_state = state_0;
                   // out = 1'b0;  mealy output
         end

state_1 : begin
                 out = 1'b1;  // moore output
                 next_state =idle;
          end
           
endcase

end

endmodule
