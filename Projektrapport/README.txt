Detta är mallen med dummy-filer för respektive kapitel rapporten ska bestå utav.

Följande gäller (och är ni inte bekanta med principen såhär dags, då är det fan
i mig dags att lära sig :p): 

report.* - grundfilen till rapporten. Kommer inte att behöva ändras om allt vill
sig väl.

latexmk.pl - script för att automatiskt uppdatera dokumentet. Ska ej ändras.
	   Körs från linuxterminal enligt: "./latexmk.pl -pvc -pdf report.tex"
	   Manuell kompilering: "pdflatex report.tex"
	   
fig/ - Här i läggs alla bilder, företrädesvis i .png-format.

tex/ - Här ligger alla textfiler (se nedan).


MAPPEN <./TEX/>
Filen main.tex utgör nästa nivå av rapporten. Här inkluderas respektive kapitel-
fil samt kapiteltitel. Här står även beskrivningen som syns i kompilerad pdf-fil
från början. Denna text tas bort först när kapitlet i det närmaste är klart.
Maximalt sidantal är 12!

När det kommer till kapitelfilerna så ska dessa vara utf-8-formaterade (ett måste)
textfiler med ändelsen .tex (för eventuella windowsmänniskors skull). Jag vill
att ni läser min LaTeX-guide, främst kapitel 1-4 och 9, helst innan ni går vidare
i detta dokument om ni fortfarande är osäkra på LaTeX.

De kapitel och underrubriker som ska förekomma är redan definierade. Inga nya ska
behöva läggas till.

Några (se report.tex för samtliga) specialkommandon tillgängliga är:
\citeD - infogar referens till designspec.
\citeR - infogar referens till kravspec.
\citeF - infogar referens till första pres.sliden
\citeP - infogar referens till projektplanen
\citeM{foo}{nn} - infogar referens till foo.vhd, rad nn. Kräver adekvat referens i
		  references.tex (se vhdldummy)

Vi har förvisso vår Dropboxmapp till förfogande, men jag har även speglat den på
github, vilken kan underlätta en hel del när det kommer till att följa ändringar
etc, så vill ni ha tillgång till repot, hojta. Ni kommer redan att ha git-
strukturen i er mapp. Pushningar kommer, om ingen annan vill använda det, att
ske dagligen.
