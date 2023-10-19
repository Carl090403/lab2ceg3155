--------------------------------------------------------------------------------
-- Title         : Control Path for Lab 2
-------------------------------------------------------------------------------
-- File          : controlpath.vhd
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
entity controlpathmultip is
  port (
    resetB : IN STD_LOGIC;
    clock  : IN STD_LOGIC;
    a3, b3,bi,iszero : IN STD_LOGIC;
	 lda,ldb,ldp,cmpa,sela,cmpb,selb,seladd,shiftA,shiftB,cmpp,selp,salina : OUT STD_LOGIC
  ) ;
end controlpathmultip ;

architecture arch of controlpathmultip is
    SIGNAL int_state, int_d : STD_LOGIC_VECTOR(8 downto 0);
	 
	 SIGNAL AXORB :std_LOGIC;
	 
	 

    COMPONENT enardFF_2multip
        PORT(
            i_resetBar	: IN	STD_LOGIC;
            i_d		: IN	STD_LOGIC;
            i_enable	: IN	STD_LOGIC;
            i_clock		: IN	STD_LOGIC;
            o_q, o_qBar	: OUT	STD_LOGIC
        );
		  
    END COMPONENT;
	 
	 component enARdFF_2S0multip
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
END component;

begin


    AXORB <= (a3 xor b3);

    int_d(0) <= '0';
    int_d(1) <= (int_State(8) AND a3);
    int_d(2) <= ( (( int_State(8) AND not(a3)) OR int_State(1)) AND b3);
    int_d(3) <= ((( (((NOT(a3) AND int_State(8)) OR int_State(1)) AND NOT(b3) ) OR int_State(2)) AND (bi AND not(iszero) ) )OR (int_State(7)AND not(iszero) and bi ));
    int_d(4) <= ( (( (((NOT(a3) AND int_State(8)) OR int_State(1)) AND NOT(b3) ) OR int_State(2) OR int_State(7)) AND (NOT(bi) AND not(iszero)) ) OR INT_State(3)); 
	 int_d(5) <= ((AXORB and iszero ) AND (  (not(b3) AND((int_State(8) AND not(a3))OR int_State(1) ) ) OR int_State(2) OR int_state(7) ) );
 	 int_d(6) <=  ( ((NOT(AXORB) and iszero ) AND (  (not(b3) AND((int_State(8) AND not(a3))OR int_State(1) ) ) OR int_State(2) OR int_state(7) ) ) OR int_State(5));
	 int_d(7) <= (int_State(4));
	 int_d(8) <=  int_State(0)  ;

    state0: enARdFF_2S0multip port map(resetB,int_d(0), '1', clock, int_State(0));
    state1: enardFF_2multip port map(resetB, int_d(1), '1', clock, int_State(1));
    state2: enardFF_2multip port map(resetB, int_d(2), '1', clock, int_State(2));
    state3: enardFF_2multip port map(resetB, int_d(3), '1', clock, int_State(3));
    state4: enardFF_2multip port map(resetB, int_d(4), '1', clock, int_State(4));
	 state5: enardFF_2multip port map(resetB, int_d(5), '1', clock, int_State(5));
    state6: enardFF_2multip port map(resetB, int_d(6), '1', clock, int_State(6));
	 state7: enardFF_2multip port map(resetB, int_d(7), '1', clock, int_State(7));
	 state8 :enardFF_2multip port map(resetB, int_d(8), '1', clock, int_State(8));
	 


    -- Output Drivers
	 
	 
	 cmpa <= int_state(1);
	 sela <= int_State(1);
	 cmpb <= int_state(2);
	 selb <= int_State(2);
	 seladd <= int_State(3);
	 shiftA <= int_state(7);
	 shiftB <= int_State(4);
	 cmpp <= int_State(5);
	 selp<= int_State(5);
	 lda <= int_State(8) or int_State(1);
	 ldb <= int_State(0) or int_state(2);
	 ldp <= int_State(3) or int_State(5);
	 salina <=int_State(6);


  

end architecture ; -- arch