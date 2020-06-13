#!/bin/bash

g++ -g mediatior.cpp -o med.out

dr=100;
cr=100;
tsir=0.01;
max_power=10000;
noise=1;

for k in `seq 2 3`;
do
     	for n in `seq 9 10`;
	do	
		echo "k=$k,n=$n" >> R03_opt_SoP.txt
		echo "k=$k,n=$n" >> R03_opt_solti.txt

		for itr in `seq 1 1`;
		do	
			echo "k=$k,n=$n,iteration=$itr"	
			#sleep 1
			
			if [ $itr -eq 50 ]
			then
				sed -n "/^n=$n,iteration=50/,/^n=$(($n + 1)),iteration=1/p" R01_LoN.txt | awk '/^x/'|sed 's/x\[0\] = 5000;//g'|sed '/^\s*$/d'|sed 's/;//g'|sed 's/x//g'|sed 's/ = / /g'|sed 's/\[//g'|sed 's/\]//g'>I01_x.txt
				echo "$(($n + 1)) 5000" >> I01_x.txt
				sed -n "/^n=$n,iteration=50/,/^n=$(($n + 1)),iteration=1/p" R01_LoN.txt | awk '/^y/'|sed 's/y\[0\] = 5000;//g'|sed '/^\s*$/d'|sed 's/;//g'|sed 's/y//g'|sed 's/ = / /g'|sed 's/\[//g'|sed 's/\]//g'>I01_y.txt
				echo "$(($n + 1)) 5000" >> I01_y.txt
			else
				sed -n "/^n=$n,iteration=$itr$/,/^n=$n,iteration=$(($itr + 1))$/p" R01_LoN.txt | awk '/^x/'|sed 's/x\[0\] = 5000;//g'|sed '/^\s*$/d'|sed 's/;//g'|sed 's/x//g'|sed 's/ = / /g'|sed 's/\[//g'|sed 's/\]//g'>I01_x.txt
			echo "$(($n + 1)) 5000" >> I01_x.txt
				sed -n "/^n=$n,iteration=$itr$/,/^n=$n,iteration=$(($itr + 1))$/p" R01_LoN.txt | awk '/^y/'|sed 's/y\[0\] = 5000;//g'|sed '/^\s*$/d'|sed 's/;//g'|sed 's/y//g'|sed 's/ = / /g'|sed 's/\[//g'|sed 's/\]//g'>I01_y.txt
			echo "$(($n + 1)) 5000" >> I01_y.txt
			fi
		
			./med.out $n $k $tsir $cr $dr $noise $max_power
		
			./scip.spx -f opt.zpl  | tee log.out 
			grep "^Solving Time (sec)" log.out | awk '{print $5}' >> R03_opt_solti.txt
			grep "^objective value:" log.out | awk '{print $3}' >> R03_opt_SoP.txt

			rm I01_set_A.txt
			rm I01_set_N.txt
			rm I01_set_K.txt
			rm I01_BS.txt
			rm I01_sir.txt
			rm I01_x.txt
			rm I01_y.txt
			rm log.out
			rm I01_cr.txt
			rm I01_dr.txt
			rm I01_mp.txt
			rm I01_noise.txt
		done 
	done    
done 

rm med.out
