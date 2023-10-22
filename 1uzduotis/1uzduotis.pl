:- encoding(utf8).

/* Rosita Raišuotytė 4 kursas 1 grupe */
/* Variantai: 1; 16; 35; 44*/

/* asmuo(Vardas, Lytis, Amžius, Pomėgis)*/

asmuo(jonas, vyras, 78, zvejyba).
asmuo(joana, moteris, 69, mezgimas).

asmuo(petrina, moteris, 40, tapyba).
asmuo(kazys, vyras, 45, medziokle).

asmuo(karolis, vyras, 49, megsta-limonada).

asmuo(kotryna, moteris, 51, mezgimas).
asmuo(petras, vyras, 55, sportas).

asmuo(elijus, vyras, 16, megsta-limonada).
asmuo(elizabeta, moteris, 15, megsta-limonada).
asmuo(elonas, vyras, 14, sportas).

asmuo(danas, vyras, 22, megsta-limonada).
asmuo(danielius, vyras, 17, zvejyba).

asmuo(donatas, vyras, 32, sportas).
asmuo(gabriele, moteris, 33, sportas).

asmuo(gintaras, vyras, 14, megsta-limonada).
asmuo(goda, moteris, 13, tapyba).
asmuo(gedas, vyras, 12, megsta-limonada).


/* mama(Mama, Vaikas) */

mama(joana, kazys).
mama(joana, karolis).
mama(joana, kotryna).

mama(petrina, elijus).
mama(petrina, elizabeta).
mama(petrina, elonas).

mama(kotryna, danas).
mama(kotryna, danielius).
mama(kotryna, donatas).

mama(gabriele, gintaras).
mama(gabriele, goda).
mama(gabriele, gedas).


/* pora(Vyras, Žmona) */

pora(jonas, joana).
pora(kazys, petrina).
pora(petras, kotryna).
pora(donatas, gabriele).


/* 1. tevas(Tevas, Vaikas) - Pirmasis asmuo (Tevas) yra antrojo (Vaikas) tėvas */

tevas(Tevas, Vaikas) :- pora(Tevas, Mama), mama(Mama, Vaikas).

/*
tevas(Tevas, Vaikas) :- mama(Mama, Vaikas), pora(Tevas, Mama).
*/

/*
tevas(jonas, karolis). true
tevas(jonas, petrina). false
tevas(kazys, goda). false
tevas(kazys, elonas). true
tevas(petras, donatas). true
tevas(petras, gintaras). false
*/


/* 16. anukas(Anukas, SenelisSenele) - Pirmasis asmuo (Anukas) yra antrojo (SenelisSenele) anūkas (bet ne anūkė!) */

vienas_is_tevu(MamaTevas, Vaikas) :- mama(MamaTevas, Vaikas).
vienas_is_tevu(MamaTevas, Vaikas) :- mama(Mama, Vaikas), pora(MamaTevas, Mama).


/*
vienas_is_tevu(MamaTevas, Vaikas) :- tevas(MamaTevas, Vaikas).
*/


anukas(Anukas, SenelisSenele) :- asmuo(Anukas, vyras, _, _), vienas_is_tevu(MamaTevas1, Anukas), vienas_is_tevu(SenelisSenele, MamaTevas1).

/*
anukas(Anukas, SenelisSenele) :- asmuo(Anukas, vyras, _, _), mama(Mama1, Anukas), mama(SenelisSenele, Mama1).
anukas(Anukas, SenelisSenele) :- asmuo(Anukas, vyras, _, _), mama(Mama1, Anukas), tevas(SenelisSenele, Mama1).
anukas(Anukas, SenelisSenele) :- asmuo(Anukas, vyras, _, _), tevas(Mama1, Anukas), mama(SenelisSenele, Mama1).
anukas(Anukas, SenelisSenele) :- asmuo(Anukas, vyras, _, _), tevas(Mama1, Anukas), tevas(SenelisSenele, Mama1).
*/


/*
anukas(elijus, jonas). true
anukas(elijus, joana). true
anukas(elizabeta, jonas). false
anukas(elijus, kazys). false
anukas(gedas, petras). true
anukas(gedas, jonas). false
anukas(gintaras, kontryna). true
anukas(gintaras, gabriele). false
anukas(goda, petras). false
anukas(danas, jonas). true
anukas(elijus, SenelisSenele).
*/

/* 35. tmbml(Berniukas1, Berniukas2, Berniukas3) - „Trys maži berniukai - Berniukas1, Berniukas2 ir Berniukas3 - mėgsta limonadą“ (kas yra „maži“, nuspręskite patys) */

tmbml(Berniukas1, Berniukas2, Berniukas3) :- 
    asmuo(Berniukas1, vyras, Amzius1, megsta-limonada),
    asmuo(Berniukas2, vyras, Amzius2, megsta-limonada),
    asmuo(Berniukas3, vyras, Amzius3, megsta-limonada),
    Amzius1 =< 16, Amzius2 =< 16, Amzius3 =< 16,
    Berniukas1 \= Berniukas2, Berniukas1 \= Berniukas3, Berniukas2 \= Berniukas3.

/*
tmbml(elijus, elizabeta, gintaras). false - elizabeta ne berniukas
tmbml(elijus, elonas, gedas). false - elonas nemegsta limonado
tmbml(elijus, karolis, gedas). false - karolis per senas
tmbml(elijus, gintaras, gedas). true
*/

/* 44. at_suk(Asmuo, N) - Asmuo Asmuo atšventė N apvalių sukakčių */

at_suk(Asmuo, N) :- 
    N > 0,
    asmuo(Asmuo, _, Amzius, _),
    Amzius >= (N * 10).

/*
at_suk(goda, 1). true
at_suk(goda, 2). false
at_suk(karolis, 3). true
*/

at_psk_suk(Asmuo, N) :-
    N > 0,
    asmuo(Asmuo, _, Amzius, _),
    Amzius mod (N * 10) < 10.

/*
at_psk_suk(goda, 1). true
at_psk_suk(goda, 2). false
at_psk_suk(karolis, 3). false
at_psk_suk(karolis, 4). true
at_psk_suk(karolis, 5). false
*/