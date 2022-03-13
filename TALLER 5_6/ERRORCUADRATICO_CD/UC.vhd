library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port ( ALPHA,BETA,SIGMA,OMEGA,RHO,PHI : in  STD_LOGIC;
           INICIO : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (27 downto 0);
           FINAL : out  STD_LOGIC);
end UC;

architecture Behavioral of UC is

Type Estados is(ESTADO_0,ESTADO_1,ESTADO_2,ESTADO_3,ESTADO_4,ESTADO_5,ESTADO_6,ESTADO_7,ESTADO_8,ESTADO_9,ESTADO_10,ESTADO_11,ESTADO_12,ESTADO_13,ESTADO_14,ESTADO_15,ESTADO_16);

Signal ST: Estados;

begin

process(CLK,RST,ST,AlPHA,BETA,SIGMA,OMEGA,RHO,PHI,INICIO)

		begin
			if RST= '1' then
					ST<= ESTADO_0;
				elsif clk= '1' and clk'event then
					
					case ST is
					
							when ESTADO_0 =>
								if INICIO = '0' then
									ST<= ESTADO_0;
								else
									ST<= ESTADO_1;
								end if;

							when ESTADO_1 =>
								ST<= ESTADO_2;

							when ESTADO_2 =>
								ST<= ESTADO_3;

							when ESTADO_3 =>
								ST<= ESTADO_4;		
								
							when ESTADO_4 =>
								ST<= ESTADO_5;

									
							when ESTADO_5 =>
								ST<= ESTADO_6;


							when ESTADO_6 =>
								if ALPHA = '0' then
									ST<= ESTADO_2;
								else
									ST<= ESTADO_7;
								end if;
								
							when ESTADO_7 =>
								if BETA= '1' then
									ST<=ESTADO_8;
								else
									ST<=ESTADO_13;
								end if;
							
							when ESTADO_8 =>
								ST<=ESTADO_9;
								
							when ESTADO_9 =>
								if SIGMA= '1' then
									ST<=ESTADO_10;
								else
									ST<=ESTADO_12;
								end if;	

							when ESTADO_10 =>
								ST<=ESTADO_11;

							when ESTADO_11 =>
								ST<=ESTADO_9;
								
							when ESTADO_12 =>
								if OMEGA= '1' then
									ST<=ESTADO_8;
								else
									ST<=ESTADO_16;
								end if;	
								
							when ESTADO_13 =>
								if RHO= '1' then
									ST<=ESTADO_14;
								else
									ST<=ESTADO_15;
								end if;

							when ESTADO_14 =>
								ST<=ESTADO_13;
								
							when ESTADO_15 =>
								if PHI= '1' then
									ST<=ESTADO_8;
								else
									ST<=ESTADO_16;
								end if;
								
							when ESTADO_16 =>
								--ST<=ESTADO_0;		
								
						when others =>
							--ST<= ESTADO_0;			
					end case;
			end if;
End process;

process(ST)
		begin
		case ST is
		when ESTADO_0=>
			PC<="----------------0----100---0";
			FINAL <= '0';
		when ESTADO_1=>
			PC<="----100----0----101000010100";
			FINAL <= '0';
		when ESTADO_2=>
			PC<="----00----------100000100100";
			FINAL <= '0';
		when ESTADO_3=>
			PC<="----01----------100010100100";
			FINAL <= '0';			
		when ESTADO_4=>
			PC<="----101000010001100100101100";
			FINAL <= '0';
		when ESTADO_5=>
			PC<="----101001010010100110100000";
			FINAL <= '0';
		when ESTADO_6=>
			FINAL<='0';
			PC<="----101010010011101000011010";
		when ESTADO_7=>
			FINAL<='0';
			PC<="000010101000----101010--1110";
		when ESTADO_8=>
			FINAL<='0';
			PC<="10101010100-----101000--0010";
		when ESTADO_9=>
			FINAL<='0';
			PC<="10101110100-----101110-----0";
		when ESTADO_10=>
			FINAL<='0';
			PC<="10101010101-----101010--1000";
		when ESTADO_11=>
			FINAL<='0';
			PC<="1010101010010111101000--1100";
		when ESTADO_12=>
			FINAL<='0';
			PC<="0110101010110100101010--0010";
		when ESTADO_13=>
			FINAL<='0';
			PC<="10101110100-----101110-----0";
		when ESTADO_14=>
			FINAL<='0';
			PC<="1001101010010111101000--1100";
		when ESTADO_15=>
			FINAL<='0';
			PC<="1010--10100----------0-----0";
		when others=>
			PC<="1010--101010----0----0--1011";
			FINAL <= '1';
		end case; 
		end process;

end Behavioral;