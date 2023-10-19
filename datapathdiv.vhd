LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity datapathdiv is
  port (
  
  A ,B : IN STD_LOGIC_VECTOR(3 downto 0);
   loadA,loadB,shiftA,loadR,shiftR,loadQ,clk,resetbar,count: in std_LOGIC ;
   outQ, outR,outA,outB : OUT std_LOGIC_VECTOR(3 downto 0);
	o_w,i,retb : out std_LOGIC
	
  ) ;
end datapathdiv ;

architecture arch of datapathdiv is

	COMPONENT fourbitregisterAdiv is 
		PORT(
		i_resetBar, i_load, i_shift	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(3 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0);
				w : OUT STD_LOGIC );
				
		end component ;
		
	COMPONENT fourbitregisterRdiv is 
	PORT(
		i_resetBar, i_load, i_shift	: IN	STD_LOGIC;
		i_clock,w			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(3 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0)
			);
			
			end comPONENT;
			
			COMPONENT  eightBitRegisterdiv
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(3 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0));
END component;

 COmPONENT addSub4bitdiv 
   port (
    sub : IN STD_LOGIC;   
    i_X, i_Y : IN STD_LOGIC_VECTOR(3 downto 0); 
    o_Som : OUT STD_LOGIC_VECTOR(3 downto 0); 
    o_CarOut: OUT STD_LOGIC  
  ) ;
end component ;

component t2x1MUXdiv
  port (
    i_sel : IN STD_LOGIC;
    i_D0, i_D1 : IN STD_LOGIC_VECTOR(3 downto 0);
	
	
    o_q :  out STD_LOGIC_VECTOR(3 downto 0)
  ) ;
  
end component ;

COMPONENT decrementeurdiv
	PORT(
		i_rstBar, i_inc	: IN	STD_LOGIC;
		i_clk			: IN	STD_LOGIC;
		isdone			: Out	STD_LOGIC
	);
END COMPONENT;

component threeBitComparatordiv
	PORT(
		i_Ai, i_Bi			: IN	STD_LOGIC_VECTOR(3 downto 0);
		o_GT, o_LT, o_EQ		: OUT	STD_LOGIC);
END component;

component fourbitregisterQdiv
	PORT(
		i_resetBar, i_shift	: IN	STD_LOGIC;
		i_clock,w			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(3 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0)
			);
END component;



		


	signal test , higher,lower,equal : std_LOGIC;
	signal entreR , entreAddi,sortib :std_LOGIC_VECTOR(3 downto 0 );
	

	 begin   
	
	
	 registreA : fourbitregisterAdiv port map(resetbar,loadA,shiftA,clk,A,outA,test);
	 registreR : fourbitregisterRdiv port map(resetbar,loadR,shiftR,clk,test,entreR,entreAddi);
	 registreB : eightBitRegisterdiv port map(resetbar,loadB,clk,B,sortib);
	 regitreQ : fourbitregisterQdiv port map( resetbar,loadQ,clk,not(lower),"0000",outQ);
	 sub : addSub4bitdiv port map('1',entreAddi,sortib,entreR);
	 compteur:decrementeurdiv port map (resetbar,count,clk,i);
	 comparateur : threeBitComparatordiv port map(entreAddi,sortib,higher,lower,equal);
	 
	 o_w<=test;
	 outR<=entreAddi;
	 outB<=sortib;
	 retb<=higher or equal;
	 
	 
	 




 


end architecture ; -- arch