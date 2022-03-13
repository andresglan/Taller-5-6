library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity lcd_moduleC is 
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  -- Señales para escribir
           DECENASMIL,UNIDADESMIL,CENTENASUN,DECENASUN,UNIDADESUN,DECENASDEC,UNIDADESDEC: in std_logic_vector ( 3 downto 0); 
			  db : out  STD_LOGIC_VECTOR (7 downto 0);
           rs : out  STD_LOGIC;
           rw : out  STD_LOGIC;
           ena : out  STD_LOGIC);
end lcd_moduleC;

architecture Behavioral of lcd_moduleC is
type state is (se1,se2,se3,se4,se5,si1,si2,si3,s1ini2,s1ini3,s1ini4,s1ini5,s1lcur,s1write,s2write,sfin,s3write,s4write,s5write,s6write,s7write,s8write);
signal mq : state;

type nom is ( ini1,ini2,ini3,ini4,loccur,writx,writx1,writx2,writx3,writx4,writx5,writx6,writx7);
signal var: nom;

signal tc : std_logic_vector ( 20 downto 0);

signal dbi: std_logic_vector ( 7 downto 0);

-- num es la columna que queremos en este caso numero de 0 a 9 (3)
signal num  : std_logic_vector ( 3 downto 0); 

begin

rw <='0';

process(clk,reset)
	begin
		 if reset ='1' then 
			mq <= si1;
			rs <= '0';
			ena <= '0';
			tc <= ( others => '0');
			var <= ini1;
			db <= "00000000";
			dbi <= "00100000";
			num <= "0011";
		 elsif clk'event and clk ='1' then 
			
			case mq  is
--- rutina de env?o de datos			
			   when se1 =>
				     ena <= '1';
				     mq <= se2;
				
				when se2 =>
				     if tc < 101 then 
							tc <= tc + 1;
							mq <= se2;
					  else
							tc <= ( others =>'0');
							mq <= se3;
					end if;
					
				when se3 =>
						ena <= '0';
						mq <= se4;
						
				when se4 =>
						if tc < 2501 then
							tc <= tc + 1;
							mq <= se4;
						else
							tc <= ( others =>'0');
							mq <= se5;
						end if;
						
				when se5 =>
						case var is
						  when ini1 => mq <= s1ini2;
						  when ini2 => mq <= s1ini3;
						  when ini3 => mq <= s1ini4;
						  when ini4 => mq <= s1ini5;
						  when loccur => mq <= s1write;
						  when writx  => mq <= s2write ;
						  when writx1 => mq <= s3write;
						  when writx2 => mq <= s4write;
						  when writx3 => mq <= s5write;
						  when writx4 => mq <= s6write;
						  when writx5 => mq <= s7write;
						  when writx6 => mq <= s8write;
						  when writx7 => mq <= sfin;
						  
						  when others => null;
			         end case;
						   
	--inicializaci?n		
			
			
				when si1 =>  -- se configura LCD a 8 bits, 2 l?neas y caracter de 5 x 7
				
				ena <= '0';
				mq <= si2;
				
				when si2 =>
					if tc < 1000001 then 
					    tc <= tc + 1;
					    mq <= si2;
					else
						 tc <= (others =>'0');
						 mq <= si3;
					end if;
					
				when si3 =>
						db <= x"38";
						rs <= '0';
						mq <= se1;
						
				when s1ini2 =>   -- entry mode -- incremente apuntador y mueva cursor a la derecha
				     var <= ini2;
					  db <= x"06";
					  rs <= '0';
					  mq <= se1;
					  
				when s1ini3 =>  -- Display on, cursor off y est?tico.
				    var <= ini3;
					 db <= x"0C";
					 rs <= '0';
					 mq <= se1;
					 
				when s1ini4 => --  se borra display
				   var <= ini4;
					db <= x"01";
					rs <='0';
					mq <= se1;
					
				when s1ini5 =>   -- se espera ejecuci?n del borrado
					if tc < 1000001 then 
					    tc <= tc + 1;
					    mq <= s1ini5;
					else
						 tc <= (others =>'0');
						 mq <= s1lcur;
					end if;
				   
				when	s1lcur =>  -- ubica cursor en la posici?n 00
				var <= loccur;
				db <= x"80";
				rs <= '0';
				mq <= se1;
				--Aqui ponemos que se escribe con cada selectror
				--x"numnum" para escribir un simbolo em particular
				--var&var para un simbolo desede una señal
				-- el var, se configura al siguiente en la lista
				when s1write =>
						var <= writx;
						rs <= '1';
						db <= "0011"&DECENASMIL;
						mq <= se1;
				when s2write =>
						var <= writx1;
						rs <= '1';
						db <= "0011"&UNIDADESMIL;
						mq <= se1;
				when s3write =>
						var <= writx2;
						rs <= '1';
						db <= "0011"&CENTENASUN;
						mq <= se1;
						
				when s4write =>
						var <= writx3;
						rs <= '1';
						db <= "0011"&DECENASUN;
						mq <= se1;
				
				when s5write =>
						var <= writx4;
						rs <= '1';
						db <= "0011"&UNIDADESUN;
						mq <= se1;
						
				when s6write =>
						var <= writx5;
						rs <= '1';
						db <= x"2E";--punto
						mq <= se1;
						
				when s7write =>
						var <= writx6;
						rs <= '1';
						db <= "0011"&DECENASDEC;
						mq <= se1;

				when s8write =>
						var <= writx7;
						rs <= '1';
						db <= "0011"&UNIDADESDEC;
						mq <= se1;

			  when sfin => mq <= s1lcur;
			  
				
				
				when others => null;
			end case;
		end if;
end process;



end Behavioral;
