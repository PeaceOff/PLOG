:- include('tpcs.pl').

disciplina(1,'matematica').
disciplina(2,'portugues ').
disciplina(3,'historia  ').
disciplina(4,'ciencias  ').
disciplina(5,'artes     ').

semana(1,'segunda').
semana(2,'terca').
semana(3,'quarta').
semana(4,'quinta').
semana(5,'sexta').



teste_turma1([[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]]).
teste_turma2([[3,2,1],[2,4,1],[2,2,1],[1,2,3,4,5],[2,3,1]]).

teste_turmas1([
              [[1,2,3],[4,2,3],[5,2,1],[3,4,2],[2,3,1]],
              [[3,2,1],[2,4,1],[2,2,1],[1,2,3,4,5],[2,3,1]],
              [[1,2,3],[4,2,3],[5,2,1],[2,3,1],[3,4,2]],
              [[5,2,1],[4,2,3],[1,2,3],[3,4,2],[2,3,1]]
            ]).
