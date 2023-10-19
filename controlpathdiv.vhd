--------------------------------------------------------------------------------
-- Title         : Control Path for Lab 2
-------------------------------------------------------------------------------
-- File          : controlpath.vhd
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
entity controlpathdiv is
  port (
    resetb : IN STD_LOGIC;
    clock  : IN STD_LOGIC;
    isvalid,rsubegb : IN STD_LOGIC;
	 loadA,loadB,shiftA,loadR,shiftR,loadQ,count: OUT STD_LOGIC
  ) ;
end controlpathdiv ;

architecture arch of controlpathdiv is
    SIGNAL int_s, int_d : STD_LOGIC_VECTOR(6 downto 0);
	 
	 
	 

    COMPONENT enardFF_2div
        PORT(
            i_resetBar	: IN	STD_LOGIC;
            i_d		: IN	STD_LOGIC;
            i_enable	: IN	STD_LOGIC;
            i_clock		: IN	STD_LOGIC;
            o_q, o_qBar	: OUT	STD_LOGIC
        );
		  
    END COMPONENT;
	 
	 component enARdFF_2S0div
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
END component;

begin



    int_d(0) <= '0';
    int_d(1) <= (not(isvalid) AND (int_s(0) or int_s(3) or int_s(4)));
    int_d(2) <= ( int_s(1));
    int_d(3) <= (rsubegb AND int_s(6));
    int_d(4) <= (not(rsubegb) AND int_s(6)); 
	 int_d(5) <= (isvalid AND (int_s(0) or int_s(3) or int_s(4)));
	 int_d(6) <=  (int_State(2));


    s0: enARdFF_2S0div port map(resetb,int_d(0), '1', clock, int_s(0));
    s1: enardFF_2div port map(resetb, int_d(1), '1', clock, int_s(1));
    s2: enardFF_2div port map(resetb, int_d(2), '1', clock, int_s(2));
    s3: enardFF_2div port map(resetb, int_d(3), '1', clock, int_s(3));
    s4: enardFF_2div port map(resetb, int_d(4), '1', clock, int_s(4));
	s5: enardFF_2div port map(resetb, int_d(5), '1', clock, int_s(5));
	s6: enardFF_2div port map(resetb, int_d(6), '1', clock, int_s(6));

    -- Output Drivers
	 
	 loadA<= int_s(0);
	 loadB<= int_s(0);
	 count <=int_s(6);
	 shiftA <=int_s(1);
	 shiftR <= int_s(2);
	 loadR <= int_s(3);
	 loadQ<=int_s(3) or int_s(4);
	 


  

end architecture ; -- arch