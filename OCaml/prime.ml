(* recursive function for prime *)
let rec primeRec x k =
        match x with
        (* if divisible then not prime *)
        | x when ((x mod k) == 0) -> false
        (* if pass limit of n/2 then prime *)
        | x when ((x / 2) < k) -> true
        (* else check next divisor *)
        | _ -> primeRec x (k + 1)

(* returns whether x is prime *)
let prime x =
        match x with
        | x when (x <= 1) -> false
        | x when (x == 2) -> true
        | _ -> primeRec x 2;;

(* returns the list of primes between k and n *)
let rec primes n k =
        match n with
        | 0 -> []
        | 1 -> []
        | _ when (n < k) -> []
        (* add n to list *)
        | _ when (prime n) -> (primes (n - 1) k) @ [n]
        (* dont add n to list *)
        | _ -> (primes (n - 1) k);;

(* function to add i to each list in the list l *)
let rec listAdd i l =
        match l with
        | [] -> []
        | [[]] -> []
        | h :: t -> (i :: h) :: (listAdd i t);;

(* function to recursively compile a list of prime partitions (each one contained in a list *)
let rec primePartition n k l j =
        match l with
        | [] -> []
        | _ when (n <= 1) -> []
        | _ when (n < k) -> []
        (* when n is prime and first call with n, add the prime h to the front of the sub prime partition list concated with the prime partitions using other primes concated with n *)
        | h :: t when ((prime n) && (j == 1)) -> (listAdd h (primePartition (n - h) (h + 1) (primes (n - h) (h + 1)) 1)) @ (primePartition n k t (j + 1)) @ [[n]]
        (* same as above but dont concat n to the end because it already will be or it is not prime *)
        | h :: t -> (listAdd h (primePartition (n - h) (h + 1) (primes (n - h) (h + 1)) 1)) @ (primePartition n k t (j + 1));;

(* function to print a list *)
let printlist l =
        List.iter (Printf.printf "%d ") l;;

(* prints a list of lists in the desire format *)
let rec printll l =
        match l with
        | [] -> Printf.printf ""
        | h :: t -> (printlist h); Printf.printf("\n"); (printll t);;

(* REPL - imperative *)
let quit_loop = ref false in
        while not !quit_loop do
                Printf.printf "Please enter a positive integer N for which you would like the distinct prime partitions (0 to quit): \n";
                let n = read_int() in
                        (* break loop on 0 *)
                        if (n = 0) then quit_loop := true else
                                (* try again on negative *)
                                if (n < 0) then Printf.printf "POSITIVE number much... \n" else
                                        (* else do the thing *)
                                        printll (primePartition n 1 (primes n 1) 1);
        done;;
