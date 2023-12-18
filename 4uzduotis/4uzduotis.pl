:- encoding(utf8).

/* Rosita Raišuotytė 4 kursas 1 grupe */

/*
Vandens perpylimo uždavinys.
Duotos trijų indų talpos, kurios visos yra skirtingos. Pirmasis indas pilnas vandens, kiti du tušti. 
Iš vieno indo į kitą galima perpilti lygiai tiek vandens, kiek telpa kitame inde arba lygiai tiek, kiek yra pirmajame (žiūrint, kuris dydis mažesnis). 
Pavyzdžiui, iš pilno 5 litrų indo į tuščią 3 litrų indą galima perpilti 3 litrus. 
Lygiai taip pat 3 litrus galima perpilti iš pilno 3 litrų indo į tuščią 5 litrų indą. 
Uždavinio rezultatas - vykdomų perpylimų seka. Nustatykite, kaip galima, perpilant vandenį iš vienų indų į kitus, gauti pirmajame inde tam tikrą vandens kiekį:

[S] vanduo perpilamas kas tam tikrą laiko tarpą. Per šį laiko tarpą iš kiekvieno indo išgaruoja tam tikras pastovus vandens kiekis
*/

% perpilti(PirmoIndoTuris, AntroTuris, TrečioTuris, PirmoIndoTikslas, Garavimas, EjimaiRezultatas)
perpilti(PimasIMax, AntrasIMax, TrečiasIMax, PirmoITikslas, Garavimas, Rezultatas):- 
    indai_pries_garavima((PimasIMax, 0, 0), PimasIMax, AntrasIMax, TrečiasIMax, PirmoITikslas, Garavimas, [], [(PimasIMax, 0, 0)], Veiksmai, Busenos), 
    apsukti_sarasa(Veiksmai, [], Rezultatas), 
    apsukti_sarasa(Busenos, [], BusenosRez),
    atspausdinti_atsakyma(Rezultatas, BusenosRez).

indai_pries_garavima(DabartineBusena, PimasIMax, AntrasIMax, TrečiasIMax, PirmoITikslas, Garavimas, Veiksmai, PereitosBusenos, VeiksmaiRez, BusenosRez):-
    isgaruoja(DabartineBusena, NugaravusiBusena, Garavimas),
    indai(NugaravusiBusena, PimasIMax, AntrasIMax, TrečiasIMax, PirmoITikslas, Garavimas, Veiksmai, PereitosBusenos, VeiksmaiRez, BusenosRez).

% indai(PirminėBusenaInduTuriu, PirmoIndoTuris, AntroTuris, TrečioTuris, PirmoIndoTikslas, Garavimas, VeiksmaiTarpiniai, VisosBuvusiosBusenos, GalutinisVeiksmuRinkinys, GalutinesPereitosBusenos)
indai((PirmoITikslas, _, _), _, _, _, PirmoITikslas, _, Veiksmai, PereitosBusenos, Veiksmai, PereitosBusenos):- !.
indai(NugaravusiBusena, PimasIMax, AntrasIMax, TrečiasIMax, PirmoITikslas, Garavimas, Veiksmai, PereitosBusenos, VeiksmaiRez, BusenosRez):-
    patikrinimas(NugaravusiBusena, PirmoITikslas),
    pilti(NugaravusiBusena, NaujaBusena, PimasIMax, AntrasIMax, TrečiasIMax, Ejimas),
    \+ member(NaujaBusena, PereitosBusenos),
    indai_pries_garavima(NaujaBusena, PimasIMax, AntrasIMax, TrečiasIMax, PirmoITikslas, Garavimas, [Ejimas|Veiksmai], [NaujaBusena|PereitosBusenos], VeiksmaiRez, BusenosRez).


% pilti(DabartineBusena, NaujaBusena, PimasIMax, AntrasIMax, TrečiasIMax, Ejimas)
pilti((I1, I2, I3), (I1New, I2New, I3), _, AntrasIMax, _, '1 -> 2'):-
    I2 =\= AntrasIMax, I1 =\= 0, I1New is max(I1 - (AntrasIMax-I2), 0), I2New is I1 - I1New + I2.

pilti((I1, I2, I3), (I1New, I2, I3New), _, _, TrečiasIMax, '1 -> 3'):-
    I3 =\= TrečiasIMax, I1 =\= 0, I1New is max(I1 - (TrečiasIMax-I3), 0), I3New is I1 - I1New + I3.

pilti((I1, I2, I3), (I1New, I2New, I3), PimasIMax, _, _, '2 -> 1'):-
    I1 =\= PimasIMax, I2 =\= 0, I2New is max(I2 - (PimasIMax-I1), 0), I1New is I2 - I2New + I1.

pilti((I1, I2, I3), (I1, I2New, I3New), _, _, TrečiasIMax, '2 -> 3'):-
    I3 =\= TrečiasIMax, I2 =\= 0, I2New is max(I2 - (TrečiasIMax-I3), 0), I3New is I2 - I2New + I3.

pilti((I1, I2, I3), (I1New, I2, I3New), PimasIMax, _, _, '3 -> 1'):-
    I1 =\= PimasIMax, I3 =\= 0, I3New is max(I3 - (PimasIMax-I1), 0), I1New is I3 - I3New + I1.

pilti((I1, I2, I3), (I1, I2New, I3New), _, AntrasIMax, _, '3 -> 2'):-
    I2 =\= AntrasIMax, I3 =\= 0, I3New is max(I3 - (AntrasIMax-I2), 0), I2New is I3 - I3New + I2.


isgaruoja((I1, I2, I3), (I1New, I2New, I3New), Garavimas):-
    I1New is max(I1-Garavimas, 0),
    I2New is max(I2-Garavimas, 0),
    I3New is max(I3-Garavimas, 0).

/*
isgaruoja((I1, I2, I3), (I1New, I2New, I3New), Garavimas):-
    I1New is max(I1-(I1*Garavimas/100), 0),
    I2New is max(I2-(I2*Garavimas/100), 0),
    I3New is max(I3-(I3*Garavimas/100), 0).
*/

patikrinimas((I1, I2, I3), PirmoITikslas):-
    Vanduo is I1+I2+I3,
    Vanduo >= PirmoITikslas.

apsukti_sarasa([], Apsuktas, Apsuktas):- !.
apsukti_sarasa([H|T], ApsuktasTarpinis, Apsuktas) :-
    apsukti_sarasa(T, [H|ApsuktasTarpinis], Apsuktas).

atspausdinti_atsakyma(Ejimai, [Pradine|Busenos]):-
    nl,
    write('Pradžia: '),
    write(Pradine),
    nl,
    spausdinti_sarasa(Ejimai, Busenos).

spausdinti_sarasa([], []):-
    write('Tikslas pasiektas!').
spausdinti_sarasa([Ejimas|Veiksmai], [Busena|Busenos]):-
    write(Ejimas),  
    write(':  '),
    write(Busena),
    nl,              
    spausdinti_sarasa(Veiksmai, Busenos).


/*

perpilti(5,3,2,1.5,0.5,R).

Pradžia: 5,0,0
1 -> 2:  1.5,3.0,0
1 -> 3:  0,2.5,1.0
2 -> 1:  2.0,0,0.5
Tikslas pasiektas!
R = ['1 -> 2', '1 -> 3', '2 -> 1'] ;

Pradžia: 5,0,0
1 -> 2:  1.5,3.0,0
1 -> 3:  0,2.5,1.0
3 -> 2:  0,2.5,0
2 -> 1:  2.0,0,0
Tikslas pasiektas!
R = ['1 -> 2', '1 -> 3', '3 -> 2', '2 -> 1'] ;

Pradžia: 5,0,0
1 -> 2:  1.5,3.0,0
2 -> 1:  3.5,0,0
1 -> 3:  1.0,0,2.0
3 -> 1:  2.0,0,0
Tikslas pasiektas!
R = ['1 -> 2', '2 -> 1', '1 -> 3', '3 -> 1'] ;

Pradžia: 5,0,0
1 -> 2:  1.5,3.0,0
2 -> 3:  1.0,0.5,2.0
3 -> 1:  2.0,0.0,0
Tikslas pasiektas!
R = ['1 -> 2', '2 -> 3', '3 -> 1'] ;

Pradžia: 5,0,0
1 -> 3:  2.5,0,2.0
1 -> 2:  0,2.0,1.5
3 -> 2:  0,2.5,0
2 -> 1:  2.0,0,0
Tikslas pasiektas!
R = ['1 -> 3', '1 -> 2', '3 -> 2', '2 -> 1'] ;

Pradžia: 5,0,0
1 -> 3:  2.5,0,2.0
3 -> 1:  3.5,0,0
1 -> 3:  1.0,0,2.0
3 -> 1:  2.0,0,0
Tikslas pasiektas!
R = ['1 -> 3', '3 -> 1', '1 -> 3', '3 -> 1'] ;

Pradžia: 5,0,0
1 -> 3:  2.5,0,2.0
3 -> 2:  2.0,1.5,0
Tikslas pasiektas!
R = ['1 -> 3', '3 -> 2'] ;
false.
*/