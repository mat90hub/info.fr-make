TARGET=make.fr
# launch generation and installation of French traduction of the make manual


SOURCE=*.texi

INFO_PATH=/usr/local/share/info/
# this dictory is supposed to have the user access rights;
# otherwise one need to use sudo command.

info: $(SOURCE)
	makeinfo --fill-column 80 $(TARGET).texi
	gzip -f $(TARGET).info*
	cp *.info*.gz -t $(INFO_PATH)
	rm -f *.info*.gz

all: info

.PHONY : clean
clean:
	rm -f *~
	rm -f *.gz
	rm -f *.aux
	rm -f *.cp
	rm -f *.fn
	rm -f *.log
	rm -f *.toc

