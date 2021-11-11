#include <iostream>
 #include <time.h>
//#include "indexof.h"
 using namespace std;
 extern "C" int IndexOf(long n, long array[], unsigned count);
 int main() {
//Fill an array with pseudorandom integers.
const unsigned ARRAY_SIZE = 100000;
const unsigned LOOP_SIZE = 100000;
const char* boolstr[] = { "false","true" };

 long array[ARRAY_SIZE];
for (unsigned i = 0; i < ARRAY_SIZE; i++)
array[i] = rand();

 long searchVal;
time_t startTime, endTime;
cout << "Enter an integer value to find: ";
cin >> searchVal;
cout << "Please wait...\n";

 // Test the Assembly language function.
time(&startTime);
int count = 0;

 for (unsigned n = 0; n < LOOP_SIZE; n++)
count = IndexOf(searchVal, array, ARRAY_SIZE);

 bool found = count != -1;

 time(&endTime);
 cout << "Elapsed ASM time: " << long(endTime - startTime);
cout<< " seconds. Found = " << boolstr[found] << endl;

 return 0;

}
