:- encoding(utf8).

/* Rosita Raišuotytė 4 kursas 1 grupe */
/* Variantai: 1.6, 2.8, 3.7, 4.6*/

/*
1. Paprasti predikatai su sveikųjų skaičių sąrašais:
	1.6 min(S,M) - skaičius M - mažiausias skaičių sąrašo S elementas. 
	Pavyzdžiui:
		?- min([4,10,-2,-1],M).
		M = -2.
*/

min([X|Tail], Minimum):- minimum(Tail, Minimum, X), !.

minimum([], CurrentValue, CurrentValue).
minimum([X|Tail], Minimum, CurrentValue):- X < CurrentValue, minimum(Tail, Minimum, X).
minimum([_|Tail], Minimum, CurrentValue):- minimum(Tail, Minimum, CurrentValue).

/*
min([4,10,-2,-1],M). M=-2.
min([-1,-2,-2,-1],M). M=-2.
min([0,5,9,1,6,2],M). M=0.
*/

/*
2. Paprasti nearitmetiniai predikatai:
	2.8 i_pozicija(S,I,K,R) - sąrašas R gautas į duotąjį sąrašą S, prieš I-ąjį elementą įterpus K. 
	Pavyzdžiui:
		?- i_pozicija([10,2,14,8,1],3,123,R).
		R = [10,2,123,14,8,1].
*/

i_pozicija(S, 1, K, [K|S]):- !.
i_pozicija([S|SS], I, K, [S|R1]):- I > 1, I1 is I-1, i_pozicija(SS, I1, K, R1).

/*
i_pozicija([10,2,14,8,1],3,123,R). R = [10, 2, 123, 14, 8, 1].
i_pozicija([10,2,14,8,1],1,123,R). R = [123, 10, 2, 14, 8, 1].
i_pozicija([10,2,14,8,1],6,123,R). R = [10, 2, 14, 8, 1, 123].
i_pozicija([10,2,14,8,1],7,123,R). fail.
i_pozicija([10,2,14,8,1],-1,123,R). fail.
i_pozicija([],1,123,R). R = [123].
*/

/*
3. Sudėtingesni predikatai:
	3.7 keisti(S,K,R) - duotas sąrašas S. Duotas sąrašas K, nusakantis keitinį ir susidedantis iš 
	elementų pavidalo k(KeiciamasSimbolis, PakeistasSimbolis). 
	R - rezultatas, gautas pritaikius sąrašui S keitinį K. 
	Pavyzdžiui:
		?- keisti([a,c,b],[k(a,x),k(b,y)],R).
		R = [x,c,y].
*/

keisti([], _, []).
keisti([S|SS], K, [E|R]):- keisti(SS, K, R), keitimas(S, K, E), !.

/* keitimas(elementas kuriam ieškom ar turi keitini, keitiniu sarasas, koks elementas atsirado ar liko) */
keitimas(S, [], S).	 								/* neradom keitinio */ 
keitimas(S, [k(S,Y)|_], Y).							/* radom keitini */
keitimas(S, [k(_,_)|KK], R):- keitimas(S, KK, R).	/* sukam cikla per keitiniu sarasa ieškodami keitinio */


/*
keisti([a,c,b],[k(a,x),k(b,y)],R). R = [x,c,y].
keisti([a,c,b],[],R). R = [a, c, b].
keisti([],[k(a,x),k(b,y)],R). R = [].
*/

/*
4. Operacijos su natūraliaisiais skaičiais, išreikštais skaitmenų sąrašais. 
Skaitmenų sąrašo elementai turi būti natūralūs skaičiai nuo 0 iki 9 (ne simboliai '0', '1',...). 
Nenaudokite Prolog konvertavimo tarp sąrašo ir skaičiaus predikatų (number_chars/2, number_codes/2 ir kt...):
	4.6 sesiolik_i_devejet(Ses,Dvej) - Ses yra skaičius vaizduojami šešioliktainių skaitmenų sąrašu. 
	Dvej - tas pats skaičiaus, vaizduojamas dvejetainių skaitmenų sąrašu. 
	Pavyzdžiui:
		?- sesiolik_i_devejet([2, d],Dvej).
		Dvej = [1,0,1,1,0,1].
*/

ses(a, 10).
ses(b, 11).
ses(c, 12).
ses(d, 13).
ses(e, 14).
ses(f, 15).

sesiolik_i_devejet(S, D):- konvert(S, Dvej), !, naikinti(Dvej, D).

konvert([], []).
konvert([S|SS], Rez):- ses(S, R), konvert(SS, DD), konv_viena_el(R, D, 3), sujungti(D, DD, Rez).
konvert([S|SS], Rez):- konvert(SS, DD), konv_viena_el(S, D, 3), sujungti(D, DD, Rez).

konv_viena_el(_, [], -1).
konv_viena_el(S, [1|Dvej], L):- 2**L =< S, L1 is L-1, S1 is S - 2**L, konv_viena_el(S1, Dvej, L1).
konv_viena_el(S, [0|Dvej], L):- 2**L > S, L1 is L-1, konv_viena_el(S, Dvej, L1).

sujungti([], S2, S2).
sujungti([S1|SS1], S2, [S1|R1]):- sujungti(SS1, S2, R1).

naikinti([0], [0]):- !.
naikinti([0|S], R):- naikinti(S, R).
naikinti([1|S], [1|S]).
naikinti([], []).

/*
sesiolik_i_devejet([2, d],Dvej). Dvej = [1, 0, 1, 1, 0, 1].
sesiolik_i_devejet([f, d],Dvej). Dvej = [1, 1, 1, 1, 1, 1, 0, 1].
sesiolik_i_devejet([1, 5],Dvej). Dvej = [1, 0, 1, 0, 1].
sesiolik_i_devejet([],Dvej). Dvej = [].
sesiolik_i_devejet([0],Dvej). Dvej = [0].
*/