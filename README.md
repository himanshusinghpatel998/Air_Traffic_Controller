# Real Time Air Traffic Control System

## Team Details
<details>
  <summary>Detail</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S1

  > Member-1: Himanshu Singh Patel, 231CS127, himanshusinghpatel.231cs127@nitk.edu.in

  > Member-2: Nishant Kumar, 231CS140, nishantkumar.231cs140@nitk.edu.in

  > Member-3: R Adithya, 231CS146, r.231cs146@nitk.edu.in
</details>


## Abstract
<details>
  <summary>Detail</summary>
  
### Problem Statement and Solution:
  
 This project focuses on developing a Real-Time Air Traffic Control system utilizing digital logic gates to automate key tasks performed by airport control towers. Air traffic control (ATC) is critical for ensuring the safe and efficient operation of airports, where numerous tasks like managing landings, take-offs, and emergencies are traditionally handled by humans. However, human intervention is prone to errors. To address this, we present a fully automated Real-Time Air Traffic Control system, which performs all essential tasks such as runway clearance, weather sensing, terminal and gate chooser and emergency management without manual input. It replaces manual operations with a fully automated process. 
  
### Motivation:
 The motivation for this project arises from the need to reduce human intervention in ATC processes and minimize the possibility of human error, particularly in critical situations like emergency landings and many more. By leveraging digital circuits, the system ensures faster, more accurate decision-making in real-time, thereby enhancing both safety and operational efficiency. In an environment where even minor delays or mistakes can have serious consequences, automating such processes can significantly improve airport management, especially when multiple variables like weather conditions, runway availability, and aircraft fuel status must be considered simultaneously.

### Features:
  Our automated ATC system processes data from aircraft sensors (range, speed, altitude, fuel level) and weather sensors. It features RADAR for monitoring incoming planes
 and an automatic emergency management system that prioritizes landings for aircraft with
 low fuel or damage, dispatching ground vehicles when needed. The system prevents landings
 if fuel levels are too high till it reaches a safe threshold, handles emergencies, and prioritizes
 aircraft based on fuel status, improving safety and reliability through full automation.
</details>

## Functional Block Diagram
<details>
  <summary>Detail</summary><br>
  <details>
  <summary>Detailed Diagram:</summary><br>

![S1-T15-ATC drawio1](https://github.com/user-attachments/assets/2180479f-c7b7-4f76-8cf6-069899c3aba1)  
</details>
  
  

Simplified Diagram:

![S1-T15 simplifiedATC drawio](https://github.com/user-attachments/assets/239b9ec2-c1e0-4eae-b124-1f402589f111)

</details>


## Working
<details>
  <summary>Detail</summary>

  ![Basic Structure](https://github.com/user-attachments/assets/48b6d6b2-4258-4859-89f3-08b8b56e760d)

<br>

   Figure.1 shown above ids the basic structure of the model. There are 3 Runways 0,1 and 2, and 5
 gates 0,1,2,3 and 4. Gate 0 and runway 0 is meant only for emergency situations and the other 2
 runways and 4 gates are used for regular working.<br>
 1. Basic Inputs and MVC (Fig.3 and Fig.4)<br> This module is used to take in all of the basic
 inputs from plane like speed, range and altitude. An MVC is also attached to reduce the errors
 in the data received. The output given is basically the input that is maximum in number.<br>
 2. Radar Detection: (Fig.5) <br>This module is used to detect all the planes that are arriving
 towards the airport.<br>
 3. Timer 15 sec: (Fig.6)<br> This module is used to start a the timer. Its implemented using T
 f
 lipflops (Counter Construction). It send a signal as soon as it becomes Zero.<br>
 4. Binary to BCD, BCD to Display: (Fig.8 and Fig.9)<br> This module is used to convert Binary
 Number into BCD so that it can be used to display in the 7 segment display.<br>
 5. Pulse Generator: (Fig.10) <br>This module is used to generate a single pulse from a stagnant
 input. This is done is using a D flip flop which creates delay by atleast 1 clock pulse. This is
 used to reset all the timers used once the plane is done landing or taking off. This is connected
 to radar, so when next plane comes, all the timers are reset.<br>
 6. Custom Comparator: (Fig.10) <br>This module is used in take off section to compare the gate
 input with 3 and then the runway is assigned based which gate is chosen. If gate 1,2 is chosen,
 runway 1 is allocated, else runway 2.<br>

 ###  Initial Inputs (Start)
 
  The process begins with the system receiving inputs from two different sources, depending on whether the aircraft is landing or taking off.
Landing:      The system gets inputs from a radar that detects an aircraft approaching for landing.
Takeoff:       The plane sends a signal indicating it’s ready to take off. This includes the gate number. 
Simultaneously, weather conditions are monitored to ensure it is safe for either landing or takeoff.

 ### Landing Process
  Flight Detection using Radar
  Once a flight is detected, the system receives data from multiple sensors aboard the plane, such as  speed, range, height, fuel level, and emergency status.
   Weather data is also gathered from the ATC.
  
  Fuel Status and Emergency Handling <br>
  Low fuel:
   The system also checks the plane’s fuel level and whether there is any emergency situation.
It automatically considers the situation to be an emergency when fuel is low and when fuel is in excess, its let to be in air until it reaches optimum level. 
Emergency Handling 
The AND, OR  gate is used to detect emergencies by verifying two conditions:
	
  
  If both conditions are met, the AND gate outputs true, signaling an emergency.
  In such cases, the system immediately allocates a dedicated emergency runway and dispatches ground support vehicles such as ambulances and fire trucks to assist the aircraft.
  If no emergency is detected, the system proceeds with checking weather conditions and runway vacancy.
  Weather Checking and Runway Vacancy
   Once the plane’s status is confirmed (no emergency), the system checks the weather conditions  and whether the runway is available for landing.
   Weather Check Using OR Gate
  The OR gate is used to evaluate weather conditions.
 If any part of the weather input is favorable (such as visibility, wind speed, etc.), the system allows the operation to proceed.
For example, if visibility is good and wind speed is within limits, the OR gate outputs true, and the system moves to check runway availability.
However, if all weather conditions are unfavorable, the system waits until the weather improves. We use 12 second timer for that.
Runway Vacancy Using D FlipFlop:<br>
   Once weather conditions are favorable, the system checks runway availability. An AND gate verifies two conditions:<br>
  	Weather is favorable.<br>
	Runway is vacant.<br>
  If both conditions are true, respective runway is assigned and the plane is cleared for landing.
  Runway Allocation <br>

The D FlipFlop is the core of this system, to handle the runway assignment. The status of both the
 runways is given using D FlipFlop.<br>
 • D FF Values:<br>
 o 0: Represents that Runway is available and should be assigned.<br>
 o 1: Represents that Runway is occupied.<br>
 If the runway is occupied, the system waits until it becomes vacant, or it engages a 9-second timer
 to avoid long delays. Once the timer stops, the counter is reset to 0 and the same process is repeated
 (in this case runway 1 is allocated). If weather is not good and fuel is excess then there is a timer
 of 9 second. Second Timer If the runway remains occupied, the system initiates a 15-second timer.
 The NOT gate initially holds the allocation, but after 15 seconds, the signal flips, allowing the
 system to proceed even if the runway is still technically occupied. The AND gate checks that both
 the weather remains favorable and the 15-second timer has expired. Once both conditions are met,
 the system allocates the runway for landing. <br>
  Gate Allocation<br>
  The system checks the corresponding gates using the D flip-flops. Each D flip-flop stores either a 0 (indicating the gate is free) or a 1 (indicating the gate is occupied). 
  The system sequentially checks each flip-flop to determine if a gate is available:
	If a gate's flip-flop stores 0, that gate is immediately assigned to the aircraft, and the flip-flop is updated to store 1, marking the gate as occupied.
	If the flip-flop stores 1, the system continues to check the next gate in the sequence.
  In cases where all gates for the selected runway are occupied (i.e., all flip-flops store 1), a timer is triggered. 
  After a specified period, the timer automatically makes one gate vacant by resetting its flip-flop to 0, indicating the gate is free for assignment.
  The system then assigns the newly vacated gate to the aircraft and updates the flip-flop accordingly.
  This method ensures efficient gate utilization while maintaining real-time tracking of gate statuses through the D flip-flops. 
  The memory of the system is dynamically updated based on the status of the gates, ensuring that the system operates smoothly even during peak traffic periods.

### Takeoff
   Takeoff Clearance<br>
   Once the system confirms the runway is clear and weather conditions are favorable, the plane is cleared for takeoff.
   If the runway is occupied for more than 15 seconds, the system forces the allocation to avoid excessive delays.
   Once the plane takes off, it exits the system.<br>
   	Weather Input:<br>
   	This input ensures that the system only allows takeoffs when weather conditions are clear.
   It works in conjunction with logic gates (AND/OR) to either allow or block the process based on the weather.
   	Gate Inputs:<br>
   	Planes waiting for takeoff are represented by gate inputs. Gates 1, 2, and 3 correspond to Runway 1, while Gates 4, 5, and 6 correspond to Runway
    The system prioritizes runway assignment based on the plane’s gate: Runway 1 for gates 1–3, and Runway 2 for gates 4–6.<br>
   	Runway Assigner:<br>
     This module checks the availability of the preferred runway based on gate input.<br>
    If the preferred runway is busy, the system assigns the other runway.<br>
    If both runways are occupied, it triggers a 15-second timer before rechecking availability.<br>
  	Timers:<br>
   	A 9-second timer is used once a runway is assigned to check if the weather remains clear. After the timer finishes, the plane can proceed if conditions are favorable.
    A 9-second timer is triggered if both runways are busy, pausing the system before rechecking runway availability.
      Logic Gates and Runway Status:<br>
  	Logic gates like AND and OR manage the flow of signals, ensuring that takeoffs are only allowed when both the runway is free and the weather is clear. The system also tracks the status of runways (busy or free) using these gates.<br>

  In essence, this circuit automates runway assignments, using logic gates and timers to manage conflicts, weather conditions, and runway availability effectively.
  In summary, the ATC system uses logic gates and a timer to manage inputs and conditions effectively.
  The gates ensure that all necessary factors, such as weather, runway availability, and emergency status, are checked and validated before an aircraft is cleared for takeoff or landing.
  The 9-second and 9 second timer helps prevent unnecessary delays, making the system efficient and responsive.<br>

### Truth Table:

![TT](https://github.com/user-attachments/assets/3b6ef3e3-0c5e-4a55-b729-e4dd0cb8dd51)


  
</details>

## Logisim
<details>
  <summary>Detail</summary><br>  

  ### Main Circuit:
  
  ![MainCircuit](https://github.com/user-attachments/assets/6a7df0f9-e028-40a0-a0a0-25b8abc2bfc7)
  


### Radar Input:
![Radar Input](https://github.com/user-attachments/assets/709f26f1-416b-45c6-bcb4-939615090a14)

### Basic Plane Inputs:
![Plane Input](https://github.com/user-attachments/assets/3a55c208-2f63-4706-8e0d-e993521ab382)

### Fuel Inputs:

![Fuel Input](https://github.com/user-attachments/assets/3c720905-95ff-4e64-994d-0d95049fc5f9)


### Majority Circuit Voting:
![Majority Voting Circuit](https://github.com/user-attachments/assets/e4d686e0-f012-4a0b-8244-25b1461a1dd8)

### Custom Comparator:

![Custom Comparator](https://github.com/user-attachments/assets/eb9de4a0-8bc3-408c-84be-1858dce84a3b)

### Counter:
![Counter](https://github.com/user-attachments/assets/c3eabb94-da63-4d7a-bc51-0e5707d3fff5)

### Timer 12 sec:
![Timer 12](https://github.com/user-attachments/assets/57dcde00-4f99-4b2c-86eb-2bf0607d6338)


### Timer 15 sec:
![Timer 15](https://github.com/user-attachments/assets/1ea9113c-757e-4d9d-b14a-b3894b9dbe03)


### Binary To BCD:
![Binary To BCD](https://github.com/user-attachments/assets/abc5d38f-f67d-4bd9-b50e-35fc7ca7c5aa)


### BCD To Display:

![BCD To Display](https://github.com/user-attachments/assets/fbbb09b2-a8b4-4dc1-82ed-de3cd5bfc10e)


### Pulse Generator:
![Pulse Generator](https://github.com/user-attachments/assets/3b0129f5-300e-4ab4-a7ed-d888ef0085d5)



### Binary To Display:
![Binary to Display](https://github.com/user-attachments/assets/7d24819a-bc04-4543-9dd1-629c69cbfe91)


### Gate Chooser Display:

![Gate chooser display](https://github.com/user-attachments/assets/19071ceb-c179-41f6-86fc-30b61c057a52)

### Gate Number Display:

![Gate Display](https://github.com/user-attachments/assets/03a25d7a-93fe-4711-ac9f-7adb534b430a)


</details>

## Verilog Code
<details>
  <summary>Detail</summary>
  
  ### Gatelevel

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

  ### Behavioural 
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
    reg runway1_occupied = 0;  
    reg runway2_occupied = 0;  
    reg [2:0] next_gate_runway1 = 3'b001;  
    reg [2:0] next_gate_runway2 = 3'b100;
    
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
            // All conditions are optimum, allocate runway 1 first
            if (!runway1_occupied) begin
                allocated_runway = 2'b01;  
                allocated_gate = next_gate_runway1;
            end
            else if (!runway2_occupied) begin
                allocated_runway = 2'b10;  
                allocated_gate = next_gate_runway2;
            end
        end
        else if (!weather) begin
            // If weather is not good, start a 12-second timer before allocating
            timer_active = 1;
            timer_value = 4'b1100;
            allocated_runway = (!runway1_occupied) ? 2'b01 : 2'b10; 
            allocated_gate = (!runway1_occupied) ? next_gate_runway1 : next_gate_runway2;
        end
        else if (fuel == 2'b11) begin
            // Fuel is in excess, start a 15-second timer before allocating
            timer_active = 1;
            timer_value = 4'b1111;
            allocated_runway = (!runway1_occupied) ? 2'b01 : 2'b10;  
            allocated_gate = (!runway1_occupied) ? next_gate_runway1 : next_gate_runway2;
        end

        if (allocated_runway == 2'b01) begin
            next_gate_runway1 = next_gate_runway1 + 1;
            if (next_gate_runway1 > 3'b011) next_gate_runway1 = 3'b001;  // Reset gate to 1 after 3
            runway1_occupied = 1;
        end
        else if (allocated_runway == 2'b10) begin
            next_gate_runway2 = next_gate_runway2 + 1;
            if (next_gate_runway2 > 3'b110) next_gate_runway2 = 3'b100; 
            runway2_occupied = 1;
        end

        // Takeoff part
        if (takeoff_signal) begin
            if (!weather) begin
                // Weather is not good, start 15 seconds countdown
                timer_active = 1;
                timer_value = 4'b1111; 
            end
            allocated_runway = (gate_number <= 3) ? 2'b01 : 2'b10;  
        end
    end
    endmodule


### Testbench

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
        $monitor("Time: %4t | Emergency: %b | Weather: %b | Speed: %b | Range: %b | Altitude: %b | Fuel: %b | Timer Active: %b | Timer Value: %d| Allocated Runway: %b | Allocated Gate: %b ", 
            $time, emergency, weather, speed, range, altitude, fuel, timer_active, timer_value, allocated_runway, allocated_gate);

        // Initialize Inputs
        radar = 0;
        weather = 1;
        speed = 1;
        range = 1;
        altitude = 1;
        fuel = 2'b00;
        emergency = 0;
        takeoff_signal = 0;
        gate_number = 3'b000;

        // Emergency scenario - Runway 0 should be allocated
        #10;
        radar= 1;
        emergency = 1;
        #10 fuel = 2'b01;

        //  Fuel shortage (emergency scenario) - Runway 0 should be allocated
        #10  emergency = 0;

        //Everything normal
        #10  fuel = 2'b01;  

        // Weather not good - Start 12-second timer, then allocate available runway
        #10 weather = 1;
        #10 weather = 0; 

        //  Fuel excess - Start 15-second timer, then allocate available runway
        #10 fuel = 2'b11; 
        #10 fuel = 2'b10; 

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
   
</details>

## Hardware Implementation
<details>
  <summary>Details</summary>

<br>Above shown fig (Figure. 14) is the scaled down and optimised version of the ATC using Logisim.
 The input module remains the same except that the MVC is removed. The timer for weather in
 the take off part in the original detailed implementation is combined with the timer in landing part.
 So whenever weather is not feasible for any operation, the timer is turned on and after it stops
 we assume that the weather is good and the signal is given. This is done just to reduce number
 of inputs in the working (All the tasks were meant to be automated). A minor change is also in
 the gate assigner and runway assigner circuit which does the job as mentioned in the abstract and
working part (Refer Fig.15 and Fig.16). Runway assigner is enabled once all the values are optimum
 and once the runway is assigned, the gate is allocated and the landing procedure terminates. In case
 of emergency, its directly directed to Runway 0 and Gate 0, irrespective of what the inputs are, once
 the plane is detected.<br>
 Take off procedure is pretty simple, where the gate input is compared with 3 using custom
 comparator (Refer Fig.21). If it is less than 4, then Runway 1 is allocated. If its more than 3,
 Runway 2 is allocated.<br>



### Images:
<details>
  <summary>Main Circuit</summary><br>
	
  ![Main RTATC](https://github.com/user-attachments/assets/da636c6d-9580-450d-b54a-6d9fde53700d)
	
</details>

<details>
  <summary>Runway Checker</summary><br>

 ![Runway Checker](https://github.com/user-attachments/assets/c78028c6-8b22-4dc5-9dac-aebd5aa4f40b)

	
</details>

<details>
  <summary>Gate Checker</summary><br>
	
![Gate Checker](https://github.com/user-attachments/assets/297c6aef-4376-4930-9908-d2eb1da79025)

</details>

<details>
  <summary>Gate Status to BCD and Runway Status to BCD</summary><br>

  ![Gate Status To Binary](https://github.com/user-attachments/assets/b3f71a13-ee2e-4334-8c5d-bc17fa20903b)

![Runway to Display](https://github.com/user-attachments/assets/f5927ea7-bc1b-4083-852e-6b0baea2be1a)


</details>

<details>
  <summary>Pulse Generator</summary><br>
	
![Pulse Gen](https://github.com/user-attachments/assets/e63ee5b6-0d9a-4467-b768-480ab2adce51)



</details>

<details>
  <summary>Timer 9 sec</summary><br>

![Timer 9 sec](https://github.com/user-attachments/assets/3424d826-cc08-4b57-b2cd-1d1ec54c2176)


</details>

<details>
  <summary>Custom Comparator</summary><br>

 
![Custom Comparator](https://github.com/user-attachments/assets/1d3af52c-effa-4a3f-98c8-8dbd0fe47a05)


</details>

 
</details>
