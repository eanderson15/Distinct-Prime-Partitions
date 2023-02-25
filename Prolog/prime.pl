% returns whether X is prime 
prime(2).
prime(3).
prime(X) :- X > 3, X mod 2 =\= 0, primeRec(X, 3).

% recursive function for prime(X)
% checks limit, then checks if divisible, and then checks next divisor
primeRec(X, N) :- N*N > X, ! ; X mod N =\= 0, M is N + 2, primeRec(X, M).

% calls primesRec
primes(N, K) :- primesRec(N, K, K).

% generates and iterates through primes
% checks if improper input, then checks if I is prime, if not then checks next one
% iterates by calling primePartition every time a prime is found
primesRec(N, K, I) :- (N >= I), ((prime(I), primePartition(N, I)) ; M is I + 1, primesRec(N, K, M)).

% generates next values for next call, if next call writes anything then add the current prime to the sub partition by writing it
primePartition(N, I) :- (M is N - I, J is I + 1, (primePartitionConditions(M, J) , write(I), write(" "))).

% checks conditions and then writes N if true (yielding), and then calls the next call
primePartitionConditions(N, K) :- ((N > 1) , (N >= K)) , (((prime(N)) , write(N), write(" ")); (primes(N, K))).

% for ease of use of program
main(N) :- primePartitionConditions(N, 1).
