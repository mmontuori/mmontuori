#!/usr/bin/python
# -*- coding: utf-8 -*-

import unicodedata
import urllib

u_string = 'Belgio, Martinez gela Nainggolan: "Ãˆ un nÂ°10 e ci sono giÃ  Hazard e Mertens'
#u_string = 'Belgio, Martinez gela Nainggolan: "&#195;&#136; un n&#194;&#176;10 e ci sono gi&#195;&#160; Hazard e Mertens'

print urllib.unquote(u_string).decode()
print u_string.decode('ascii','replace')