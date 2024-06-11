% Task 2: Relational Data

% The line below imports the data
:- ['four.pl'].
% 2. Вариант 2
	% - Напечатать средний балл для каждого предмета

%Сумма списка целых чисел
sumlist([], 0).
sumlist([FIRST|REST], SUM):- sumlist(REST, SUM_REST), SUM is FIRST + SUM_REST.

%Функция создания  утверждений в зависимости от одного предмета в формате subj('Предмет', grade('Имя', Оценка))
make_clauses(_,[]).
make_clauses(X,Y):- Y=[Y_HEAD|Y_TAIL], assert(subj(X, Y_HEAD)), make_clauses(X, Y_TAIL).

%Функция создания  всех утверждений для списка предметов в формате subj('Предмет', grade('Имя', Оценка))
make_subj_clauses([]).
make_subj_clauses(X):- X=[X_HEAD|X_TAIL], findall(A, subject(X_HEAD, A), [GET|_]), make_clauses(X_HEAD, GET), make_subj_clauses(X_TAIL).

%Создание утверждений в формате subj('Предмет', grade('Имя', Оценка))
subj_clauses(X):- findall(A, subject(A, _), X), make_subj_clauses(X).

%Нахождение и печать среднего рейтинга в консоль
avg_rating([]).
avg_rating(X):- X=[X_H|X_T], findall(GRADE, subj(X_H, grade(_,GRADE)), SAVE),length(SAVE,SAVE_LEN),sumlist(SAVE,SAVE_SUM),
	AVG_GRADE is SAVE_SUM/SAVE_LEN, write(X_H), write(' = '), write(AVG_GRADE), nl,
	avg_rating(X_T).

%Итоговая функция:
write_avg_rating():- subj_clauses(X), avg_rating(X), retractall(subj(_,_)).


	% - Для каждой группы, найти количество не сдавших студентов
find_amt_losers([]).
find_amt_losers([GR_H|GR_T]):- findall(NAME, group(GR_H, NAME), BUF), BUF = [NAMES],
	write('Losers of '), write(GR_H), write(' group are:'), nl,
	find_amt_losers_gr(GR_H, NAMES),
		find_amt_losers(GR_T).

find_amt_losers_gr(_, []).
find_amt_losers_gr(GR, [NAM_H|NAM_T]):- findall(NAM_H, subj(SUB, grade(NAM_H, 2)), NAMES), findall(SUB, subj(SUB, grade(NAM_H, 2)), SUBS),
	write_losers(SUBS, NAMES),
	find_amt_losers_gr(GR, NAM_T).
write_losers([], []).
write_losers([S_H|S_T], [L_H|L_T]):- write('		'), write(L_H), write(' ('), write(S_H), write(')'), nl, write_losers(S_T, L_T).
write_all_losers_gr():- subj_clauses(_), findall(A, group(A,_), GROUPS), find_amt_losers(GROUPS), retractall(subj(_,_)).

	% - Найти количество не сдавших студентов для каждого из предметов
find_losers_subj([]).
find_losers_subj([X_HEAD|X_TAIL]):- findall(A, subj(X_HEAD, grade(A,2)), SAVE), length(SAVE, LEN),
	write('	'), write(X_HEAD), write(': '), write(LEN), nl,
	find_losers_subj(X_TAIL).

write_all_losers_subj():- subj_clauses(X), write('Количество двоечников по каждому предмету: '), nl, find_losers_subj(X), retractall(subj(_,_)).

%Общая функция на три пункта:
make_prolog_great_again(1):- write(' 1) Напечатать средний балл для каждого предмета'), nl, write_avg_rating(), nl.
make_prolog_great_again(2):- write(' 2) Для каждой группы, найти количество не сдавших студентов'), nl, write_all_losers_gr(), nl.
make_prolog_great_again(3):- write(' 3) Найти количество не сдавших студентов для каждого из предметов'), nl, write_all_losers_subj(), nl.
make_prolog_great_again():- make_prolog_great_again(1), make_prolog_great_again(2), make_prolog_great_again(3). 
							