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

ENTITY decrementeurdiv IS
	PORT(
		i_rstBar, i_inc	: IN	STD_LOGIC;
		i_clk			: IN	STD_LOGIC;
		isdone			: Out	STD_LOGIC
	);
END decrementeurdiv;

ARCHITECTURE rtl OF decrementeurdiv IS

	COMPONENT enARdFF_2div
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
COMPONENT fourBitRegisterdiv
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(3 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0));
END COMPONENT;

COMPONENT addSub4bitdiv
  port (
    sub : IN STD_LOGIC;   
    i_X, i_Y : IN STD_LOGIC_VECTOR(3 downto 0); 
    o_Som : OUT STD_LOGIC_VECTOR(3 downto 0)
  ) ;
  
  END COMPONENT ;
  
  COMPONENT t2x1MUXdiv
    port (
    i_sel : IN STD_LOGIC;
    i_D0, i_D1 : IN STD_LOGIC_VECTOR(3 downto 0);
	
	
    o_q :  out STD_LOGIC_VECTOR(3 downto 0)
  ) ;
  END COMPONENT;
  SigNAL regtoadd ,addtoreg , muxtoadd :std_LOGIC_VECTOR(3 downto 0);
  sigNAL done :std_LOGIC ;
BEGIN

done <=(NOT(regtoadd(3)) AND NOT(regtoadd(1)) AND NOT(regtoadd(0)) AND regtoadd(2) );

addi : addSub4bitdiv port map ('0',muxtoadd,regtoadd,addtoreg);
addimux: t2x1MUXdiv port map(i_inc ,"0000","0001",muxtoadd);
reg: fourBitRegisterdiv port map(i_rstBar,i_inc and not(done),i_clk,addtoreg,regtoadd);

isdone<= done;





END rtl;
