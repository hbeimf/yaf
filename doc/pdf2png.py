import sys
import PyPDF2
import PythonMagick
from PIL import Image
import os
# pdffilename = "C:\\DEEP.pdf" 

def pdf2png(pdffilename):
	pdf_name = get_pdf_name(pdffilename)
	# pdffilename = "/web/python/pdf/01.401.pdf" 

	pdf_im = PyPDF2.PdfFileReader(file(pdffilename, "rb"))
	 
	print '1'
	 
	imgs = []

	npage = pdf_im.getNumPages()
	print('Converting %d pages.' % npage)
	for p in range(npage):
	    pdf_page = pdffilename + '[' + str(p) +']'
	    print pdf_page

	    im = PythonMagick.Image(pdf_page)
	    im.density('200')
	    im.read(pdf_page)
	    img = './img/'+pdf_name+'_' + str(p)+ '.jpg'
	    im.write(img)
	    imgs.append(img)
	    #print pdffilename + '[' + str(p) +']','file_out-' + str(p)+ '.png'

	print imgs

	width = 0
	height = 0

	for i in range(len(imgs)):
		fromImge = Image.open(imgs[i])
		width = fromImge.size[0]
		height += fromImge.size[1]
		print fromImge.size[0]
		print fromImge.size[1]

	print "width / height: "
	print width
	print height


	toImage = Image.new('RGBA',(width, height))
	# for img in imgs:
	h = 0
	for i in range(len(imgs)):
	    fromImge = Image.open(imgs[i])
	    # loc = ((int(i/2) * fromImge.size[0]), (i % 2) * fromImge.size[1])

	    loc = (0, h)
	    h += fromImge.size[1]

	    # loc = (fromImge.size[0], fromImge.size[1])
	    print(loc)
	    toImage.paste(fromImge, loc)

	# toImage.save('./img/merged.jpg')
	toImage.save('./img/'+pdf_name+'.png')

	for img in imgs:
		os.remove(img)


def get_pdf_name(dir):
	print dir
	lis = dir.split('/')
	print lis
	file_name = lis[len(lis) - 1]
	name = file_name.replace(".pdf", "")
	print name
	return name

# pdffilename = "/web/python/pdf/01.401.pdf" 
# pdffilename = "./pdf/61.2705.pdf" 
# get_pdf_name(pdffilename)

# pdf2png(pdffilename)

rootdir = './pdf/'
lists = os.listdir(rootdir) 
for i in range(0,len(lists)):
	path = os.path.join(rootdir,lists[i])
	if os.path.isfile(path):
		pdf2png(path)
