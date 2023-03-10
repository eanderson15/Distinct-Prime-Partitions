# Distinct Prime Partitions

BASIC RUN INSTRUCTIONS:
Ada: gnatmake prime.adb -> ./prime
C#: mcs prime.cs -> mono prime.exe
OCaml: ocaml prime.ml
Prolog: swipl prime.pl
Python: python3 prime.py


PROGRAM BREAKDOWNS:

Python:

	Functions:
		prime(n) - returns true/false for if n is prime
		primeRec(n, k) - recursive call for prime(n)
		sieve(n) - returns an array 0 to n of bools marking whether an index is prime
		sievePrimes(n, k) - yields the next prime from k to n
		primePartition(n, k) - recursively yields an array of integers as a prime partition
		startPrimePartition(n) - collects the yields of the primePartition(n, 1) call
		main() - REPL asking for an integer input, catches incorrect inputs

	Implementation:
		Uses iterators. REPL catches negative integers, and strings as improper input, and terminates on 0.
		Pretty good implementation I think, one enhancement would be to eliminate the call to prime(n) in the primePartition function,
		and instead maybe access the sieve. Runs automatically.

	Running:
		python3 prime.pl
		# runs automatically, then just enter integers, terminate with 0

C#:
	Functions:
		public static bool prime(int n) - returns true/false for if n is prime
		public static bool primeRec(int n, int k) - recursive call for prime
		public static bool[] sieve(int n) - returns an array 0 to n of bools marking whether an index is prime
		public static IEnumberable<int> sievePrimes(int n, int k) - yields the next prime from k to n
		public static IEnumberable<LinkedList<int>> primePartition(int n, int k) - recursively yields a LinkedList of integers as a prime partition
		public static void printLinkedList(LinkedList<int> lst) - prints the type of LinkedList that is produced in the format desired
		static void Main(string[] args) - REPL asking for integer input, catches incorrect input

	Implementation:
		Uses iterators. Essentially identical to Python. REPL catches negative integers and strings as improper input, and terminates on 0.
		Pretty good implementation I think, LinkedList is a little heavy for a data structure to use, could implement a basic one to shave off load.
		Could also eliminate the call to prime in the prime Partition function. Also, make the limit in the primeRec function to be sqrt(n).
		Runs automatically.

	Running:
		mcs prime.cs
		mono prime.exe
		// runs automatically, then just enter integers, terminate with 0

OCaml:
	Functions:
		rec PrimeRec x k - recursive function for prime
		prime x - returns whether x is prime
		rec primes n k - returns the list of primes between k and n
		rec listAdd i l - adds i to each list in the list l
		rec primePartition n k l j - compiles a list of prime partitions, l is used to pass the list of primes to the next call, j keeps track of
					     the number of times the function has been called with n as the n
		printlist l - prints a list in the desired format
		rec printll l - prints a list of lists in the desired format
		quit_loop = ref false in - REPL asking for integer input, catches incorrect integer input, will break on anything other than an integer

	Implementation:
		Fully functional (other than the REPL). REPL catches negative integers and terminates on 0, does not catch any other improper input.
		Pretty good implementation I think, the primePartition function could probably be bettered in terms of number of parameters, but it
		is fully functional and was fairly natural to implement that way which is cool. Runs automatically.

	Running:
		ocaml prime.ml
		(* runs automatically, then just enter integers, terminate with 0 *)

Ada:
	Functions:
		procedure Prime - REPL asking for integer input, catches incorrect integer input, will break on anything other than an integer
			function IsPrime (N : Integer) return Boolean - indicates whether N is prime or not
				function PrimeRec (N, K : Integer) return Boolean - recursive function for the prime function
			function Sieve (N : Integer) return Sieve_Type - returns an array of 0 to N indicating whether an index is prime or not
			function SievePrimes (N, K : Integer) return Sieve_Type - returns an array of 0 to N indicating whether an index is a prime between
										  K and N
			function AddElemToAllLists (LL : Partition_Type; I : Integer) return Partition_Type - adds I to all the lists in a list and returns
			function AddElemToFront (L : Partition; I : Integer) return Partition - adds I to the list (Partition is an array of 0 .. N)
			function ConcatList (LL1, LL2 : Partition_Type) return Partition_Type - concatenates the two lists and returns
			function PrimePartition (N, K, J : Integer) return Partition_Type - compiles a list of lists containing the prime partitions as lists
			procedure PrintLL (LL : Partition_Type) - prints the list of lists in the desired format

	Implementation:
		Based on the same pseudocode as the implementation for OCaml. REPL catches negative integers and terminates on 0, does not catch any other
		improper input. A mix of iteration and recursion, in principle it would be simpler because of the use of iteration. However, because of 
		Ada's strict arrays the implementation quickly became difficult and messy. Probably, would be better to implement with iterators.
		Another enhancement would be the change of the limits to sqrt(n) in the prime finding functions.

	Running:
		gnatmake prime.adb
		./prime
		-- runs automatically, then just enter integers, terminate with 0

Prolog:
	Functions:
		prime(X) - returns whether X is prime
		primeRec(X, N) - recursive function for prime(X)
		primes(N, K) - starts the recursive function primesRec (I actually dont think this is needed)
		primesRec(N, K, I) - used to generate the primes and iterate through backtracking
		primePartition(N, I) - generates next values to call check on and print the current prime I if needed
		primePartitionConditions(N, K) - checks the conditions and then prints N if prime and calls the next call to primes(N, K)
		main(N) - calls primePartitionConditions(N, 1), for ease of use of program

	Implementation:
		Very elegant. Based on the Python implementation with iterators, just a matter of figuring out how backtracking worked.
		No REPL, ran by calling main(N) and no checks on improper inputs. Partitions are printed by using ';' prompts.
		Could be improved by using the sieve of erotosthanes

	Running:
		swipl prime.pl
		main(N).
		% call main with any positive integer N, prompt partitions with semicolon


OUTPUT EXAMPLES:

Ada:

./prime
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
-1
Try again, I did say positive didn't I...
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
24
 2  3  19
 2  5  17
 5  19
 7  17
 11  13
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
0

C#:

mono prime.exe
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
-1
I thought I made it pretty clear that you need to enter a positive integer...
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
a
Input string was not in a correct format.
You most likely didn't type a number, I asked for a number, please input a number...
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
24
2 3 19
2 5 17
5 19
7 17
11 13
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
0

OCaml:

ocaml prime.ml
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
-1
POSITIVE number much...
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
24
2 3 19
2 5 17
5 19
7 17
11 13
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
0

Prolog:

swipl prime.pl
Welcome to SWI-Prolog (threaded, 64 bits, version 8.2.3)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit https://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- main(24).
19 3 2
true ;
17 5 2
true ;
19 5
true ;
17 7
true ;
13 11
true ;
false.

?- ^C
Action (h for help) ? exit (status 4)

Python:

python3 prime.py
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
-1
Try again, a POSITIVE number this time...
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
a
Try again, an integer is a number if you didn't know...
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
24
[2, 3, 19]
[2, 5, 17]
[5, 19]
[7, 17]
[11, 13]
Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit):
0
