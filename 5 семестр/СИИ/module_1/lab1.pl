%------------------Факты------------------

%	Расы персонажей
%	Нелюди (краснолюды, эльфы, мутанты)
dwarf('Zoltan').
mutant('Geralt Of Rivia').
mutant('Lambert').
mutant('Eskel').
mutant('Vesemir').

%	Люди
human('Philippa Eilhart').
human('Triss Merigold').
human('Margarita Laux-Antille').
human('Keira Metz').
human('Fringilla Vigo').
human('Yennefer').
human('Emhyr var Emreis').
human('Foltest').
human('Vizimir').
human('Taler').
human('Dijkstra').
human('Vernon Roche').
human('Cahir').

%	Роли
%	Ведьмаки
witcher('Geralt Of Rivia').
witcher('Lambert').
witcher('Eskel').
witcher('Vesemir').

%	Чародейки
enchantress('Philippa Eilhart').
enchantress('Triss Merigold').
enchantress('Margarita Laux-Antille').
enchantress('Keira Metz').
enchantress('Fringilla Vigo').
enchantress('Yennefer').

%	Правители (императоры и короли)
imperor('Emhyr var Emreis').
king('Foltest').
king('Vizimir').

%	Военные (шпионы и предводители)
spy('Taler').
spy('Dijkstra').
commander('Vernon Roche').
commander('Cahir').

%------------------Свойства------------------
%	Страны, где находятся персонажи
%	Ведьмаки не указаны из-за постоянных путешествий
country('Emhyr var Emreis', 'Nilfgaard').
country('Foltest', 'Temeria').
country('Vizimir', 'Redania').
country('Philippa Eilhart', 'Redania').
country('Triss Merigold', 'Temeria').
country('Margarita Laux-Antille', 'Temeria').
country('Keira Metz', 'Temeria').
country('Fringilla Vigo', 'Nilfgaard').
country('Yennefer', 'Caedven').
country('Vernon Roche', 'Temeria').
country('Cahir', 'Nilfgaard').
country('Taler', 'Temeria').
country('Dijkstra', 'Redania').

%	Специфичные места, где находятся некоторые персонажи
%	Несмотря на то что страна, где находится Аретуза - Темерия, ее обитатели -
%	выходцы из разных мест. Они также не являются подданными определенного короля
place('Margarita Laux-Antille', 'Arethusa').
place('Keira Metz', 'Arethusa').

%	Расположение стран на Континенте
location('Redania', 'North').
location('Temeria', 'North').
location('Caedven', 'North').
location('Nilfgaard', 'South').

%------------------Правила------------------
%	2 персонажа являются соотечественниками, если они из одной страны.
compatriots(Person1, Person2) :- country(Person1, X), country(Person2, X), Person1 \= Person2.
%	2 персонажа являются(лись) любовниками, если один из них - Геральт, а второй - чародейка.
lovers(Person1, Person2) :- Person1 = 'Geralt Of Rivia', enchantress(Person2); Person2 = 'Geralt Of Rivia', enchantress(Person1).
%	2 персонажа находятся в одной части Континента, если их страны расположены на одной части.
from_one_side_of_the_Continent(Person1, Person2) :- country(Person1, Country1), country(Person2, Country2), location(Country1, X), location(Country2, X).
%	2 персонажа являются союзниками, если они находятся на одной части Континента, либо же ведьмаки (по профессиональной солидарности).
allies(Person1, Person2) :- from_one_side_of_the_Continent(Person1, Person2), Person1 \= Person2; witcher(Person1), witcher(Person2), Person1 \= Person2.
%	Персонаж 1 - поданный персонажа 2, если они живут в одной стране и Персонаж 2 - король/император. За исключеием некоторых случаев.
subject(Person1, Person2) :- compatriots(Person1, Person2), (king(Person2); imperor(Person2)), not(place(Person1, 'Arethusa')).
%	Персонаж является военным, если он шпион или командир.
military(Person) :- spy(Person); commander(Person).
%	Персонаж умеет сражаться, если он военный, ведьмак или краснолюд.
can_fight(Person) :- military(Person); witcher(Person); dwarf(Person).
%	Персонаж использует магию, если он чародейка или ведьмак. 
magician(Person) :- enchantress(Person); witcher(Person).
%	Персонаж может находиться в Новиграде, если он не чародейка и не нелюдь. Исключение - ведьмаки.
can_be_in_Novigrad(Person) :- not(enchantress(Person)), (human(Person); witcher(Person)).


%------------------Запросы------------------
%	Простые для поиска фактов
% Геральт из Ривии - ведьмак?
% witcher('Geralt Of Rivia') - true
% Каэдвен находится на Севере?
% location('Caedven', 'North') - true
% Фольтест - император?
% imperor('Foltest') - false
% Золтан - человек?
% human('Zoltan') - false
% Трисс Меригольд - из Темерии?
% country('Triss Merigold', 'Temeria') - true

%	Составные для поиска фактов
%	Визимир - король и живет в Темерии или Редании?
% king('Vizimir'), (country('Vizimir', 'Temeria'); country('Vizimir', 'Redania')) - true
% Золтан - краснолюд-чародейка и живет в Каэдвене?
% dwarf('Zoltan'), country('Zoltan', 'Caedven'), enchantress('Zoltan') - false
% Дийкстра - шпион из Темерии?
% spy('Dijkstra'), country('Dijkstra', 'Temeria') - false
% Филиппа Эйльхарт - чаролейка и находится в Аретузе?
% enchantress('Philippa Eilhart'), place('Philippa Eilhart', 'Arethusa') - false
% Кейра Мец и Маргарита Ло-Антилль обе либо в Аретузе либо не там?
% (place('Keira Metz', 'Arethusa'), place('Margarita Laux-Antille', 'Arethusa'); not(place('Keira Metz', 'Arethusa')), not(place('Margarita Laux-Antille', 'Arethusa'))) - true

%	Поиск объектов с определенными характеристиками через переменные
% Люди, живущие в Редании
% human(X), country(X, 'Redania') - X = {'Philippa Eilhart', 'Vizimir', 'Dijkstra'}
% Высокопоставленные люди (император/король, предводители) из Темерии
% human(X), country(X, 'Temeria'), (commander(X); imperor(X)) - X = 'Vernon Roche'
% Чародейки с Юга, с эльфийской кровью
% enchantress(X), country(X, Y), location(Y, 'South'), elf(X) - false
% Северные короли/императоры
% (king(X); imperor(X)), country(X, Y), location(Y, 'North') - X = {'Foltest', 'Vizimir'}, Y = {'Temeria', 'Redania'}
% Чародейки, работающие на Темерию с Вероном Роше
% enchantress(X), country(X, Y), country('Vernon Roche', Y), not(place(X), 'Arethusa') - X = 'Triss Merigold', Y = 'Temeria'

%	Требуют выполнения правил для получения рез-та
% Люди, живущие в одной стране с Фольтестом, но не являющиеся его подчиненными
% human(X), compatriots(X, 'Foltest'), not(subject(X, 'Foltest')) - X = {'Margarita Laux-Antille', 'Keira Metz'}
% Военные, находящиеся на одной части Континента с императором
% military(X), from_one_side_of_the_Continent(X, Y), imperor(Y) - X = 'Cahir', Y = 'Emhyr var Emreis'
% Люди, обладающие магическими силами, которые умеют сражаться и являются союзниками Весемира
% magician(X), can_fight(X), allies(X, 'Vesemir'), X \= 'Vesemir' - X = {'Geralt Of Rivia', 'Lambert', 'Eskel'}
% Полководец, против которого может сражаться Верон Роше
% military(X), not(allies(X, 'Vernon Roche')) - X = {'Cahir'}
% Люди, обладающие магической силой, способные находится в Новиграде и имеющие любовников
% magician(X), can_be_in_Novigrad(X), lovers(X, _), ! - X = 'Geralt Of Rivia'





