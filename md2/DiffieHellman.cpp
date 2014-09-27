/*
	Nama: Rakina Zata Amni
	NPM: 1306398951
	Kelas: A
	Dosen: Bu Arlisa
	Asdos: Dinda Susanti
*/

#include <iostream>
#include <cstdio>
#include <cmath>
#include <string>
#include <cstring>
#include <algorithm>
using namespace std;

long long modpow(long long a, long long b, long long m){
	// algoritma pemangkatan modular, menghitung a^b mod m
	if (b == 0) return 1%m;
	long long tmp = modpow(a,b/2,m);
	if (b%2 == 0) return tmp*tmp%m;
	return ((tmp*tmp%m)*a)%m;
}

long long getSharedKey(long long a, long long B, long long p){
	/*
		shared key 	= g^(a.b) mod p
					= (g^a)^b mod p
					= (g^b)^a mod p
					= B^a mod p
	*/
	return modpow(B,a,p);
}

long long cryptaAnalysisDiffieHellman(long long p, long long g, long long A, long long B){
	for (long long x = 0; x < p; ++x){
		if (modpow(g,x,p) == A){
			// g^x ekivalen dengan A modulo p, maka sharedkeynya adalah g^(x.b) = B^x modulo p
			return modpow(B,x,p);
		}
	}
}

int main(){
	long long p,g,a,A,B,sharedKey;
	char s[505], baris[505];
	puts("TUGAS PEMROGRAMAN - DIFFIE HELLMAN");
	gets(baris);
	puts("Anda dan Bob akan menggunakan metode Diffie Hellman untuk mendapatkan sebuah shared key.");
	gets(baris);
	puts("Pertama-tama, Anda dan Bob akan menyepakati sebuah bilangan prima p dan bilangan bulat g");
	gets(baris);

	puts("Masukan bilangan prima p yang disepakati bersama");
	scanf("%lld",&p);
	puts("Masukan bilangan g yang disepakati bersama");
	scanf("%lld",&g);

	puts("Anda akan memilih sebuah bilangan bulat a, lalu akan menghitung public key A = g^a mod p");
	gets(baris);
	puts("Masukkan bilangan a");
	scanf("%lld",&a);
	A = modpow(g,a,p);
	printf("Berikut adalah public key anda (A): %lld\n",A);
	gets(baris);

	puts("Bob sudah memilih bilangan bulat b dan menghitung public key B = g^b mod p");
	gets(baris);
	puts("Bob sudah memberikan bilangannya ke anda. Masukkan bilangan yang diberikan Bob.");
	scanf("%lld",&B);

	sharedKey = getSharedKey(a,B,p);
	printf("Shared key Diffie Hellman kalian adalah: %lld\n",sharedKey);
	gets(baris);

	printf("Seorang eavesdropper mengetahui p = %lld, g = %lld, A = %lld, dan B = %lld\n",p,g,A,B);
	gets(baris);
	printf("Setelah melakukan cryptanalisis dia mendapatkan shared key anda adalah %lld\n",cryptaAnalysisDiffieHellman(p,g,A,B));

}