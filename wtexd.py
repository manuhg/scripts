#!/usr/bin/python
import re,urllib,base64,os,string
def print_buf(counter, buf):
    buf2 = [('%02x' % ord(i)) for i in buf]
    #print '{0}: {1:<39}  {2}'.format(('%07x' % (counter * 16)),
    print((' '.join([''.join(buf2[i:i + 2]) for i in range(0, len(buf2), 2)]))+"\n"+(''.join([c if c in string.printable[:-5] else '.' for c in buf])))
try:
	f=open("89_Headers.txt")
	
except:
	print("Cant open file ")

patt=re.compile("[&?](([a-z]+)=([^& ]+))")
for l in f:
	m=patt.findall(l)
	if m:
		s=''
		print("=====================");
		for i in range(len(m)):
		#	if m[i][1]=="i" or m[i][1]=="u" : s+=m[i][0]+" "
		#    continue
			if m[i][1]=="tok" :	print(m[i][1]+"=");print_buf(0,base64.b64decode(urllib.unquote(m[i][2]).decode('utf-8')))
			elif m[i][1]=="ref": print(m[i][1]+"=");print(urllib.unquote(m[i][2]).decode('utf-8'))
			else :print(m[i][0])
		print(s)
f.close()
