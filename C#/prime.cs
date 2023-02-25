using System;
using System.Linq;
using System.Collections.Generic;

class Prime {
	
	// returns true/false for if n is prime
	public static bool prime(int n) {
		if (n <= 1) {
			return false;
		}
		if (n == 2) {
			return true;
		} else {
			int k = 2;
			return primeRec(n, k);
		}
	}

	// recursive function for prime
	public static bool primeRec(int n, int k) {
		// if divisible then not prime
		if ((n % k) == 0) {
			return false;
		}
		// a limit to stop (correct limit would be sqrt(n))
		if ((n / 2) < k) {
			return true;
		// else check next divisor
		} else {
			return primeRec(n, k + 1);
		}
	}

	// implementation of sieve of erotosthanes
	// returns an array of truth values marking whether an index is prime
	public static bool[] sieve(int n) {
		// correct limit of sqrt(n)
		double lim = Math.Sqrt(Convert.ToDouble(n));
		int intLim = Convert.ToInt32(lim);
		int i = 2;
		bool[] bools = Enumerable.Repeat(true, n).ToArray();
		bools[0] = false;
		bools[1] = false;
		while (i < intLim) {
			if (bools[i] == true) {
				int j = i * i;
				while (j < n) {
					bools[j] = false;
					j = j + i;
				}
			}
			i = i + 1;
		}
		return bools;
	}
	
	// yields the next prime from k to n
	// IEnumberable allows for yielding
	public static IEnumerable<int> sievePrimes(int n, int k) {
		bool[] bools = sieve(n);
		while (k < n) {
			if (bools[k]) {
				yield return k;
			}
			k = k + 1;
		}
	}

	// yields the next prime partition as a LinkedList
	// IEnumberable allows for yielding
	public static IEnumerable<LinkedList<int>> primePartition(int n, int k) {
		// bad input then return nothing
		if (n <= 1 || n < k) {
			yield break;
		}
		// if prime yield n
		if (prime(n)) {
			LinkedList<int> lst = new LinkedList<int>();
			lst.AddFirst(n);
			yield return lst;
		}
		// iterate through the possible primes
		IEnumerable<int> primes = sievePrimes(n, k);
		foreach (var i in primes) {
			// iterate through the yielded partitions of subproblems
			IEnumerable<LinkedList<int>> partitions = primePartition(n - i, i + 1);
			foreach (var j in partitions) {
				// add the prime to the sub prime partition
				j.AddFirst(i);
				yield return j;
			}
		}
	}
	
	// simple implementation of a LinkedList printing function
	public static void printLinkedList(LinkedList<int> lst) {
		if (lst == null) {
			return;
		}
		if (lst.First == null) {
			return;
		}
		LinkedListNode<int> tmp = lst.First;
		while (tmp != null) {
			Console.Write(tmp.Value);
			Console.Write(" ");
			tmp = tmp.Next;
		}
		Console.Write("\n");
	}

	// REPL
	static void Main(string[] args) {
		int n = 1;
		while (true) {
			// catches improper input (at least strings)
			try {
				Console.WriteLine("Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit): ");
				n = Convert.ToInt32(Console.ReadLine());
			} catch (Exception e) {
				Console.WriteLine(e.Message);
				Console.WriteLine("You most likely didn't type a number, I asked for a number, please input a number... ");
				continue;
			}
			// terminates loop on 0
			if (n == 0) {
				break;
			// retries on negative
			} else if (n < 0) {
				Console.WriteLine("I thought I made it pretty clear that you need to enter a positive integer... ");
			// else call the function and iterate and print through yields
			} else {
				IEnumerable<LinkedList<int>> partitions = primePartition(n, 1);
				foreach (var i in partitions) {
					printLinkedList(i);
				}
			}
		}
	}

}
