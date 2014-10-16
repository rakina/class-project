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
long long p,g,a,A,B,sharedKey;
char s[505];

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
	puts("Memulai proses cryptanalysis....");
	for (long long x = 0; x < p; ++x){
		if (modpow(g,x,p) == A){
			printf("Ditemukan bawa g^%lld mod P = A mod P. \n",x);
			printf("Maka shared key =  B^%lld mod P = %lld. \n",x,modpow(B,x,p));
			// g^x ekivalen dengan A modulo p, maka sharedkeynya adalah g^(x.b) = B^x modulo p
			return modpow(B,x,p);
		}
	}
}

int main(){

	puts("TUGAS PEMROGRAMAN - DIFFIE HELLMAN");
	puts("-----------------------------------");
	puts("Pastikan anda sudah membaca laporan/penjelasan Algoritma Diffie Hellman sebelum melanjutkan.");
	cout << "Tekan Enter untuk melanjutkan program...";
	cin.ignore();
	puts("Masukkan bilangan prima p yang disepakati bersama");
	scanf("%lld",&p); cin.ignore();
	puts("Masukkan bilangan g yang disepakati bersama");
	scanf("%lld",&g); cin.ignore();
	puts("Masukkan bilangan rahasia anda (a)");
	scanf("%lld",&a); cin.ignore();
	A = modpow(g,a,p);
	printf("Berikut adalah public key anda (A): %lld\n",A);

	puts("Masukkan bilangan B yang diberikan Bob.");
	scanf("%lld",&B);  cin.ignore();

	sharedKey = getSharedKey(a,B,p);
	printf("Shared key Diffie Hellman kalian adalah: %lld\n",sharedKey);
	puts("");
	cout << "Tekan Enter untuk melanjutkan program...";
	cin.ignore();
	puts("-----------------------------------");
	puts("");
	printf("Seorang eavesdropper mengetahui p = %lld, g = %lld, A = %lld, dan B = %lld\n",p,g,A,B);
	long long hasilCryptanalysis = cryptaAnalysisDiffieHellman(p,g,A,B);
	printf("Setelah melakukan cryptanalysis dia mendapatkan shared key anda adalah %lld\n",hasilCryptanalysis);
	cout << "Tekan Enter untuk menutup program.";
	cin.ignore();
}