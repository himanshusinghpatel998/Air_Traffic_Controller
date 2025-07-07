module AirTrafficControl(
    input radar,
    input wire weather, speed, range, altitude,  
    input wire [1:0] fuel,                      
    input wire emergency,                       
    input wire takeoff_signal,                  
    input wire [2:0] gate_number,               
    output reg [1:0] allocated_runway,          
    output reg [2:0] allocated_gate,            
    output reg timer_active,                    
    output reg [3:0] timer_value                
);

    // Runway availability and gate allocation status
    reg [2:0] next_gate_runway1 = 3'b001;  // Gates 1, 2, 3 for Runway 1
    reg [2:0] next_gate_runway2 = 3'b100;  // Gates 4, 5, 6 for Runway 2
    reg toggle_runway = 0;  // 0 for Runway 1, 1 for Runway 2 to alternate between runways
    
    always @(*) begin
        allocated_runway = 2'b00;  
        allocated_gate = 3'b000;   
        timer_active = 0;
        timer_value = 4'b0000;

        // Landing part
        if (emergency || (fuel == 2'b00)) begin
            // Emergency or fuel shortage, allocate runway 0 (emergency)
            allocated_runway = 2'b00;
            allocated_gate = 3'b000; 
        end
        else if (weather && speed && range && altitude && (fuel == 2'b10 || fuel == 2'b01)) begin
            // Optimum conditions, zigzag runway and gate allocation
            if (toggle_runway == 0) begin
                allocated_runway = 2'b01;  // Allocate Runway 1
                allocated_gate = next_gate_runway1;  // Assign the next gate on Runway 1
                next_gate_runway1 = next_gate_runway1 + 1;
                if (next_gate_runway1 > 3'b011) next_gate_runway1 = 3'b001;  // Reset gate to 1 after 3
                toggle_runway = 1;  // Switch to Runway 2 for the next allocation
            end
            else begin
                allocated_runway = 2'b10;  // Allocate Runway 2
                allocated_gate = next_gate_runway2;  // Assign the next gate on Runway 2
                next_gate_runway2 = next_gate_runway2 + 1;
                if (next_gate_runway2 > 3'b110) next_gate_runway2 = 3'b100;  // Reset gate to 4 after 6
                toggle_runway = 0;  // Switch back to Runway 1 for the next allocation
            end
        end
         if (!weather) begin
            // If weather is not good, start a 12-second timer before allocating
            timer_active = 1;
            timer_value = 4'b1100;
            allocated_runway = (!toggle_runway) ? 2'b01 : 2'b10; 
            allocated_gate = (!toggle_runway) ? next_gate_runway1 : next_gate_runway2;
        end

        // timer_active = ;
    end 
    always @* begin
         if (fuel == 2'b11) begin
            // Fuel is in excess, start a 15-second timer before allocating
            timer_active = 1;
            timer_value = 4'b1111;
            allocated_runway = (!toggle_runway) ? 2'b01 : 2'b10;  
            allocated_gate = (!toggle_runway) ? next_gate_runway1 : next_gate_runway2;
        end

        // Takeoff part
        if (takeoff_signal) begin
            if (weather==0) begin
                // Weather is not good, start 15 seconds countdown
                timer_active <= 1;
                timer_value <= 4'b1111; 
            end
            timer_active = 0;
            timer_value = 4'b0000;
            allocated_runway = (gate_number <= 3) ? 2'b01 : 2'b10;  // Assign runway based on gate number
        end

    end
endmodule
