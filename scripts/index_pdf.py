#!/usr/bin/python3

import os
import sys
import re

pdf="/tmp/index/book.pdf"
num_pages = os.popen("pdfinfo " + pdf + " | grep Pages | sed s'/ //g' | awk -F: '{ print $2 }'").read()
page_dir="/tmp/index/pages"
word_file="/tmp/index/words.txt"


def index_page( page ):
    words_found = ''
    file=open(page_dir+'/'+str(page)+'.txt', 'r')
    c=file.read()
    c=re.sub('[.|;|,|!|?|\n]','',c)
    c=c.split(' ')
    content = []
    for c_word in c:
        content.append(c_word.lower())
    for word in words:
        if word.strip() == '':
            continue
        #print('word: ' + word)
        if word in content:
            #print('word ' + word + ' found in page ' + sys.argv[1])
            if words_found == '':
                words_found = word
            else:
                words_found = words_found + ' ' + word
    return words_found


def create_index():
    index = {}
    files = os.listdir(page_dir)
    for wordfile in files:
        if wordfile.find('-words.txt') != -1:
            page=wordfile.split('-')[0]
            #print(wordfile)
            #print('page: ' + page)
            f=open(page_dir+'/'+wordfile, 'r')
            words=f.read().replace('\n', '').split(' ')
            for word in words:
                if word == '':
                    continue
                if word not in index:
                    pages = []
                    pages.append(int(page))
                    index[word]=pages
                else:
                    pages = index[word]
                    pages.append(int(page))
                    index[word] = pages
    return index

def sort_index( index ):
    sorted_index = []
    for word in sorted(index.keys()):
        pages=index[word]
        pages=sorted(pages)
        pages_str = ''
        first_time = True
        for tpage in pages:
            if first_time is True:
                first_time = False
            else:
                pages_str += ', '
            pages_str += str(tpage)
        #print(word + ': ' + str(pages_str))
        sorted_index.append(word + ':' + str(pages_str))
    return sorted_index


def build_csv( sorted_index ):
    index_length = len(sorted_index)
    if index_length % 2 == 1:
        sorted_index.append('')
        index_length += 1
    for line in range(0, (index_length//2)):
        print(
            '"' + 
            sorted_index[line].split(':')[0] +
            ':"|"' + 
            sorted_index[line].split(':')[1] +
            '"|"' + 
            sorted_index[line+(index_length//2)].split(':')[0] +
            ':"|"' + 
            sorted_index[line+(index_length//2)].split(':')[1] +
            '"'
        )

        

file=open(word_file, 'r')
w=file.read()
w=w.split('\n')
words = []
for w_word in w:
    words.append(w_word.lower())

if os.path.exists(page_dir):
    os.system('rm ' + page_dir + '/*.txt')
else:
    print('directory does not exists')
    os.makedirs(page_dir)

for num_page in range(1, int(num_pages)+1):
    os.system('pdftotext -f ' + str(num_page) + ' -l ' + str(num_page) + ' ' + pdf + ' ' + str(page_dir) + '/' + str(num_page) + '.txt')

for num_page in range(1, int(num_pages)+1):
    found_words=index_page(num_page)
    wf=open(page_dir+'/'+str(num_page)+'-words.txt', 'w')
    wf.write(found_words)
    wf.flush()
    wf.close()

index = create_index()
sorted_index = sort_index(index)
build_csv(sorted_index)