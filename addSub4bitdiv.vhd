---    :4-bit additionneur soustracteur

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity addSub4bitdiv is
  port (
    sub : IN STD_LOGIC;   
    i_X, i_Y : IN STD_LOGIC_VECTOR(3 downto 0); 
    o_Som : OUT STD_LOGIC_VECTOR(3 downto 0); 
    o_CarOut: OUT STD_LOGIC  
  ) ;
end addSub4bitdiv ;

architecture arch of addSub4bitdiv is
    SIGNAL Somme, CarryOut: STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL Y : STD_LOGIC_VECTOR(3 downto 0);

    COMPONENT additionneurUnBitdiv
      port (
    i_A, i_B : IN STD_LOGIC;   
    i_Cin : IN STD_LOGIC;  
    o_Somme : OUT STD_LOGIC;        
    o_Cout: OUT STD_LOGIC   
  ) ;
    END COMPONENT;

begin

    Y(3) <= i_Y(3) xor sub;
    Y(2) <= i_Y(2) xor sub;
    Y(1) <= i_Y(1) xor sub;
    Y(0) <= i_Y(0) xor sub;

    fa0: additionneurUnBitdiv port map(i_X(0), Y(0), sub, Somme(0), CarryOut(0));
    fa1: additionneurUnBitdiv port map(i_X(1), Y(1), CarryOut(0), Somme(1), CarryOut(1));
    fa2: additionneurUnBitdiv port map(i_X(2), Y(2), CarryOut(1), Somme(2), CarryOut(2));
    fa3: additionneurUnBitdiv port map(i_X(3), Y(3), CarryOut(2), Somme(3), CarryOut(3));

	 

    -- Output 
	o_Som <= Somme;
	o_CarOut <= CarryOut(3);

end architecture ; 