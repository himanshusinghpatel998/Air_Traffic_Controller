The motivation for this project arises from the need to reduce human intervention in ATC processes and minimize the possibility of human error, particularly in critical situations like emergency landings and many more. By leveraging digital circuits, the system ensures faster, more accurate decision-making in real-time, thereby enhancing both safety and operational efficiency. In an environment where even minor delays or mistakes can have serious consequences, automating such processes can significantly improve airport management, especially when multiple variables like weather conditions, runway availability, and aircraft fuel status must be considered simultaneously.

### Features:
 Our contribution lies in developing an automated ATC system that receives data from aircraft sensors—range, speed, altitude, and fuel level—as well as weather sensors. A majority voting circuit is incorporated to reduce errors in the sensor inputs, ensuring accurate and reliable data processing. We have integrated a RADAR detection feature, which monitors incoming planes approaching the airport for landing. One of the unique features of this project includes automatic emergency management feature. When an aircraft’s fuel level is critically low or if it has any damage, the system designates it as an emergency, prioritizes its landing, and dispatches ground vehicles to assist. If an aircraft’s fuel is too high, the system prevents it from landing until the fuel level reaches a safe threshold, avoiding potential risks. The system handles emergencies, prioritizes aircraft based on fuel status and other features, and improves the overall safety and reliability of airport operations through a fully automated process.
  Our automated ATC system processes data from aircraft sensors (range, speed, altitude, fuel level) and weather sensors. It features RADAR for monitoring incoming planes
 and an automatic emergency management system that prioritizes landings for aircraft with
 low fuel or damage, dispatching ground vehicles when needed. The system prevents landings
 if fuel levels are too high till it reaches a safe threshold, handles emergencies, and prioritizes
 aircraft based on fuel status, improving safety and reliability through full automation.
</details>

## Functional Block Diagram

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
  Flight Detection using Radar
  Once a flight is detected, the system receives data from multiple sensors aboard the plane, such as  speed, range, height, fuel level, and emergency status.
   Weather data is also gathered from the ATC.
  Mnimization of Errors Using Majority Voting Circuit
•	Logic Gate: Majority Voting Circuit (involves AND and OR gates).
   To ensure accurate input data, a majority voting circuit is used. This circuit minimizes the impact of faulty sensor readings.
   For instance, if three sensors are measuring the plane’s speed and two report a speed of 300 knots while one reports 310 knots, the system will choose the majority value.
   This improves reliability by eliminating outliers caused by faulty sensors.
   The system aggregates the majority of correct data for various sensor inputs such as speed, range, and height, using this logic.
   In essence, the majority voting circuit outputs the most frequently reported sensor value, ensuring the plane’s vital data is accurately processed.

  Fuel Status and Emergency Handling
  low fuel
  
  Fuel Status and Emergency Handling <br>
  Low fuel:
   The system also checks the plane’s fuel level and whether there is any emergency situation.
It automatically considers the situation to be an emergency when fuel is low and when fuel is in excess, its let to be in air until it reaches optimum level. 
Emergency Handling 
 If any part of the weather input is favorable (such as visibility, wind speed, etc.), the system allows the operation to proceed.
For example, if visibility is good and wind speed is within limits, the OR gate outputs true, and the system moves to check runway availability.
However, if all weather conditions are unfavorable, the system waits until the weather improves. We use 12 second timer for that.
Runway Vacancy Using Counter
   Once weather conditions are favorable, the system checks runway availability. An AND gate verifies two conditions:
  	Weather is favorable.
	Runway is vacant.
Runway Vacancy Using D FlipFlop:<br>
   Once weather conditions are favorable, the system checks runway availability. An AND gate verifies two conditions:<br>
  	Weather is favorable.<br>
	Runway is vacant.<br>
  If both conditions are true, respective runway is assigned and the plane is cleared for landing.
  Runway Allocation 

   The counter is the core of this system, cycling through the values 0, 1, and 2 to handle the runway assignment.
 •	Counter Values:
  o	Counter = 0: Represents that Runway 1 is available and should be assigned.
  o	Counter = 1: Represents that Runway 2 is available and should be assigned.
  o	Counter = 2: No runway is available, so the timer circuit will be activated.
  If the runway is occupied, the system waits until it becomes vacant, or it engages a 15-second timer to avoid long delays.
  Once the timer stops, the counter is reset to 0 and the same process is repeated (in this case runway 1 is allocated).
  If weather is not good and fuel is excess then there is a timer of 12 second.
   Second Timer 
   If the runway remains occupied, the system initiates a 15-second timer.
   The NOT gate initially holds the allocation, but after 15 seconds, the signal flips, allowing the system to proceed even if the runway is still technically occupied. The AND gate checks that both the weather 
  remains favorable and the 15-second timer has expired. Once both conditions are met, the system allocates the runway for landing.
  Gate Allocation
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
Runway Vacancy Using Counter
  The memory of the system is dynamically updated based on the status of the gates, ensuring that the system operates smoothly even during peak traffic periods.

### Takeoff
   Takeoff Clearance
   Takeoff Clearance<br>
   Once the system confirms the runway is clear and weather conditions are favorable, the plane is cleared for takeoff.
   If the runway is occupied for more than 15 seconds, the system forces the allocation to avoid excessive delays.
   Once the plane takes off, it exits the system.
   	Weather Input:
   Once the plane takes off, it exits the system.<br>
   	Weather Input:<br>
   	This input ensures that the system only allows takeoffs when weather conditions are clear.
   It works in conjunction with logic gates (AND/OR) to either allow or block the process based on the weather.
   	Gate Inputs:
   	Gate Inputs:<br>
   	Planes waiting for takeoff are represented by gate inputs. Gates 1, 2, and 3 correspond to Runway 1, while Gates 4, 5, and 6 correspond to Runway
    The system prioritizes runway assignment based on the plane’s gate: Runway 1 for gates 1–3, and Runway 2 for gates 4–6.
   	Runway Assigner:
     This module checks the availability of the preferred runway based on gate input.
    If the preferred runway is busy, the system assigns the other runway.
    If both runways are occupied, it triggers a 15-second timer before rechecking availability.
  	Timers:
   	A 12-second timer is used once a runway is assigned to check if the weather remains clear. After the timer finishes, the plane can proceed if conditions are favorable.
    A 15-second timer is triggered if both runways are busy, pausing the system before rechecking runway availability.
      Logic Gates and Runway Status:
  	Logic gates like AND and OR manage the flow of signals, ensuring that takeoffs are only allowed when both the runway is free and the weather is clear. The system also tracks the status of runways (busy or 
     free) using these gates.

    

  In essence, this circuit automates runway assignments, using logic gates and timers to manage conflicts, weather conditions, and runway availability effectively.
  In summary, the ATC system uses logic gates and a timer to manage inputs and conditions effectively.
  The gates ensure that all necessary factors, such as weather, runway availability, and emergency status, are checked and validated before an aircraft is cleared for takeoff or landing.
  The 12-second and 15 second timer helps prevent unnecessary delays, making the system efficient and responsive.
  The 9-second and 9 second timer helps prevent unnecessary delays, making the system efficient and responsive.<br>

### Truth Table:
 ### Main Circuit:

  ![MainCircuit](https://github.com/user-attachments/assets/6a7df0f9-e028-40a0-a0a0-25b8abc2bfc7)


  ### Radar Input: Runway Vacancy Using Counter

   
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
  
