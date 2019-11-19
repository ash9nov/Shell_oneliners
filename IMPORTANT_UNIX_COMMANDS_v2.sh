#Important Commands for Unix Terminal
-------------------------------------
#munting the network drive of ntnu
> sshfs ashishks@login.nt.ntnu.no: ?home/ashishks/NTNU_DRIVE_MOUNTING
#unmounting
> fusermount -u /home/ashishks/NTNU_DRIVE_MOUNTING
# connecting through <connect to server option>
type this address: smb://home.ansatt.ntnu.no/ashishks/
-------------------------------------

#pattern matching (showing only where patter matched)
> grep 'pattern_to_match' file_name > output_file

#pattern matching and counting the matched lines
> grep 'pattern_to_match' file_name
#SERCHING MULTIPLE WORDS
> grep 'word1\|word2\|word3' /path/to/file

#matching mixed (fixed and variable parameter) pattern in grep
> grep "fixed${variable}fixed" file_name   # note it is important to make the {} , as the curly braces is needed to access positional parameters (arguments to a script) beyond $9.
		#URL: http://wiki.bash-hackers.org/syntax/pe
# grep multiple lines of a command output, for example we picked top 10 line of a file, and need to grep them form another file.
	#step 1: first place those 10 output in a variable and then grep that variable from the other file

# grep a text which includes tab character
> grep -P 'TEXT1\tTEXT2'
	# -P will make grep perl stlye, and '\t' will be use as tab seperator. 

#inverting patter match (showing all except patter matched)
> grep -v 'pattern_to_match' file_name > output_file
	# for multiple patterns
	> grep -vE '(HNF1A|SDHAF2)'

# counting the number of occurance of a word in whole file
> grep -o 'matching_word' file_name |wc -w

#RENAMING the multiple file names
> for f in ./file*.txt; 
	do 
		mv $f ${f/${f:4:8}/REPLACE}; 
	done
	#It replaces the string beween the 4th and the 12th character with "REPLACE".
-----------------------------------------------------------------------------
#counting number of rows in a file
> wc -l file_name

#counting number of columns
> awk -F ' ' '{print NF; exit}' file_name

#selecting a specific column in a file 
> cut -f column_number file_name
	# mentioning a seperatior, then ude -d 
# DE-Selecting a specific column from a file
> cut -f column_number -- complement file_name
	#or
> awk '{$1=""; print}' file_name
-----------------------------------------------------------------------------
# counting number of unique elements in a column in a file
> cut -f column_number file_name |sort|uniq | wc -l
#Note! if want to see the distinct valules remove < wc -l >
# counting number of unique elements and their frequency in a column in a file or multiple files
> cut -f column_number * | sort| uniq -c |sort -nr

# counting the number of each line of a text file
> awk '{ print length($0); }' file_name
	#here $0 is for whole line, if replaced with $1, means first word, and $2 will be second word

# viewing last n lines of a file 
> tail -n file_name

# viewing first n lines of a file 
> head -n file_name
-----------------------------------------------------------------------------
# reading first and last line from file.
> awk 'NR==1; END{print}' file_name

#  code to get nth line from a file
> sed "${NUM}q;d" file # here $NUM is variables
> sed 'NUMq;d' file # here NUM is a number
-----------------------------------------------------------------------------
# sorting a file based on spicific column (let say 3)
sort -k 3,3 file_name     
		#-k 3 is to sort on the portion of the lines starting with the 3rd colum,(except for lines that have an identical third field)
		# -u is to retain only one of the lines if there are several that sort identically

# sorting a file based on chromosome names: eg Chr1,chr2,........Chr10,Chr11,....ChrX,ChrY
sort -k1,1 -V -s example.txt
	#here -k is for column number and 1st 1 is column number, 2nd 1 is sorting considerationis till end of column 1.
	#here -V means is “natural sort of (version) numbers within text” or say sorrting based on numbers.
	# -s for sorting stably.
	#URL for the help is:  http://azaleasays.com/2014/02/21/sort-chromosome-names-with-linux-sort/
	# However this will not work with mac sort, for that we need to use gsort. check link for more details.
# sorting a file by multiple columns. (e.g. sort by 1st column, then sort 2nd column based on 1st column sorting)
sort -k 1,1 -V -s file_name -k 2,2 -k 3,3 -k 5,5 > output_file
-----------------------------------------------------------------------------
#Identifing the file size
> du -hs file_name
-----------------------------------------------------------------------------
# replacing a <pattern/templete> in a file
> sed -i 's/original/new/g' file_name
	#if there is / in the string use \ just before every / in the string
	#e.g. for "a/b" use "a\/b"
			 # s = the substitute command
			 # original = a regular expression describing the word to replace
			 # new = the text to replace it with
			 # g = global (i.e. replace all and not just the first occurrence)
			 # weblink: http://www.theunixschool.com/2014/08/sed-examples-remove-delete-chars-from-line-file.html
# if a variable is used in command then use "|" in place if "/" and also use "" in place if ''
> sed -i "s|$var|r_str|g" file_name
	#or
> sed -i "s|r_str|$var|g" file_name
# if TAB is need to be placed/replaces then use this
> tr ',' '\t' < in.txt > out.txt  # here comma will be replaced by TAB
-----------------------------------------------------------------------------
#removing 1st N characters of every line
> sed -r 's/.{N}//' file_name
			# N = number of characters to replace

#Summing up all the elements of column in a data file
> "print_list_of_numbers_of_column"|awk '{total = total + $1}END{print total}'
#or
> "print_list_of_numbers_of_column"|paste -sd+ - | bc
-----------------------------------------------------------------------------
#prining the lines with their cherecter length
> cat file_name | awk '{print length, $0}'
#printing the longest line of a text file
> cat file_name | awk '{print length, $0}'| sort -nr| head -1
----------------------------------------------------------
# calculating average of a column
> awk '{ total += $2; count++ } END { print total/count }' file.txt
		# where $2 is for column number 2
-----------------------------------------------------------------------------

#Select lines based on value in a column
> awk '$N > Value' file_name  		# N is the column number

-----------------------------------------------------------------------------

# fetching the whole directory of files from internet through terminal.
> mget <filename1> <filename2> ...
    #- or -
> mget -a (to download all the files in the directory)
-----------------------------------------------------------------------------
#  fetching a file from web in MAC OS-X
> curl -O <file_path_URL>
-----------------------------------------------------------------------------
# to check the system monitor trhough terminal
	> glances
	#or
	>top
-----------------------------------------------------------------------------
# Mreging Multiple documents in shell

> convert *.png -gravity South -annotate 0 '%f' all.pdf   # here all png files are merged in one pdf file (and all the png get the file name at end of each page in merged document)
		# URL:  https://askubuntu.com/questions/620423/merging-multiple-images-into-one-document-and-add-any-caption-label-to-them

-----------------------------------------------------------------------------
# append the output of any command to a file
>	command >> file

-----------------------------------------------------------------------------
#getting directory name without full path
> basename "$PWD"

#assigning it a variable
var=$(basename "$PWD")

-----------------------------------------------------------------------------
#merging PDF
> pdfunite in-1.pdf in-2.pdf in-n.pdf out.pdf

-----------------------------------------------------------------------------
# transposing a text file.   (URL: https://stackoverflow.com/questions/1729824/an-efficient-way-to-transpose-a-file-in-bash )
awk '
{ 
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {    
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' file


-----------------------------------------------------------------------------
# combining two file (with same number of rows) column-wise
> paste --delimiters= '_whatever_u want_' fileB fileA
# default delimiter for paste command is TAB
-----------------------------------------------------------------------------
#Parallelizing a while loop with arrays read from a file in bash
while IFS=$'\t' read -r f1 f2;
do
    myprogram "$f1" "$f2" "${f1}_vs_${f2}.result" &

    # At most as number of CPU cores
    [ $( jobs | wc -l ) -ge $( nproc ) ] && wait
done < fileinput

wait

URL: https://stackoverflow.com/questions/16591290/parallelizing-a-while-loop-with-arrays-read-from-a-file-in-bash

-----------------------------------------------------------------------------


-----------------------------------------------------------------------------


-----------------------------------------------------------------------------


-----------------------------------------------------------------------------


-----------------------------------------------------------------------------


-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
# extracting unique values between 2 sets/files

> awk 'FNR==NR {a[$0]++; next} !a[$0]' file1 file2
# here file2 - file1
> grep -v -F -x -f file1 file2
#here file2 - file1

#Checking the folder size:
> du -csh <directory_name>

#Checking the available size in a directory:
> df -Ph .
#checking the available size on system
> df -lah

#changing the permission of a directory
>sudo chown $USER -R <directory_name>

#rearranging the columns of a file
>  awk  'BEGIN{FS="\t"; OFS="\t"} {print $1,$3,$2}' <  file_name

####
#Inner JOIN for two files based on first column (common)
> join -j 1 <(sort file1.txt) <(sort file2.txt)

# Merging multiple rows based on a common entry in a column
> awk -F '\t' 'NF>1{a[$1] = a[$1]"\t"$2}END{for(i in a){print i""a[i]}}' <file_name>
#'\t' here is column seperator, and can be change as per data
# weblink: http://unix.stackexchange.com/questions/124205/merging-multiple-lines-based-on-column-1


#Join command
awk 'FNR==NR { a[$1]=$2; next } $1 in a { print $1, a[$1], $2, $3 }' file1 file2

File 1:
ID1 123
ID2 234
ID3 232
ID4 344
ID5 345
ID6 867

File 2
ID2 A C
ID3 G T
ID1 C T
ID4 A C
So the merged file should look like this:
o/pfile
ID2 234 A C 
ID3 232 G T 
ID1 123 C T 
ID4 344 A C


#---------------------------------------------------------
Arithematics operations
#adding the entries of columns:  http://www.theunixschool.com/2012/09/find-sum-all-numbers-columns-in-line-linux.html
> sed 's/\t/+/g' | bc  file_name

#division of two variables (number) with '6' decimal significant figures
> RESULT=$(awk "BEGIN {printf \"%.6f\",${Var1}/${Var2}}")
----------------------------------------------------------------
#Upadtion of softawares

> sudo apt-get upgrade
> sudo apt-get upgrade <package_name>
> sudo apt-get autoremove
> sudo apt-get update #updates package index
> sudo apt-get dit-upgrade
-----------------------------------------------------------------

#GitHub related Commands:
#cloning a reposetry from GitHub to the local git
# https://help.github.com/articles/importing-a-git-repository-using-the-command-line/
> git clone <repositry_URL>

# To free-up the RAM
> sync
> sudo -s
#or su
> echo 3 > /proc/sys/vm/drop_caches





-------------------------------------------------
# actual path to the network drive on DNA server
	> /etc/fstab: static file system information.
	
	/dev/Data/Datadisk		/data		ext4	defaults	1 2
	//trstolavnas01/Miseq /mnt/miseq cifs sec=ntlmv2,rw,credentials=/home/dna/.smbcredentials,iocharset=utf8 0 0
	//vohsmnas01/avdeling/diverse/forskning/Talseth-Palmer /mnt/palmer cifs rw,credentials=/home/dna/.smbcredentials,iocharset=utf8 0 0
