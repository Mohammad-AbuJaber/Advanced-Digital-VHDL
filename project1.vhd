-- Mohammad Ammar AbuJaber
-- 1190298
-- SEC.2

library ieee;
use ieee.std_logic_1164.all;

entity invertor is
	port (input : in std_logic;
	output : out std_logic);
end entity;

architecture invertor of invertor is
begin	  
	output <= not input after 2ns;
end architecture;  

-----------------------------------------------------------	

library ieee;
use ieee.std_logic_1164.all;

entity delayed_NAND is 
	port (input1,input2 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_NAND of delayed_NAND is 
begin
	output <= input1 NAND input2 after 5ns;
end architecture;

-----------------------------------------------------------		   

library ieee;
use ieee.std_logic_1164.all;

entity delayed_NOR is 
	port (input1,input2 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_NOR of delayed_NOR is 
begin
	output <= input1 NOR input2 after 5ns;
end architecture;		 

-----------------------------------------------------------			   

library ieee;
use ieee.std_logic_1164.all;

entity delayed_AND is 
	port (input1,input2 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_AND of delayed_AND is 
begin
	output <= input1 AND input2 after 7ns;
end architecture;
--**************************************************************
library ieee;
use ieee.std_logic_1164.all;

entity delayed_AND_3 is 
	port (input1,input2,input3 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_AND_3 of delayed_AND_3 is 
begin
	output <= input1 AND input2 AND input3 after 7ns;
end architecture;
--**************************************************************
library ieee;
use ieee.std_logic_1164.all;

entity delayed_AND_4 is 
	port (input1,input2,input3,input4 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_AND_4 of delayed_AND_4 is 
begin
	output <= input1 AND input2 AND input3 AND input4 after 7ns;
end architecture;
--**************************************************************
library ieee;
use ieee.std_logic_1164.all;

entity delayed_AND_5 is 
	port (input1,input2,input3,input4,input5 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_AND_5 of delayed_AND_5 is 
begin
	output <= input1 AND input2 AND input3 AND input4 AND input5 after 7ns;
end architecture;

-----------------------------------------------------------	

library ieee;
use ieee.std_logic_1164.all;

entity delayed_OR is 
	port (input1,input2 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_OR of delayed_OR is 
begin
	output <= input1 OR input2 after 7ns;
end architecture;
--**************************************************************
library ieee;
use ieee.std_logic_1164.all;

entity delayed_OR_3 is 
	port (input1,input2,input3 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_OR_3 of delayed_OR_3 is 
begin
	output <= input1 OR input2 OR input3 after 7ns;
end architecture;
--**************************************************************
library ieee;
use ieee.std_logic_1164.all;

entity delayed_OR_4 is 
	port (input1,input2,input3,input4 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_OR_4 of delayed_OR_4 is 
begin
	output <= input1 OR input2 OR input3 OR input4 after 7ns;
end architecture;
--************************************************************** 
library ieee;
use ieee.std_logic_1164.all;

entity delayed_OR_5 is 
	port (input1,input2,input3,input4,input5 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_OR_5 of delayed_OR_5 is 
begin
	output <= input1 OR input2 OR input3 OR input4 OR input5 after 7ns;
end architecture;	

-----------------------------------------------------------	   

library ieee;
use ieee.std_logic_1164.all;

entity delayed_XNOR is 
	port (input1,input2 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_XNOR of delayed_XNOR is 
begin
	output <= input1 XNOR input2 after 9ns;
end architecture;		 

-----------------------------------------------------------	 

library ieee;
use ieee.std_logic_1164.all;

entity delayed_XOR is 
	port (input1,input2 : in std_logic;
	output : out std_logic);
end entity;

architecture delayed_XOR of delayed_XOR is 
begin
	output <= input1 XOR input2 after 12ns;
end architecture;		 

-----------------------------------------------------------	
-- 1-bir register
library ieee;
use ieee.std_logic_1164.all;
entity dff is
port (D,clk ,reset: in std_logic;
 Q: out std_logic); 
end entity;

architecture dff of dff is
begin 
process(clk, reset)
begin
	if (reset = '1') then
		Q<='0'; 
	elsif (rising_edge(clk)) then
		if (D='1') then
			Q<= '1';
		elsif(D='0') then
			Q<= '0';
		end if;
	end if;
end process;
end architecture;

-----------------------------------------------------------	

-- n-bir register ==> multiple DFFs

library ieee;
use ieee.std_logic_1164.all;
entity gen_register is
GENERIC (N : positive := 8); 
PORT (clk, reset : in STD_LOGIC;
		D: in std_logic_vector(n-1 downto 0);
		Q: out std_logic_vector(n-1 downto 0));
end entity gen_register;
architecture gen_register of gen_register is
begin
	gen : for i in 0 to n - 1 generate 
	gen1 : entity work.dff(dff) port map (D(i),clk,reset,Q(i));
	end generate; 
end architecture;

-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity F_Adder is
	port (a,b,c_in: in std_logic;
	sum,carry: out std_logic);
end entity;

architecture F_Adder of F_Adder is
signal sum0,carry0,x: std_logic;
begin
	g0: entity work.delayed_XOR(delayed_XOR) port map (a,b,sum0);
	g1: entity work.delayed_XOR(delayed_XOR) port map (sum0,c_in,sum);
	g2: entity work.delayed_AND(delayed_AND) port map (a,b,carry0);
	g3: entity work.delayed_AND(delayed_AND) port map (sum0,c_in,x);
	g4: entity work.delayed_OR(delayed_OR) port map (carry0,x,carry);
end architecture;

-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity eight_bit_adder is
	port (a,b: in std_logic_vector(7 downto 0);
	c_in: std_logic;
	sum: out std_logic_vector (7 downto 0);
	carry,overflow: out std_logic
	);
end entity;

architecture eight_bit_adder of eight_bit_adder is
signal ones_complement: std_logic_vector (7 downto 0);
signal c: std_logic_vector (8 downto 0);
begin
	c(0) <= c_in;
	gen1: for i in 0 to 7 generate
	      begin
	          g: entity work.delayed_XOR(delayed_XOR) port map (b(i),c_in,ones_complement(i));
			  f: entity work.F_Adder(F_Adder) port map (a(i),ones_complement(i),c(i),sum(i),c(i+1));  
            end generate;
	carry <= c(8);
	h: entity work.delayed_XOR(delayed_XOR) port map (c(7),c(8),overflow);
end architecture;

-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;


entity comparator is
	port (a,b: in std_logic_vector (7 downto 0);
	f1,f2,f3: inout std_logic:='0';
	outReg: out std_logic_vector(2 downto 0);
	clk: in std_logic);
end entity;					 

architecture comparator of comparator is
signal value,a_temp,b_temp: std_logic_vector(7 downto 0);
signal V_flag,Carry_flag,Not_Z_flag,test: std_logic;
signal reg: std_logic_vector(2 downto 0);

begin
Not_Z_flag <= '0' when value = "00000000" else '1';
test <= '1' when V_flag = value(7) else '0';
	g0: entity work.eight_bit_adder(eight_bit_adder) port map (a_temp,b_temp,'1',value,Carry_flag,V_flag);
	g1:	entity work.delayed_XOR(delayed_XOR) port map (value(7),V_flag,f3);
	g2:	entity work.delayed_AND(delayed_AND) port map (Not_Z_flag,test,f2);
		
	f1 <= '1' when value = "00000000" else '0';
		
	reg <= f1 & f2 & f3;
	
	reg0: entity work.gen_register(gen_register) generic map(8) port map(clk,'0',a,a_temp);	
	reg1: entity work.gen_register(gen_register) generic map(8) port map(clk,'0',b,b_temp);	
	reg2: entity work.gen_register(gen_register) generic map(3) port map(clk,'0',reg,outReg);	
		
end architecture;

-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity four_bit_comparator is
	port (a,b: in std_logic_vector(1 downto 0);
	AeqB,AgtB,AltB: out std_logic);
end entity;

architecture four_bit_comparator of four_bit_comparator is
signal notA,notB:std_logic_vector (2 downto 0);
signal operation: std_logic_vector (9 downto 0);
begin
	nA0: entity work.invertor(invertor) port map (a(0),notA(0));
	nA1: entity work.invertor(invertor) port map (a(1),notA(1));	
	nB0: entity work.invertor(invertor) port map (b(0),notB(0));
	nB1: entity work.invertor(invertor) port map (b(1),notB(1));
		
	eq0: entity work.delayed_AND_4(delayed_AND_4) port map (notA(1),notA(0),notB(1),notB(0),operation(0));
	eq1: entity work.delayed_AND_4(delayed_AND_4) port map (notA(1),a(0),notB(1),b(0),operation(1));
	eq2: entity work.delayed_AND_4(delayed_AND_4) port map (a(1),notA(0),b(1),notB(0),operation(2));
	eq3: entity work.delayed_AND_4(delayed_AND_4) port map (a(1),a(0),b(1),b(0),operation(3)); 
		eq4: entity work.delayed_OR_4(delayed_OR_4) port map (operation(0),operation(1),operation(2),operation(3),AeqB);
			
	agtb0: entity work.delayed_AND_3(delayed_AND_3) port map (a(0),notB(1),notB(0),operation(4));	
	agtb1: entity work.delayed_AND_3(delayed_AND_3) port map (a(1),a(0),notB(0),operation(5));
	agtb2: entity work.delayed_AND(delayed_AND) port map (a(1),notB(1),operation(6));	
		agtb3: entity work.delayed_OR_3(delayed_OR_3) port map (operation(4),operation(5),operation(6),AgtB);
			
	altb0: entity work.delayed_AND(delayed_AND) port map (notA(1),b(1),operation(7));
	altb1: entity work.delayed_AND_3(delayed_AND_3) port map (notA(1),notA(0),b(0),operation(8));
	altb2: entity work.delayed_AND_3(delayed_AND_3) port map (notA(0),b(1),b(0),operation(9));
		altb3: entity work.delayed_OR_3(delayed_OR_3) port map (operation(7),operation(8),operation(9),AltB);
end architecture;

-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_comparator is
	port (a,b: in std_logic_vector(7 downto 0);
	AeqB,AgtB,AltB: inout std_logic;
	outReg: out std_logic_vector(2 downto 0);
	clk: in std_logic);
end entity;

architecture eight_bit_comparator of eight_bit_comparator is   
signal temp: std_logic_vector(6 downto 0);
signal a_temp,b_temp: std_logic_vector(7 downto 0);
signal a_eq_b,a_gt_b: std_logic_vector (4 downto 0);
signal a_lt_b: std_logic;
signal reg: std_logic_vector(2 downto 0);
signal concatenation0,concatenation1,concatenation2,concatenation3,
	   concatenation4,concatenation5,concatenation6,concatenation7,
	   concatenation8,concatenation9: std_logic_vector (1 downto 0);
begin
	concatenation0 <= '0' & a_temp(7);
	concatenation1 <= '0' & b_temp(7);
	concatenation2 <= '0' & a_temp(6);
	concatenation3 <= '0' & b_temp(6);
	concatenation4 <= a_temp(5) & a_temp(4);   -- I could also do this by using a_temp(5 downto 4) inside the port map
	concatenation5 <= b_temp(5) & b_temp(4);
	concatenation6 <= a_temp(3) & a_temp(2);
	concatenation7 <= b_temp(3) & b_temp(2);
	concatenation8 <= a_temp(1) & a_temp(0);
	concatenation9 <= b_temp(1) & b_temp(0);
	
	g0: entity work.four_bit_comparator(four_bit_comparator) port map (concatenation0,concatenation1,a_eq_b(0),a_gt_b(0),a_lt_b);
	g1: entity work.four_bit_comparator(four_bit_comparator) port map (concatenation2,concatenation3,a_eq_b(1),a_gt_b(1),open);
	g2: entity work.four_bit_comparator(four_bit_comparator) port map (concatenation4,concatenation5,a_eq_b(2),a_gt_b(2),open);
	g3: entity work.four_bit_comparator(four_bit_comparator) port map (concatenation6,concatenation7,a_eq_b(3),a_gt_b(3),open);
	g4: entity work.four_bit_comparator(four_bit_comparator) port map (concatenation8,concatenation9,a_eq_b(4),a_gt_b(4),open);
	
	f1: entity work.delayed_AND(delayed_AND) port map (a_eq_b(0),a_gt_b(1),temp(1));
	f2: entity work.delayed_AND_3(delayed_AND_3) port map (a_eq_b(0),a_eq_b(1),a_gt_b(2),temp(2));	
	f3: entity work.delayed_AND_4(delayed_AND_4) port map (a_eq_b(0),a_eq_b(1),a_eq_b(2),a_gt_b(3),temp(3));
	f4: entity work.delayed_AND_5(delayed_AND_5) port map (a_eq_b(0),a_eq_b(1),a_eq_b(2),a_eq_b(3),a_gt_b(4),temp(4));
	f5: entity work.delayed_AND_5(delayed_AND_5) port map (a_eq_b(0),a_eq_b(1),a_eq_b(2),a_eq_b(3),a_eq_b(4),temp(5));
		AeqB <= temp(5);
	f6: entity work.delayed_OR_5(delayed_OR_5) port map (a_lt_b,temp(1),temp(2),temp(3),temp(4),temp(6));
		AgtB <= temp(6);
	f7: entity work.delayed_NOR(delayed_NOR) port map (temp(5),temp(6),AltB);
		
	reg <= AeqB & AgtB & AltB;

	reg0: entity work.gen_register(gen_register) generic map(8) port map(clk,'0',a,a_temp);	
	reg1: entity work.gen_register(gen_register) generic map(8) port map(clk,'0',b,b_temp);
	reg2: entity work.gen_register(gen_register) generic map(3) port map(clk,'0',reg,outReg);
	
end architecture;

------------------------------------------------	   


library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all; 

entity TestGenerator is
PORT(
clk: in std_logic:='0'; 
A,B: out std_logic_vector(7 downto 0):="00000000"; 
correctAnswer: out std_logic_vector(2 downto 0):="000");
end entity;

architecture generator of TestGenerator is 
signal possible_A,possible_B: std_logic_vector(7 downto 0):="00000000";
begin 
A<=possible_A;
B<=possible_B;
-- this is a process to calculate the expected value for the comparator
process (possible_A,possible_B) 
variable answer: std_logic_vector(2 downto 0):="000";
begin 
if (possible_A = possible_B) then
	answer:="100";
	elsif (possible_A > possible_B) then
		answer:="010";
	else 
		answer:="001";
end if;
correctAnswer <= answer;
end process;

-- it will change the value using loops over all possible input values
process 
begin
for i in 0 to 9 loop
	for j in 0 to 9 loop 
		for K in 0 to 9 loop 
			for L in 0 to 9 loop 
				possible_A(7 downto 4) <= conv_std_logic_vector(i,4);
				possible_A(3 downto 0) <= conv_std_logic_vector(j,4);
				possible_B(7 downto 4) <= conv_std_logic_vector(K,4);
				possible_B(3 downto 0) <= conv_std_logic_vector(L,4); 
wait until rising_edge(clk); 
			end loop;
		end loop;
	end loop; 
end loop;
wait;
end process;
end architecture;   
------------------------------------------------------------------------------
   
-- analyzing result
library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;

entity ResultAnalyser is
port(clk: in std_logic:='0'; 
correctAnswer,circuitOutcome: in std_logic_vector(2 downto 0):="000");
end entity;

architecture analyser1 of ResultAnalyser is
signal tmp:std_logic_vector(2 downto 0);
begin 
-- it will check if the calculated answer is same as expected answer 
process (clk)
begin
	if rising_edge(clk) then
			tmp <= correctAnswer after 80 ns;
			assert (circuitOutcome = tmp)
			report "The result you has is not as expected ==> there's an ERROR" 
			severity ERROR;
	end if;
end process;
end architecture;
------------------------------------------------------------------------------
architecture analyser2 of ResultAnalyser is
signal tmp:std_logic_vector(2 downto 0);
begin 
-- it will check if the calculated answer is same as expected answer 
process (clk)
begin
	if rising_edge(clk) then
			tmp <= correctAnswer after 330 ns;
			assert (circuitOutcome = tmp)
			report "The result you has is not as expected ==> there's an ERROR" 
			severity ERROR;
	end if;
end process;
end architecture;
-------- BIST
library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
entity BIST is
end BIST; 
--------------------------------------------------
----- testing for stage1
architecture stage1 of BIST is
signal clk: std_logic:='0';
signal A,B: std_logic_vector(7 downto 0):="00000000"; 
signal correctAnswer,circuitOutcome: std_logic_vector(2 downto 0):="000";
begin 
-- 40 * 2
clk <= not clk after 80 ns;
	g0: entity work.TestGenerator(generator) port map(clk, A, B, correctAnswer); 
	g1: entity work.eight_bit_comparator(eight_bit_comparator) port map(A, B,circuitOutcome(2),circuitOutcome(1),circuitOutcome(0),clk=>clk); 
	g2: entity work.ResultAnalyser(analyser1) port map(clk, correctAnswer, circuitOutcome); 
end architecture;

------------------------------------------------
--------- testing for stage2
architecture stage2 of BIST is
signal clk: std_logic:='0';
signal A,B: std_logic_vector(7 downto 0):="00000000"; 
signal correctAnswer,circuitOutcome: std_logic_vector(2 downto 0):="000";
begin 
-- 165 * 2	
clk <= not clk after 330 ns;
	g0: entity work.TestGenerator(generator) port map(clk, A, B, correctAnswer); 
	g1: entity work.comparator(comparator) port map(A, B,circuitOutcome(2),circuitOutcome(1),circuitOutcome(0),clk=>clk); 
	g2: entity work.ResultAnalyser(analyser2) port map(clk, correctAnswer, circuitOutcome); 
end architecture;