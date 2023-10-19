LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity datapathmultip is
  port (
  
  A ,B : IN STD_LOGIC_VECTOR(7 downto 0);
   final,iselA,iselB,iselAdd,iselP ,loadA,loadB,loadp ,shiftA,shiftB, reset, clk , cmpA,cmpB ,cmpP:std_LOGIC ;
	bi ,o_zero: OUT std_LOGIC ;
   SA, SB ,SP,pcomplemt: OUT std_LOGIC_VECTOR(7 downto 0)
	
  ) ;
end datapathmultip ;

architecture arch of datapathmultip is

	 
	 
	 SIGNAL entremuxA , entreshiftA, entrecompA : std_LOGIC_VECTOR(7 downto 0);
	  SIGNAL entremuxB , entreshiftB, entrecompB : std_LOGIC_VECTOR(7 downto 0);
	  Signal entreadd , addtop ,ptoadd,entremuxP,fP :STD_LOGIC_VECTOR(7 downto 0);
	  signal iszr :std_LOGIC;
	 
	 COMPONENT eightBitShiftRegistermultipauche
	PORT(
		i_resetBar, i_load, i_shift	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
		END COMPONENT ;
	 
	 COMPONENT eightBitShiftRegisterdroitmultip
	PORT(
		i_resetBar, i_load, i_shift	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_iszero,o_bi : OUT STD_LOGIC ;
		i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0)
		);
		end component;
		
    COMPONENT eightBit2x1MUXmultip
        PORT(
            i_sel : IN STD_LOGIC;
            i_D0, i_D1: IN STD_LOGIC_VECTOR(7 downto 0);
            o_q : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT addSub4bitmultip
  port (
    sub : IN STD_LOGIC;   
    i_X, i_Y : IN STD_LOGIC_VECTOR(7 downto 0); 
    o_Som : OUT STD_LOGIC_VECTOR(7 downto 0); 
    o_CarOut: OUT STD_LOGIC  
  ) ;
  
  
  
  end COMPONENT ;
  COMPONENT eightBitRegistermultip
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
END comPONENT;
	 
	 COMPONENT complementA
			  port (
    clk,comp,reset : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(7 downto 0);
	 
	
    o_q : OUT STD_LOGIC_VECTOR(7 downto 0)
  ) ;
    END COMPONENT;




	 begin    
	 
	 multiA : eightBit2x1MUXmultip port map( iselA,A,entremuxA,entreshiftA);
	 	 complemA: complementA port map(clk,cmpA,reset,entrecompA,entremuxA);

	 shfitA: eightBitShiftRegistermultipauche port map(reset,loadA,shiftA,clk,entreshiftA,shifttocompA);
	 
	  multiB : eightBit2x1MUXmultip port map( iselB,B,entremuxB,entreshiftB);
	 	 complemB: complementA port map(clk,cmpB,reset,entrecompB,entremuxB);

	 shfitB: eightBitShiftRegisterdroitmultip port map(reset,loadB,shiftB,clk,iszr,bi,entreshiftB,shifttocompB);
	 
	 multiavecadd: eightBit2x1MUXmultip port map ( iselAdd,"00000000",entrecompA,entreadd	);
	 
	 add : addsub4bitmultip port map ('0',entreadd,ptoadd,addtop);
	 
	 p : eightBitRegistermultip port map(reset,loadp,clk,fP,ptoadd);
	 complementp: complementA port map (clk,cmpP,reset,ptoadd,entremuxP);
	 multiP: eightBit2x1MUXmultip port map (iselP,addtop,entremuxP,fP);
	 resultatfinalp : eightBitRegistermultip port map(reset,final,clk,ptoadd,LkahrjP);
	 




    -- Output Driver
    SA <= entrecompA;
	 SB <= entrecompB;
--	 lkahrjP <= ptoadd;
	 pcomplemt <= entremuxP;
	 o_zero<=iszr;


end architecture ; -- arch