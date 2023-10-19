--------------------------------------------------------------------------------
-- Title         : 3-bit Shift Register
-- Project       : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- File          : threeBitShiftRegister.vhd
-- Author        : Rami Abielmona  <rabielmo@site.uottawa.ca>
-- Created       : 2003/05/17
-- Last modified : 2007/09/25
-------------------------------------------------------------------------------
-- Description : This file creates a 3-bit shift register as defined in the VHDL 
--		 Synthesis lecture. The architecture is done at the RTL 
--		 abstraction level and the implementation is done in structural
--		 VHDL.
-------------------------------------------------------------------------------
-- Modification history :
-- 2003.05.17 	R. Abielmona		Creation
-- 2004.09.22 	R. Abielmona		Ported for CEG 3550
-- 2007.09.25 	R. Abielmona		Modified copyright notice
-------------------------------------------------------------------------------
-- This file is copyright material of Rami Abielmona, Ph.D., P.Eng., Chief Research
-- Scientist at Larus Technologies.  Permission to make digital or hard copies of part
-- or all of this work for personal or classroom use is granted without fee
-- provided that copies are not made or distributed for profit or commercial
-- advantage and that copies bear this notice and the full citation of this work.
-- Prior permission is required to copy, republish, redistribute or post this work.
-- This notice is adapted from the ACM copyright notice.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourbitregisterQdiv IS
	PORT(
		i_resetBar, i_shift	: IN	STD_LOGIC;
		i_clock,w			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(3 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0)
			);
END fourbitregisterQdiv;

ARCHITECTURE rtl OF fourbitregisterQdiv IS
	SIGNAL int_Value, int_notValue ,outmux: STD_LOGIC_VECTOR(3 downto 0);

	COMPONENT enARdFF_2div
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
	    COMPONENT twox1MUXdiv
        port (
    i_sel : IN STD_LOGIC;
    i_D0, i_D1 : IN STD_LOGIC;
	
	
    o_q : OUT STD_LOGIC
  ) ;
    END COMPONENT;

BEGIN







			
mux3 :twox1MUXdiv port map(i_shift,i_value(3),int_Value(2),outmux(3));

bit3: enARdFF_2div
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => outmux(3), 
			  i_enable =>  i_shift,
			  i_clock => i_clock,
			  o_q => int_Value(3),
	          o_qBar => int_notValue(3));


mux2 :twox1MUXdiv port map(i_shift,i_value(2),int_Value(1),outmux(2));

bit2: enARdFF_2div
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => outmux(2), 
			  i_enable  => i_shift,
			  i_clock => i_clock,
			  o_q => int_Value(2),
	          o_qBar => int_notValue(2));
				 
mux1 :twox1MUXdiv port map(i_shift,i_value(1),int_Value(0),outmux(1));

bit1: enARdFF_2div
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => outmux(1), 
			  i_enable  => i_shift,
			  i_clock => i_clock,
			  o_q => int_Value(1),
	          o_qBar => int_notValue(1));

				 
mux0 :twox1MUXdiv port map(i_shift,i_value(0),w,outmux(0));

bit0: enARdFF_2div
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => outmux(0),
			  i_enable  =>  i_shift, 
			  i_clock => i_clock,
			  o_q => int_Value(0),
	          o_qBar => int_notValue(0));

	-- Output Driver
	o_Value		<= int_Value;

END rtl;