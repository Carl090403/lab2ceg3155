--------------------------------------------------------------------------------
-- Title         : Top Entity filefor Lab 1
-------------------------------------------------------------------------------
-- File          : final.vhd
-------------------------------------------------------------------------------
-- Description : This file creates the top entity file for lab1.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity finalmultip is
  port (
    A,B : IN STD_LOGIC_VECTOR(3 downto 0);
    clock, reset : IN STD_LOGIC;
	
    Sortie : OUT STD_LOGIC_VECTOR(7 downto 0)
  ) ;
end finalmultip ;

architecture arch of finalmultip is

    SIGNAL iselAdp,iselBdp,iselAdddp,iselPdp ,loadAdp,loadBdp,loadpdp ,shiftAdp,shiftBdp, cmpAdp,cmpBdp ,cmpPdp : STD_LOGIC ;
	 SIGNAL  bidatatocontrol,bzero : std_LOGIC;
	 SIGNAL atodp , btodp ,ptoaff ,abba,bba :STD_LOGIC_VECTOR(7 downto 0);
	 SIGNAL resfinal : STD_LOGIC;
	SIGNAL selaff : STD_LOGIC_VECTOR (1 downto 0);
		signal  pcomplem : STD_LOGIC_VECTOR(7 downto 0 );


    COMPONENT datapathmultip
         port (
  
  A ,B : IN STD_LOGIC_VECTOR(7 downto 0);
   final,iselA,iselB,iselAdd,iselP ,loadA,loadB,loadp ,shiftA,shiftB, reset, clk , cmpA,cmpB ,cmpP:std_LOGIC ;
	bi ,o_zero: OUT std_LOGIC ;
   SA, SB ,SP,pcomplemt: OUT std_LOGIC_VECTOR(7 downto 0)
	
  ) ;
  

		  

		  
		  
    END COMPONENT;

    COMPONENT controlpathmultip
        port (
    i_gresetBar : IN STD_LOGIC;
    i_gclock  : IN STD_LOGIC;
    a3, b3,bi,iszero : IN STD_LOGIC;
	 lda,ldb,ldp,cmpa,sela,cmpb,selb,seladd,shiftA,shiftB,cmpp,selp,salina : OUT STD_LOGIC
  ) ;
    END COMPONENT;



   

begin


	atodp <=(0 =>A(0),1=>A(1),2=>A(2),3=>A(3),4=>A(3),5=>A(3),6=>A(3),7=>A(3));
	btodp <=(0 =>B(0),1=>B(1),2=>B(2),3=>B(3),4=>B(3),5=>B(3),6=>B(3),7=>B(3));
	  	 data: datapathmultip port map (atodp,btodp,resfinal,iselAdp,iselbdp,iselAdddp,iselpdp,loadAdp,loadbdp,loadpdp,shiftAdp,shiftBdp,NOT(reset),clock,cmpAdp,cmpBdp,cmpPdp,bidatatocontrol,bzero,abba,bba,ptoaff,pcomplem);

	 	 control:controlpathmultip port map(NOT(reset),clock,A(3),B(3),bidatatocontrol,bzero,loadAdp,loadBdp,loadpdp,cmpAdp,iselAdp,cmpBdp,iselbdp,iselAdddp,shiftAdp,shiftBdp,cmpPdp,iselPdp,resfinal);



    
    -- Output Driver
    Sortie <= ptoaff;


end architecture ; -- arch