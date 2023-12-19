/*
Kuprinės uždavinys.
Duoti akmenų svoriai, duotas kuprinių talpų sąrašas. Nustatykite, kaip galima sutalpinti visus akmenis į kuprines (kuprinės gali likti ir ne pilnai užpildytos)
*/

talpinti(AkmenuSvoriai, KupriniuTalpos, Rezultatas):-
    sukurti_kuprines(KupriniuTalpos, TusciosKuprines),
    sutalpinti(AkmenuSvoriai, KupriniuTalpos, TusciosKuprines, Rezultatas).
    
/*
talpinti([1,2,3], [3,3], Rez).
Rez = [[2, 1], [3]] ;
Rez = [[3], [2, 1]] ;
false.
*/

sutalpinti([], _, KuprinesSuAkmenim, KuprinesSuAkmenim).
sutalpinti([Akmuo|Akmenys], KuprinesTuriai, KuprinesSuAkmenim, PilnosKuprines):-
    deti_akmeni(Akmuo, KuprinesTuriai, KuprinesSuAkmenim, 1, KuprinesSuAkmenimNauja, NaujiKupriniuTuriai),
    sutalpinti(Akmenys, NaujiKupriniuTuriai, KuprinesSuAkmenimNauja, PilnosKuprines).

deti_akmeni(Akmuo, [Kuprine|Kuprines], KuprinesSuAkmenim, KurpinesNr, KuprinesSuAkmenimNauja, [Kuprine1|Kuprines]):-
    Akmuo =< Kuprine, 
    Kuprine1 is Kuprine - Akmuo,
    prideti_akmeni_prie_kuprines(Akmuo, KuprinesSuAkmenim, KurpinesNr, KuprinesSuAkmenimNauja).
deti_akmeni(Akmuo, [Kuprine|Kuprines], KuprinesSuAkmenim, KuprinesNr, KuprinesSuAkmenimNauja, [Kuprine|NaujiKupriniuSvoriai]):-
    KuprinesNrSekantis is KuprinesNr + 1,
    deti_akmeni(Akmuo, Kuprines, KuprinesSuAkmenim, KuprinesNrSekantis, KuprinesSuAkmenimNauja, NaujiKupriniuSvoriai).

/*
deti_akmeni(5, [3,8], [[],[]], 2, Rez, Nauji).
Rez = [[], [5]],
Nauji = [3, 3] ;
*/

prideti_akmeni_prie_kuprines(Akmuo, [Kuprine|KuprinesSuAkmenim], 1, [[Akmuo|Kuprine]|KuprinesSuAkmenim]):- !.
prideti_akmeni_prie_kuprines(Akmuo, [Kuprine|KuprinesSuAkmenim], KuprinesNr, [Kuprine|KuprinesSuAkmenimNauja]):-
    KuprinesNrNaujas is KuprinesNr - 1,
    prideti_akmeni_prie_kuprines(Akmuo, KuprinesSuAkmenim, KuprinesNrNaujas, KuprinesSuAkmenimNauja).

/*
prideti_akmeni_prie_kuprines(5, [[1,2],[2,3],[3,4]], 2, Rezultatas).
Rezultatas = [[1, 2], [5, 2, 3], [3, 4]].
*/

sukurti_kuprines([], []).
sukurti_kuprines([_|Kuprines], [[]|TusciosKuprines]):-
    sukurti_kuprines(Kuprines, TusciosKuprines).

/*
sukurti_kuprines([5,6,3], R).
R = [[], [], []].
*/