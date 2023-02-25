with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.IO_Exceptions;

procedure Prime 
is	
	-- initialization
	N : Integer := 1;
	-- array of Booleans of size N
	type Sieve_Type is array (Integer range <>) of Boolean;
	begin
	-- REPL
	while True loop
		Ada.Text_IO.Put_Line ("Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit): ");
		Ada.Integer_Text_IO.Get (N);
		-- terminate loop on 0
		if (N = 0) then
			exit;
		-- retry on negative input
		elsif (N < 0) then
			Ada.Text_IO.Put_Line("Try again, I did say positive didn't I... ");
		-- else do the thing
		else
			declare
				-- array of size N to hold prime partition
				type Partition is array (0 .. N) of Integer;
				-- array of partitions
				type Partition_Type is array (Integer range <>) of Partition;

				-- returns whether N is prime
				function IsPrime (N : Integer) return Boolean
				is
					-- sub function recursive call for prime
					function PrimeRec (N, K : Integer) return Boolean
					is
					begin
						-- if N is divisible then not prime
						if ((N mod K) = 0) then
							return False;
						-- if hit the limit (better limit is sqrt(N), then is prime
						elsif ((N / 2) < K) then
							return True;
						-- check next divisor
						else
							return PrimeRec (N, K + 1);
						end if;
					end PrimeRec;
				
				begin
					if (N <= 1) then
						return False;
					elsif (N = 2) then
						return True;
					else
						return PrimeRec (N, 2);
					end if;
				end IsPrime;

				-- implementation of the sieve of erotosthanes
				-- returns an array of size N of bools indicating whether the index is prime
				function Sieve (N : Integer) return Sieve_Type
				is
					-- limit should be sqrt(N) but this works in place
					lim : Integer := (N / 2);
					I : Integer := 2;
					J : Integer;
					Bools : Sieve_Type (0 .. N) := (0 => False, others => True);
				begin
					if (N > 0) then
						Bools (1) := False;
					end if;
					while (I < lim) loop
						if (Bools (I)) then
							J := I * I;
							while (J <= N) loop
								Bools (J) := False;
								J := J + I;
							end loop;
						end if;
						I := I + 1;
					end loop;
					return Bools;
				end Sieve;

				-- returns an array of size N indicatating whether the index is a prime between K and N
				function SievePrimes (N, K : Integer) return Sieve_Type
				is
					Bools : Sieve_Type := Sieve (N);
					RetBools : Sieve_Type (0 .. N);
				begin
					for I in RetBools'Range loop
						-- if not in range then false
						if (I < K) then
							RetBools (I) := false;
						-- else then copy the initial value
						else
							RetBools (I) := Bools (I);
						end if;
					end loop;
					return RetBools;
				end SievePrimes;

				-- adds an integer to all the partitions in the list
				function AddElemToAllLists (LL : Partition_Type; I : Integer) return Partition_Type
				is
					-- sub function to add an integer to the front of a partition
					function AddElemToFront (L : Partition; I : Integer) return Partition
					is
						RetL : Partition;
					begin
						for J in L'Range loop
							-- adds to front
							if (J = 0) then
								RetL (J) := I;
							-- cuts off last digit in initial partition
							else
								RetL (J) := L(J - 1);
							end if;
						end loop;
						return RetL;
					end AddElemToFront;

					LLFirst : Partition := LL(0);
					RetLL : Partition_Type (LL'Range);

				begin
					-- -1 is the initialization value for all indices in the array
					if (LLFirst (0) = -1) then
						return LL;
					else
						-- iterates through all lists and adds element
						for J in LL'Range loop
							RetLL (J) := AddElemToFront ((LL (J)), I);
						end loop;
					end if;
					return RetLL;
				end AddElemToAllLists;

				-- adds two lists of lists together
				function ConcatList (LL1, LL2 : Partition_Type) return Partition_Type
				is
					RetLL : Partition_Type (0 .. (LL1'Length + LL2'Length - 1));
					LL1First : Partition := LL1 (0);
					LL2First : Partition := LL2 (0);
				begin
					-- checks emptinesses of lists
					if ((LL1First (0) = -1) and (LL2First (0) = -1)) then
						return LL1;
					elsif (LL1First (0) = -1) then
						return LL2;
					elsif (LL2First (0) = -1) then
						return LL1;
					else
						-- puts in LL1
						for I in LL1'Range loop
							RetLL (I) := LL1 (I);
						end loop;
						-- puts in LL2
						for I in LL2'Range loop
							RetLL (I + LL1'Length) := LL2(I);
						end loop;
					end if;
					return RetLL;
				end ConcatList;
				
				-- compiles a list of partitions
				function PrimePartition (N, K, J : Integer) return Partition_Type
				is
					Empty_Partition : Partition := (others => -1);
					Empty_Partition_Type : Partition_Type (0 .. 0) := (0 => Empty_Partition);
					Primes : Sieve_Type := SievePrimes (N, K);
					IPrime : Integer := 0;
					NPrimePartition : Partition := (0 => N, others => -1);
					NPrimeList : Partition_Type (0 .. 0) := (0 => NPrimePartition);
				begin
					-- gets the lowest prime between K and N
					for I in Primes'Range loop
						if (Primes (I)) then
							IPrime := I;
							exit when True;
						end if;
					end loop;
					-- if no primes then return empty list
					if (IPrime = 0) then
						return Empty_Partition_Type;
					end if;
					-- if bad input then return empty list
					if ((N <= 1) or (N < K)) then
						return Empty_Partition_Type;
					-- if n is prime and first call with n as n
					elsif ((IsPrime (N)) and (J = 1)) then
						-- add the prime to the sub partitions returned concatenated with partitions using the same n concatenated with n
						return ConcatList ((ConcatList ((AddElemToAllLists ((PrimePartition ((N - IPrime), (IPrime + 1), 1)), IPrime)), (primePartition (N, (IPrime + 1), (J + 1))))), NPrimeList);
					else
						-- same as above but don't concat n
						return ConcatList ((AddElemToAllLists ((PrimePartition ((N - IPrime), (IPrime + 1), 1)), IPrime)), (primePartition (N, (IPrime + 1), (J + 1))));
					end if;
				end PrimePartition;

				-- prints a list of partitions in the desired format
				procedure PrintLL (LL : Partition_Type)
				is
				begin
					for I in LL'Range loop
						declare
							L : Partition := (LL (I));
						begin
							for J in L'Range loop
								if ((L (J)) = -1) then
									exit;
								else
									Ada.Text_IO.Put(Integer'Image (L (J)) & " ");
								end if;
							end loop;
						end;
						Ada.Text_IO.Put_Line("");
					end loop;
				end PrintLL;
				
				-- call to function
				F : Partition_Type := PrimePartition (N, 1, 1);
			begin
				PrintLL (F);
			end;
		end if;
	end loop;
end Prime;
