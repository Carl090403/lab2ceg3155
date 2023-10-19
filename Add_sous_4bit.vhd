

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity Add_sous_4bit is
  port (
    add_Sous : IN STD_LOGIC;    
    e1, e2 : IN STD_LOGIC_VECTOR(3 downto 0); 
    o_Sum : OUT STD_LOGIC_VECTOR(3 downto 0); 
    o_CarryOut: OUT STD_LOGIC  
  ) ;
end Add_sous_4bit ;

architecture arch of Add_sous_4bit is
    SIGNAL Sum, CarryOut: STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL i_e2 : STD_LOGIC_VECTOR(3 downto 0);

    COMPONENT prelab_additionneur
     port (
    i_A, i_B : IN STD_LOGIC;   
    i_carryIn : IN STD_LOGIC;  
    o_Summ : OUT STD_LOGIC;        
    o_carryOut: OUT STD_LOGIC   
  ) ;
    END COMPONENT;

begin

    -- Signals 
    i_e2(3) <= e2(3) xor add_Sous;
    i_e2(2) <= e2(2) xor add_Sous;
    i_e2(1) <= e2(1) xor add_Sous;
    i_e2(0) <= e2(0) xor add_Sous;

    -- MSB is 3
    d0: prelab_additionneur port map(e1(0), i_e2(0), add_Sous, Sum(0), CarryOut(0));
    d1: prelab_additionneur port map(e1(1), i_e2(1), CarryOut(0), Sum(1), CarryOut(1));
    d2: prelab_additionneur port map(e1(2), i_e2(2), CarryOut(1), Sum(2), CarryOut(2));
    d3: prelab_additionneur port map(e1(3), i_e2(3), CarryOut(2), Sum(3), CarryOut(3));

    -- Output Driver
	o_Sum <= Sum;
	o_carryOut <= CarryOut(3);

end architecture ; -- arch