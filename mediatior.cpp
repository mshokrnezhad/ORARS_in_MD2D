// iot_pc_cha_d2a.cpp : Defines the entry point for the console application.
//
#include "iostream"
#include "fstream"
#include "iomanip"
#include "stdio.h"
#include "stdlib.h"
#include "time.h"
#include "math.h"
#include "vector"
#include "ctime"

using namespace std;

double distance(double x_i, double x_j, double y_i, double y_j)
{
	return sqrt(pow((x_i - x_j), 2) + pow((y_i - y_j), 2));
}

double h(double x_i, double x_next_node_j, double y_i, double y_next_node_j)
{
	if (distance(x_i, x_next_node_j, y_i, y_next_node_j) == 0)
		return 1;
	else
		return 0.09*pow(distance(x_i, x_next_node_j, y_i, y_next_node_j), -3);
}

int random_generator(int min, int max)
{
	int random_number;
	//srand(time(NULL));
	random_number = rand() % (1000 - 0) + 0;
	for (int i = 0; i<max - min + 1; i++)
		if (random_number >= ((1000 * i) / (max - min + 1)) && random_number <= ((1000 * (i + 1)) / (max - min + 1)))
			return i + min;
}

void print_progress_bar(int percent)
{
	string bar;
	cout << "\r" << bar;
	cout << percent << "% " << std::flush;
}

int func_next_node(int i, int n, int r, double x[], double y[])
{
	int temp_distance = 1000000;
	int n_n = 0;
	if (i == 0)
		return n_n;
	else
	{
		for (int j = 0; j < i; j++)
			if (i != j)
				if (distance(x[i], x[j], y[i], y[j]) <= r)
					if (distance(x[j], x[0], y[j], y[0]) <= temp_distance)
					{
						temp_distance = distance(x[j], x[0], y[j], y[0]);
						n_n = j;
					}
		return n_n;
	}
}

double func_get_max_index(double arr[], int size)
{
	int MaxIndex;
	double temp_max = 0;
	for (int i = 0; i<size; i++)
		if (arr[i]>temp_max)
		{
			temp_max = arr[i];
			MaxIndex = i;
		}

	return MaxIndex;
}

double func_get_min_index(double arr[], int size)
{
	int MinIndex;
	double temp_min = 1000000000000;
	for (int i = 0; i<size; i++)
		if (arr[i]<temp_min)
		{
			temp_min = arr[i];
			MinIndex = i;
		}

	return MinIndex;
}

double func_get_max(double arr[], int size)
{
	int MaxIndex;
	double temp_max = 0;
	for (int i = 0; i<size; i++)
		if (arr[i]>temp_max)
		{
			temp_max = arr[i];
			MaxIndex = i;
		}

	return temp_max;
}

double func_get_min(double arr[], int size)
{
	int MinIndex;
	double temp_min = 1000000000000;
	for (int i = 0; i<size; i++)
		if (arr[i]<temp_min)
		{
			temp_min = arr[i];
			MinIndex = i;
		}

	return temp_min;
}

double diff(double a, double b)
{
	if (a >= b)
		return a - b;
	else
		return b - a;
}

int main(int argc, char* argv[])
{
	int cm_n=atoi(argv[1]);
	int cm_no_specs=atoi(argv[2]);
	double cm_target_sinr=atof(argv[3]);
	double cm_cr=atof(argv[4]);
	double cm_dr=atof(argv[5]);
	double cm_noise=atof(argv[6]);
	double cm_max_power=atof(argv[7]);

	const int n = cm_n + 1;
	const int no_specs = cm_no_specs + 1;
	const int hop = 1;
	const int r = 1;

	int next_node[n];

	double x[n];
	double y[n];
	int temp_a = 0;
	double temp_b = 0;

	int start_s = clock();

	// writing set N to file
	ofstream file_set_N;
	file_set_N.open("I01_set_N.txt");
	for (int i = 1; i < n; i++)
	{
		file_set_N << i << "\n";
	}
	file_set_N.close();

	// writing set A to file
	ofstream file_set_A;
	file_set_A.open("I01_set_A.txt");
	for (int i = 1; i <= n; i++)
	{
		file_set_A << i << "\n";
	}
	file_set_A.close();

	// writing sir array to file
	ofstream file_sir;
	file_sir.open("I01_sir.txt");
	for (int i = 1; i < n; i++)
		file_sir << i << " " << cm_target_sinr << "\n";
	file_sir.close();

	// writing set K to file
	ofstream file_set_K;
	file_set_K.open("I01_set_K.txt");
	for (int i = 1; i < no_specs; i++)
	{
	file_set_K << i << "\n";
	}
	file_set_K.close();

	// writing BS to file
	ofstream file_NoD;
	file_NoD.open("I01_BS.txt");
	file_NoD <<"1 "<< n;
	file_NoD.close();

	// writing dr to file
	ofstream file_dr;
	file_dr.open("I01_dr.txt");
	file_dr <<"1 "<< cm_dr;
	file_dr.close();

	// writing cr to file
	ofstream file_cr;
	file_cr.open("I01_cr.txt");
	file_cr <<"1 "<< cm_cr;
	file_cr.close();

	// writing max_power to file
	ofstream file_mp;
	file_mp.open("I01_mp.txt");
	file_mp <<"1 "<< cm_max_power;
	file_mp.close();

	// writing noise to file
	ofstream file_noise;
	file_noise.open("I01_noise.txt");
	file_noise <<"1 "<< cm_noise;
	file_noise.close();
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	return 0;
}
