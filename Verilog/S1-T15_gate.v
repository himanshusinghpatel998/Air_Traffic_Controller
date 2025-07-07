module AirTrafficControl(
    input wire weather, speed, range, altitude,  
    input wire [1:0] fuel,                      
    input wire emergency,                       
    input wire takeoff_signal,                  
    input wire [2:0] gate_number,               
    output wire [1:0] allocated_runway,         
    output wire [2:0] allocated_gate,           
    output wire timer_active,                   
    output wire [3:0] timer_value               
);

    wire opt_conditions, fuel_ok, fuel_excess, fuel_shortage;
    wire runway1_available, runway2_available, use_runway1, use_runway2;
    wire [1:0] selected_runway;

    // Weather, speed, range, altitude should be optimum
    and (opt_conditions, weather, speed, range, altitude);

    // Check fuel status: 
    and (fuel_ok, ~fuel[1], fuel[0]);  
    and (fuel_excess, fuel[1], fuel[0]);  
    and (fuel_shortage, ~fuel[1], ~fuel[0]);  

    // Emergency case or fuel shortage --> allocate runway 0
    wire emergency_or_fuel_shortage;
    or (emergency_or_fuel_shortage, emergency, fuel_shortage);

    // Runway allocation logic
    wire runway1_free, runway2_free;  
    not (runway1_available, runway1_free);  
    not (runway2_available, runway2_free); 

    // Runway 1 allocation if all conditions are optimum and it's available
    and (use_runway1, opt_conditions, runway1_available, fuel_ok);

    // Runway 2 allocation if Runway 1 is occupied and it's available
    and (use_runway2, opt_conditions, runway2_available, fuel_ok);

        assign selected_runway = (use_runway1) ? 2'b01 : 
                             (use_runway2) ? 2'b10 : 
 2'b00;  

    // Output assigned runway
    assign allocated_runway = emergency_or_fuel_shortage ? 2'b00 : selected_runway;

    // Simple gate allocation: this is a simplified version
    wire [2:0] next_gate_runway1 = 3'b001;  // Fixed gate numbers for now
    wire [2:0] next_gate_runway2 = 3'b100;

    assign allocated_gate = (allocated_runway == 2'b01) ? next_gate_runway1 :
                            (allocated_runway == 2'b10) ? next_gate_runway2 : 3'b000;  // Default gate 0 for runway 0

    // Timer logic
    wire weather_bad, start_timer_fuel_excess;
    not (weather_bad, weather);
    and (start_timer_fuel_excess, fuel_excess, ~emergency);

    assign timer_active = weather_bad | start_timer_fuel_excess;
    assign timer_value = (weather_bad) ? 4'b1100 :  // 12 seconds
                        (start_timer_fuel_excess) ? 4'b1111 :  // 15 seconds
                        4'b0000;  // Default, no timer

endmodule



