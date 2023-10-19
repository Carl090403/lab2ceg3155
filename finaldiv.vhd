--------------------------------------------------------------------------------
-- Title         : Top Entity filefor Lab 1
-------------------------------------------------------------------------------
-- File          : final.vhd
-------------------------------------------------------------------------------
-- Description : This file creates the top entity file for lab1.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity finaldiv is
  port (
    A,B : IN STD_LOGIC_VECTOR(3 downto 0);
    clk, reset : IN STD_LOGIC;
	
    Q,R,AS,BS: OUT STD_LOGIC_VECTOR(3 downto 0)
  ) ;
end finaldiv ;

architecture arch of finaldiv is

    SIGNAL loadAdp,loadBdp,shiftAdp,loadRdp,shiftRdp,loadQdp,countdp ,wshift,counter,greteq : STD_LOGIC ;
	 



    COMPONENT datapathdiv
         port (
  
  A ,B : IN STD_LOGIC_VECTOR(3 downto 0);
   loadA,loadB,shiftA,loadR,shiftR,loadQ,clk,resetbar,count: in std_LOGIC ;
   outQ, outR,outA,outB : OUT std_LOGIC_VECTOR(3 downto 0);
	o_w,i,retb : out std_LOGIC
	
  ) ;
  


		  
		  
    END COMPONENT;

    COMPONENT controlpathdiv
        port (
     resetb : IN STD_LOGIC;
    clock  : IN STD_LOGIC;
    isvalid,rsubegb : IN STD_LOGIC;
	 loadA,loadB,shiftA,loadR,shiftR,loadQ,count: OUT STD_LOGIC
  ) ;
    END COMPONENT;
	 

	 


   

begin




data: datapathdiv port map (A,B,loadAdp,loadBdp,shiftAdp,loadRdp,shiftRdp,loadQdp,clk,not(reset),countdp,Q,R,AS,BS,wshift,counter,greteq);

control:controlpathdiv port map(not(reset),clk,counter,greteq,loadAdp,loadBdp,shiftAdp,loadRdp,shiftRdp,loadQdp,countdp);


    
    -- Output Driver
	


end architecture ; -- arch