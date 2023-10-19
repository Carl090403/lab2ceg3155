LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity ALU is
  port (
    A,B : IN STD_LOGIC_VECTOR(3 downto 0);
    clock, reset : IN STD_LOGIC;
	 choix :IN std_LOGIC_VECTOR(1 downto 0);
	 result : out std_LOGIC_VECTOR(7 downto 0);
	 sout,nul,Carryout : out std_LOGIC
  ) ;
end ALU ;

architecture arch of ALU is

	 
cOMPONENT  eightBit4x1MUX 
  port (
    i_sel : IN STD_LOGIC_VECTOR(1 downto 0);
    i_D0, i_D1, i_D2, i_D3 : IN STD_LOGIC_VECTOR(7 downto 0);
    o_q : OUT STD_LOGIC_VECTOR(7 downto 0)
  ) ;
end COMPONENT ;

component finalmultip 
  port (
    A,B : IN STD_LOGIC_VECTOR(3 downto 0);
    clock, reset : IN STD_LOGIC;
	
    Sortie : OUT STD_LOGIC_VECTOR(7 downto 0)
  ) ;
  end component ;
  
  


component Add_sous_4bit is
  port (
    add_Sous : IN STD_LOGIC;    
    e1, e2 : IN STD_LOGIC_VECTOR(3 downto 0); 
    o_Sum : OUT STD_LOGIC_VECTOR(3 downto 0); 
    o_CarryOut: OUT STD_LOGIC   
  ) ;
end component ;
comPONENT finaldiv 
  port (
    A,B : IN STD_LOGIC_VECTOR(3 downto 0);
    clk, reset : IN STD_LOGIC;
	
    Q,R,A,B: OUT STD_LOGIC_VECTOR(3 downto 0)
  ) ;
  end component;
   


signal addsubtomux,mutiptomux,divtomux,outmux :std_LOGIC_VECTOR(7 downto 0);
signal addsubcarryout,debordplus,debordmoins :std_LOGIC ;

   

begin

 MUX : EIGhtBit4x1MUX port map (choix,addsubtomux,addsubtomux,mutiptomux,divtomux,outmux);
 sout<=addsubcarryout AND not(choix(1));
 nul<= not(outmux(7) or outmux(6) or outmux(5) or outmux(4) or outmux(3) or outmux(2) or outmux(1) or outmux(0) );
 result <= outmux;
 debordplus<=((not(A(3)) AND not(B(3)) AND addsubtomux(3)) or (A(3) AND B(3) AND NOT(addSUBTOMUX(3))))  and not(choix(1)) and not(choix(0));
 debordmoins<= ( ( (not(a(3)) and b(3) and addsuBTOMUX(3) ) or (a(3) and not(b(3)) and not(addsuBTOMUX(3))) )   and choix(0) and not(choix(1)) );
 Carryout <= debordmoins or debordplus ;
 --addsubtomux <=(0 => outaddsub(0),1=> outaddsub(1),2=> outaddsub(2),3=> outaddsub,4=> '0',5=> '0',6=> '0',7=> '0');

  mutiplier : finalmultip port map(A,B,clock,reset,mutiptomux);
 addersubb :addSub4bit port map(choix(0),A,B,addsubtomux(3 downto 0),addsubcarryout);
 diviseur : finaldiv port map(A,B,clock,reset,divtomux(3 downto 0),divtomux(7 downto 4));



end architecture ; -- arch