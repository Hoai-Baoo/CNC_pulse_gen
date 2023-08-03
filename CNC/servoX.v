module servoX(clk,WR,LS,Nx,N,Pulse,Dir,flag_T,flag_full);
input clk,WR,LS;
input[7:0] N,Nx;
output Pulse,Dir,flag_T,flag_full;

reg[7:0] count_clk1=0, acc=10;
reg[6:0] Nx_temp; 
reg[7:0] BUFF1, BUFF2, BUFF3, BUFF4;
reg Dir;
reg clk1=1;
reg pinout;
reg flag_T=1;
reg flag_full=0;
reg preWR, preflag_T;

reg[3:0] countWR=0, countT=0;

always@(posedge clk)
begin
	preWR <= WR;
	preflag_T <= flag_T;
	count_clk1 = count_clk1 + 1;
	
	if (count_clk1 == 50)
	begin
		clk1 = ~clk1;
	end
	else if (count_clk1 == 100)  	//clk1
	begin
		
		count_clk1 = 0;
		clk1 = ~clk1;
		countT = countT+1;
		
		if (countT == 10)   	//T
		begin					
			flag_T = ~flag_T;
			countT = 0;
						Nx_temp = BUFF1[6:0];
			Dir = BUFF1[7];
			BUFF1 = BUFF2;
			BUFF2 = BUFF3;
			BUFF3 = BUFF4;
			BUFF4 = 0;
		
			if (countWR > 0)
				countWR = countWR - 1;
			
		end
		
		acc = acc + Nx_temp;
		if (acc>N) 
		begin
			acc = acc - N;
			pinout = 1;
		end
		else 
			pinout = 0;
		//Khi LS = 1, ng� ra Pulse = 0 v� tat ca buffer se bi x�a
	end
	
	if (LS == 1)
	begin 
		BUFF1 = 0;
		BUFF2 = 0;
		BUFF3 = 0;
		BUFF4 = 0;
		Nx_temp = 0;
		countWR = 0;
		flag_full = 0;
	end
		
			
	if ( ({preWR,WR} == 2'b01) && (preflag_T == flag_T) && (flag_full == 0) )
	begin
		countWR = countWR + 1;
		
		if (countWR == 1)
			BUFF1 = Nx;
		else if (countWR == 2)
			BUFF2 = Nx;
		else if (countWR == 3)
			BUFF3 = Nx;
		else if (countWR == 4)
			BUFF4 = Nx; 
	end
	if (countWR >= 4)
		flag_full=1;
	else
		flag_full=0;

	
end
	
assign Pulse = clk1 & pinout;

endmodule
