set N := {read "I01_set_N.txt" as "<1n>"};
set A := {read "I01_set_A.txt" as "<1n>"};
set K := {read "I01_set_K.txt" as "<1n>"};
set bs :={1};
param p_bar[bs] := read "I01_mp.txt" as "<1n>2n";
param M := 10000;
param gamma[N] := read "I01_sir.txt" as "<1n>2n";
param nu[bs] := read "I01_noise.txt" as "<1n>2n";
param xl[A] := read "I01_x.txt" as "<1n>2n";
param yl[A] := read "I01_y.txt" as "<1n>2n";
param BS[bs] := read "I01_BS.txt" as "<1n>2n";
param del[bs] := read "I01_dr.txt" as "<1n>2n";
param cap[bs] := read "I01_cr.txt" as "<1n>2n";
defnumb dist(a,b) := sqrt((xl[a]-xl[b])^2 + (yl[a]-yl[b])^2);
defnumb h(a,b) := if (a == b) then 1 else 0.09*(dist(a,b)^(-3)) end;

var p[N*K];
var x[N*K] binary;
var rn[N*A*N] binary;
var f1[N*K*A] binary;
var f2[N*A*N*N] binary;

minimize f: sum <n> in N: sum <k> in K: p[n,k];

subto c1: forall <n> in N: forall <k> in K: forall <m> in A: p[n,k] >= ((((sum <i> in N without {<n>}:p[i,k]*h(i,m))+nu[1])/h(n,m))*gamma[n])-(1-f1[n,k,m])*M;
subto c2: forall <n> in N: sum <k> in K: x[n,k] == 1;
subto c3: forall <n> in N: forall <m> in A: sum <z> in N: rn[n,m,z] <= 1;
subto c4: forall <n> in N: forall <z> in N: sum <m> in A: rn[n,m,z] <= 1;
subto c5: forall <n> in N: sum <m> in A without {<n>}: rn[n,m,1] == 1;
subto c7: forall <n> in N: sum <z> in N: rn[n,BS[1],z] == 1;
subto c8: forall <n> in N: forall <z> in N without {<1>}: (sum <m> in A: rn[n,m,z-1]) >= (sum <m> in A: rn[n,m,z]);
subto c9: forall <n> in N: forall <k> in K: forall <m> in A: f1[n,k,m] >= rn[n,m,1]*x[n,k];
subto c10: forall <n> in N: forall <m> in A: forall <z> in N without {<1>}: rn[n,m,z] <= (sum <bb> in N: rn[n,bb,z-1]*rn[bb,m,1]);
subto c11: forall <n> in N: (sum <m> in A: (sum <z> in N : rn[n,m,z])) <= del[1];
subto c12: forall <m> in N: sum <n> in N : rn[n,m,1] <= cap[1];
subto c13: forall <n> in N: forall <k> in K: p[n,k] >= 0;
subto c14: forall <n> in N: forall <k> in K: p[n,k] <= p_bar[1];
