# function returning the bool for whether n is prime, recursive
def prime(n):
    if n <= 1:
        return False
    if n == 2:
        return True
    else:
        k = 2
        return primeRec(n, k)

# recursive function for the prime(n) function
def primeRec(n, k):
    # if divisible then return not prime
    if (n % k) == 0:
        return False
    # sqrt(n) is the upper bound of numbers that can divide
    if (n**(1/2)) < k:
        return True
    # else check the next possible divisor
    else:
        return primeRec(n, k + 1)

# implementation of sieve of erotosthanes
# returns an array of bools marking whether an index is prime
def sieve(n):
    # largest number that can divide a number <= n
    lim = (n**(1/2))
    i = 2
    bools = [True] * (n + 1)
    bools[0] = False
    bools[1] = False
    while (i < lim):
        if (bools[i] == True):
            j = i**2
            while (j <= n):
                bools[j] = False
                j = j + i
        i = i + 1
    return bools

# yields the next prime from k to n
def sievePrimes(n, k):
    bools = sieve(n)
    while (k <= n):
        if bools[k]:
            yield k
        k = k + 1

# recursively yields the prime partitions as arrays
def primePartition(n, k):
    # not a good input
    if (n <= 1 or n < k):
        return
    # if n is prime then yield it
    if (prime(n)):
        yield [n]
    # iterate through possible primes
    for i in sievePrimes(n, k):
        # iterate through possible paritions
        for j in primePartition(n - i, i + 1):
            # add the prime to the partition it was subtracted from
            lst = [i]
            lst.extend(j)
            yield lst

# starts the call to primePartition(n, 1) and prints
def startPrimePartition(n):
    for i in primePartition(n, 1):
        print(i)

# REPL
def main():
    while True:
        print("Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit): ")
        # catches improper inputs (at least strings)
        try:
            n = int(input())
        except ValueError:
            print("Try again, an integer is a number if you didn't know...")
            continue;
        # stops loop
        if (n == 0):
            break;
        # negative integer
        elif (n < 0):
            print("Try again, a POSITIVE number this time... ")
        # result
        else:
            startPrimePartition(n)

if __name__ == "__main__":
    main()
