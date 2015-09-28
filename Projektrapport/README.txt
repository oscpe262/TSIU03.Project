Detta är för stunden endast en mall med dummy-filer för respektive kapitel och kommer att ändras vad tiden lider.

Följande kommer dock inte att ändras utan gäller tills vidare:

report.* - grundfiler till rapporten. Kommer inte att behöva ändras om allt vill sig väl.
latexmk.pl - script för att automatiskt uppdatera dokumentet. Ska ej ändras.
	   Körs från linuxterminal enligt: "./latexmk.pl -pvc -pdf report.tex"
fig/ - Här i läggs alla bilder, företrädesvis i .png-format.
tex/ - Här ligger alla textfiler (se nedan).


MAPPEN TEX/
Filen main.tex utgör nästa nivå av rapporten. Här inkluderas respektive kapitel. Det går bra att ändra i den enligt
det format som redan exemplifierats i den. Ändra dock ej de första tre raderna.

När det kommer till kapitelfilerna så ska dessa vara utf-8-formaterade (ett måste) textfiler med ändelsen .tex (för
eventuella windowsmänniskors skull). Jag vill att ni läser min LaTeX-guide, främst kapitel 1-4 och 9, helst innan ni
går vidare i detta dokument om ni inte använt LaTeX tidigare.

Se till att märka upp era sections/chapters etc enligt följande modell: \section{avsnitt}\label{sec:avsnitt}
Detta för att enkelt kunna hänvisa inom dokumentet.

Vi har förvisso vår Dropboxmapp till förfogande, men jag har även speglat den på github, vilken kan underlätta en hel
del när det kommer till att följa ändringar etc, så vill ni ha tillgång till repot, hojta. Ni kommer redan att ha
gitstrukturen i er mapp ... 
