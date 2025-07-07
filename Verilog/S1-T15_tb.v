module AirTrafficControl_tb;

    // Inputs
    reg radar;
    reg weather;
    reg speed;
    reg range;
    reg altitude;
    reg [1:0] fuel;
    reg emergency;
    reg takeoff_signal;
    reg [2:0] gate_number;

    // Outputs
    wire [1:0] allocated_runway;
    wire [2:0] allocated_gate;
    wire timer_active;
    wire [3:0] timer_value;

    AirTrafficControl uut (
        .weather(weather), 
        .speed(speed), 
        .range(range), 
        .altitude(altitude), 
        .fuel(fuel), 
        .emergency(emergency), 
        .takeoff_signal(takeoff_signal), 
        .gate_number(gate_number), 
        .allocated_runway(allocated_runway), 
        .allocated_gate(allocated_gate), 
        .timer_active(timer_active), 
        .timer_value(timer_value)
    );

    initial begin
        // Initialize Inputs
        #10
        radar = 0;
        weather = 1;
        speed = 1;
        range = 1;
        altitude = 1;
        fuel = 2'b00;
        emergency = 0;
        takeoff_signal = 0;
        gate_number = 3'b000;
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);


        // Emergency scenario - Runway 0 should be allocated
        #10;
        radar= 1;
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);
        emergency = 1;
        #10 fuel = 2'b01;
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);

        //  Fuel shortage (emergency scenario) - Runway 0 should be allocated
        #10  emergency = 0;


        // Weather not good - Start 12-second timer, then allocate available runway
        #10 weather = 0;
        #10 weather = 1;
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, 1'b0, speed, range, altitude, fuel, timer_active, timer_value, 2'b01, 3'b001);
        #10 weather = 1;
        #10
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);
        #10 weather = 0;
        #10 weather = 1;
        // #10 weather = 0;
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, 1'b0, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);
        #10 weather = 0;
        #10 weather = 1;
        #10
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);
        #10 weather = 0;
        #10 weather = 1;
        #10
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);


        //  Fuel excess - Start 15-second timer, then allocate available runway
        #10 fuel = 2'b10; 
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);
        #10 fuel = 2'b11; 
        $display("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);

        // Takeoff Part//
        // Weather not good for takeoff, timer countdown
        #10 takeoff_signal = 1; gate_number = 3'b001; weather = 0;

        $monitor("Time: %4t | Weather: %b | Takeoff Signal: %b | Gate: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b ", 
            $time, weather, takeoff_signal, gate_number, timer_active, timer_value, allocated_runway);

        #10 weather = 1; 

        // Test 8: Takeoff with gate 4, Runway 2 should be allocated
        #10 gate_number = 3'b100; 
        #10 gate_number = 3'b110;

        #10 $finish;
    end

endmodule