LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity complementA is
  port (
    clk,comp,reset : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(7 downto 0);
	 
	
    o_q : OUT STD_LOGIC_VECTOR(7 downto 0)
  ) ;
end complementA ;




architecture beh of complementA is


    SIGNAL   brra: STD_LOGIC_VECTOR(7 downto 0);
	 signal cout :std_LOGIC ; 


    COMPONENT addSub4bitmultip
       port (
    sub : IN STD_LOGIC;   
    i_X, i_Y : IN STD_LOGIC_VECTOR(7 downto 0); 
    o_Som : OUT STD_LOGIC_VECTOR(7 downto 0); 
    o_CarOut: OUT STD_LOGIC  
  ) ;
    END COMPONENT;
	 


begin
	 comple : addSub4bitmultip port map ('0',not(A),"00000001",brra,cout);
 
    -- Output driver
    o_q <= brra;

end architecture ; -- arch