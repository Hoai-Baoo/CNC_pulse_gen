# CNC_pulse_gen
# Introduction

![Figure 1 - Connection Diagrams.](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/7301d840-8e6f-4dcb-8b55-49f37969f4c9)

*Figure 1 - Connection diagrams.*

![Figure 2 - CNC machine.](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/64fe47f4-9c12-41bf-a5c4-7fa2734bddfc)

*Figure 2 - CNC machine and SCARA robot.*

![Figure 3 - CNC machine and drivers.](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/dd84696a-cda4-49bd-885a-9b5ce7481c4b)

*Figure 3 - CNC machine and drivers.*



We need to write a program in HDL language (Quartus II) to control 2 servo drives. 

![Figure 4 - Interpolation module for CNC machines, robots](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/726ad829-24b8-467e-87e1-b60dcb43a396)

*Figure 4 - Interpolation module for CNC machines, robots.*



| If servo X run is done,  servo Y run       | If servo X and servo Y run asynchronous.  |
|:----------:|:---------:|
| ![image](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/dede54b7-db6c-4d41-8d06-39d56c68393b) | ![image](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/6c8cf6f5-33be-461f-922b-ea7dffb0463f)        | 

![*Figure 5 - Example.*](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/35ac6950-1f2b-4073-aad5-cff40aedb906)

*Figure 5 - Example.*

**Requests:**
1. Write for 2 axes X,Y
2. When there is a rising edge of WR, Nx loads a new value. But this value does not affect the current T cycle, but the next T cycle.
3. When the Nx value is not written (does not output WR and Nbuff = 0) in the current T cycle, the next T cycle must not output pulses to the Pulse pin. (Do not take the old value to continue spreading)
4. When simulating, add 1 more flag_T output to check every T cycle.
5. Simulation N = 10, Fixed (constant N)
6. clk = 1us, clk1 = 100us, Pulse output algorithm is based on clk1, other signals are based on clk.
7. Allow to write up to 4 WR pulses to the buffer in 1 flag_T cycle (Nbuff = 4), do not save the buffer if the 5th WR pulse occurs. When writing all 4 flag values flag_full = 1. Check only when flag_full = 0 (when Nbuff = 3, 2, 1, 0) then continue to receive WR value.
8. When LS=1, Pulse output=0 and all buffers will be cleared, as reset state from the beginning. Pulse outputs only at the next T cycle when LS = 0 and there is a WR pulse after that.

![Illustration](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/9a7bb260-cd6c-4894-b2d8-4f973f7045f3)


*Figure 6 - Illustration.*

# Algorithm
![Figure 7 - Line interpolation algorithm according to standard pulse method.](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/7db444da-e394-49d7-917e-6904735fdb7b)

*Figure 7 - Line interpolation algorithm according to standard pulse method (This algorithm is supported by Ph.D. Nguyen Vinh Hao).*

# Simulation results for 1 servo

![Figure 8 - LS=0.](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/b40daeb4-b14d-4bce-bb6f-4d258a99db1f)

*Figure 8 - LS=0.*

![Figure 9 - There is pulse LS=1 for 1 period.](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/84b896eb-50a1-4bb4-99cd-c5873dd399a7)

*Figure 9 - There is pulse LS=1 for 1 period.*

# Simulation results for 2 servo

![Figure 10 - Block diagrams.](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/42c6b7d3-7dd4-4e0f-9a35-91c53e4e9c77)

*Figure 10 - Block diagrams.*

![image](https://github.com/Hoai-Baoo/CNC_pulse_gen/assets/93426264/648a97f4-904a-4779-87c4-9cd8c43623f7)

*Figure 11 - Result for 2 axes X,Y.*











