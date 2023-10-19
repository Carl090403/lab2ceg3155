LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity shiftregBmultip is
  port (
    clk,shiftl,load,reset : IN STD_LOGIC;
    B : IN STD_LOGIC_VECTOR(7 downto 0);
	 
	 
	
	
    o_q : OUT STD_LOGIC_VECTOR(7 downto 0)
  ) ;
end shiftregBmultip ;




architecture beh of shiftregBmultip is


    SIGNAL regtoshift , shifttomux , muxtoreg: STD_LOGIC_VECTOR(7 downto 0);
	 
	 COMPONENT eightBit2x1MUXmultip
        PORT(
            i_sel : IN STD_LOGIC;
            i_D0, i_D1: IN STD_LOGIC_VECTOR(7 downto 0);
            o_q : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
    END COMPONENT;

    COMPONENT threeBitShiftRegistermultip
        PORT(
            i_resetBar, i_load	: IN	STD_LOGIC;
            i_clock			: IN	STD_LOGIC;
            i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
            o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0)
        );

    END COMPONENT;
	 
	 COMPONENT eightBitRegistermultip
        PORT(
            i_resetBar, i_load	: IN	STD_LOGIC;
            i_clock			: IN	STD_LOGIC;
            i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
            o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0)
        );
    END COMPONENT;

begin
    lmux : eightBit2x1MUXmultip port map(shiftl,A,shifttomux,muxtoreg);
    lreg :  eightBitRegistermultip port map(reset, load or shiftl, clk, muxtoreg, regtoshift);
	shfitl:threeBitShiftRegistermultip port map(reset,load or shiftl,clk,regtoshift,shifttomux);
 
    -- Output driver
    o_q <= regtoshift;

end architecture ; -- arch