% Первая часть задания - предикаты работы со списками

		% Пункт 3
% length()
mylen([], 0).
mylen([_|T], L):- mylen(T, L1), L is L1+1.

% member()
mymember(X, [X|_]).
mymember(X, [_|Y]):- mymember(X, Y).

% append()
myappend([], L, L). %Терминирующее условие с копированием Y в Z
myappend(X, Y, Z):- X=[H_0|T_1], Z=[H_0|T_2], myappend(T_1, Y, T_2).

% remove()
myremove(A, [A|TAIL], TAIL). %Терминирующее условие, при котором происходит встреча основного хвоста и хвоста без конкретного значения
myremove(A, B, C):- B=[H|TAIL], C=[H|TAIL_WITHOUT_X], myremove(A, TAIL, TAIL_WITHOUT_X).

% permute()
mypermute([],[]).
mypermute(L, L_SPEC):- L=[X_IN_L|BUFF], mypermute(BUFF, BUFF_SPEC), L_SPEC = [X_IN_L|BUFF_SPEC].

% sublist()
mysublist1(X, _):- X=[], write('Yeah, boi!').
mysublist1(X, Y):- X=[X_HEAD|X_TAIL], Y=[X_HEAD|Y_TAIL], mysublist1(X_TAIL, Y_TAIL).
mysublist1(X, Y):- Y=[_|Y_TAIL], mysublist1(X, Y_TAIL).
% или же таким образом
mysublist2(X, Y):- myappend(A, _, Y), myappend(_, X, A).


		% Пункт 4
	% Вариант 3. Удаление трех первых элементов списка
% С помощью myremove()
del3first1([A|B], Y):- myremove(A, [A|B], [C|D]), myremove(C, [C|D], [E|F]), myremove(E, [E|F], Y).
	
% Без myremove()
del3first2([_|A], Y):- A=[_|B], B=[_|Y].


		% Пункт 5
	% Вариант 9. Вычисление числа вхождения 1-го элемента
% С помошью mylen() и delete()
inclX(X, LIST, N):- mylen(LIST, N1), delete(LIST, X, SAVE), mylen(SAVE, N2), N is N1-N2.

% Без стандартных предикатов
% Простите меня, пожалуйста, но у меня не получается

		% Пункт 6
	% Пример совместного использования предикатов из 3 и 4 пунктов
% Удаление только второго и третьего элементов
newfunc(X,C):- X=[A|_], Z=[A], del3first2(X,Y), myappend(Z,Y,C).
