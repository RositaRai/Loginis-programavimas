:- encoding(utf8).

/* Rosita Raišuotytė 4 kursas 1 grupe */
/* Variantai: 1.2*/

/*
1. galima nuvažiuoti iš miesto X į miestą Y.
1.2. nuvažiavus lygiai L kilometrų.
*/

/*
kelias(Miestas1, Miestas2, Atstumas).
*/

kelias(plunge, rietavas, 30).
kelias(plunge, klaipeda, 60).
kelias(plunge, telsiai, 20).
kelias(telsiai, siauliai, 70).
kelias(siauliai, panevezys, 80).
kelias(panevezys, vilnius, 140).
kelias(rietavas, kaunas, 170).
kelias(kaunas, vilnius, 100).
kelias(klaipeda, vilnius, 310).
kelias(plunge, kaunas, 200).


kelione(Miestas1, Miestas2, Atstumas) :- kelias(Miestas1, Miestas2, Atstumas).
kelione(Miestas1, Miestas2, Atstumas) :- kelias(Miestas1, Miestas11, Atstumas1), kelione(Miestas11, Miestas2, Atstumas2), Atstumas is Atstumas1 + Atstumas2.


/*
kelione(plunge, vilnius, 310). true
kelione(plunge, vilnius, 300). true
kelione(plunge, telsiai, 20). true
kelione(plunge, kaunas, 200). true
kelione(plunge, vilnius, 100). false

kelione(Miestas1, Miestas2, 90).
    Miestas1 = plunge ,
    Miestas2 = siauliai ;
    false.

kelione(plunge, Miestas, 300).
    Miestas = vilnius ;
    Miestas = vilnius ;
    false.

kelione(plunge, vilnius, Atstumas).
    Atstumas = 300 ;
    Atstumas = 370 ;
    Atstumas = 310 ;
    Atstumas = 300 ;
    false.
*/


/*
5.1 daugyba 
*/ 


daugyba(0, _, 0).
daugyba(_, 0, 0).
daugyba(X, Y, Sandauga) :- Y > 0,  Y0 is Y-1, daugyba(X, Y0, Sandauga0), Sandauga is Sandauga0 + X.
daugyba(X, Y, Sandauga) :- Y < 0,  Y0 is Y+1, daugyba(X, Y0, Sandauga0), Sandauga is Sandauga0 - X.

/*
daugyba(0, 2, Sandauga).
    Sandauga = 0.
daugyba(2, 0, Sandauga).
    Sandauga = 0.
daugyba(2, 4, Sandauga).
    Sandauga = 8.
daugyba(-2, 2, Sandauga).
    Sandauga = -4.
daugyba(-2, -2, Sandauga).
    Sandauga = 4.
daugyba(2, -2, Sandauga).
    Sandauga = -4.

daugyba(2, -2, -4).
    true ;
    false.

*/