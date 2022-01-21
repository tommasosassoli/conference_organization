% constant
int: NSESSIONS;
int: NPEOPLE;
int: NROOMS;
int: NDAYS;
int: CAPACITY;
int: MAX_SESSIONS_PER_PERSON;

% array dimensions
set of int: sessions = 1..NSESSIONS;
set of int: people = 1..NPEOPLE;
set of int: days = 1..NDAYS;
set of int: rooms = 1..(NROOMS);

% array declaration
array [people, sessions] of bool: pxs;
array [people, sessions, days] of var bool: org;
array [days, sessions] of var int: n_of_partecipants;
array [days, sessions] of var int: room_dimensions;

% asserts
constraint assert( CAPACITY mod 2 == 0, "Capacity of rooms must be even.");

constraint assert( forall (p in people) (
                      count (s in sessions) (pxs[p,s]) <= 3), "Each person can attend at most \(MAX_SESSIONS_PER_PERSON) session(s).");


% constraints on org[p,s,d]
constraint forall (d in days) (
             forall (s in sessions) (
               count (p in people) (org[p,s,d]) <= CAPACITY
             ));

constraint forall (d in days) (
             sum (s in sessions) (
               sum (p in people) (org[p,s,d])
             ) <= NROOMS * CAPACITY
           );

constraint forall (d in days) (
             forall (p in people) (
               sum (s in sessions) (org[p,s,d]) <= 1
             ));

constraint forall (p in people) (
             forall (s in sessions) (
               count (d in days) (org[p,s,d]) == pxs[p,s]
             ));

% constraint on room_dimensions[d,s]
constraint forall (d in days) (
               forall (s in sessions) (
                 n_of_partecipants[d,s] = sum (p in people) (org[p,s,d])
               ));

constraint forall (d in days) (
               forall (s in sessions) (
                 if n_of_partecipants[d,s] == 0 then
                   room_dimensions[d,s] = 0
                 elseif n_of_partecipants[d,s] <= (CAPACITY / 2) then
                   room_dimensions[d,s] = 1
                 else
                   room_dimensions[d,s] = 2
                 endif
               ));


solve satisfy;


output ["\nDimensione Stanze:\n"];

output [ "\n" ] ++
       [ if fix(room_dimensions[d,s] == 1) then 
           "\n" ++ show("Giorno: \(d), Sessione: \(s), N.Partecipanti:\(n), Stanza Piccola")
         elseif fix(room_dimensions[d,s] == 2) then
           "\n" ++ show("Giorno: \(d), Sessione: \(s), N.Partecipanti:\(n), Stanza Grande")
         else 
           " "
         endif |
         d in days, s in sessions, n = n_of_partecipants[d,s] ];


output [ "\n\nLista partecipanti" ];

output [ "\n" ] ++
       [ if fix(org[k,j,i]) then 
           "\n" ++ show("Giorno: \(i), Sessione: \(j), Partecipante: \(k)")
         else 
           " "
         endif |
         i in days, j in sessions, k in people ];
