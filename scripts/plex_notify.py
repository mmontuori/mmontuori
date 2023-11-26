#!/usr/bin/env python3

import datetime
from urllib.request import Request, urlopen
import json
import lxml
from lxml import html
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

send_email = True
gmail_user = 'scfsc.media@gmail.com'
#gmail_password = 'twzdzoqpsrzkrdds'
gmail_password = 'pzglyvxjxoknxuup'
gmail_to = 'icetimenotify@googlegroups.com'


now = datetime.date.today()
tomorrow = now + datetime.timedelta(days=1)

year = now.strftime("%Y")
t_year = tomorrow.strftime("%Y") 

day = int(now.strftime("%d"))
t_day = int(tomorrow.strftime("%d"))

month = now.strftime("%B")
t_month = tomorrow.strftime("%B")

todays_date = month + " " + str(day) + ", " + year
tomorrows_date = t_month + " " + str(t_day) + ", " + t_year

gmail_subject = 'Plex Ice Schedule for ' + todays_date

url = 'https://flightadventurepark.com/wp-json/wp/v2/pages/8450'

schedule_url = 'https://flightadventurepark.com/irmo/ice-skating-calendar/'

req = Request(url, headers={'User-Agent': 'Mozilla/5.0'})

html_page = urlopen(req).read().decode('utf-8')

json_obj = json.loads(html_page)

content = json_obj['content']['rendered']

tree = lxml.html.fromstring(content)

elements = tree.xpath('//div[@class="simcal-event-details simcal-tooltip-content"]')

gmail_body = ''
gmail_body += '<div style="font-size:150%;">'
gmail_body += 'This e-mail contains the Plex Ice Schedule for today and tomorrow.<br><br>'
gmail_body += todays_date + ' (Today):<br>'
gmail_body += "<table border='1'>"
gmail_body += "<tr><th>Event Name</th><th>Event time</th><tr>"

for element in elements:
    event_name = element[0].text_content()
    event_datetime = element[1].text_content()
    event_datetime = event_datetime.replace("  ", " ").replace('\n','').replace('\r','').encode('ascii', 'replace').decode('utf-8').replace('??',' :: ')
    event_date = event_datetime.split(" ")[0] + ' ' + event_datetime.split(" ")[1] + ' ' + event_datetime.split(" ")[2][0:4]
    event_time = event_datetime.split(' :: ')[1]
    if todays_date == event_date:
        gmail_body += "<tr><td>" + event_name + '</td><td>' + event_time + '</td></tr>'

gmail_body += "</table>"
gmail_body += '<br>' + tomorrows_date + ' (Tomorrow):<br>'
gmail_body += "<table border='1'>"
gmail_body += "<tr><th>Event Name</th><th>Event time</th><tr>"

for element in elements:
    event_name = element[0].text_content()
    event_datetime = element[1].text_content()
    event_datetime = event_datetime.replace("  ", " ").replace('\n','').replace('\r','').encode('ascii', 'replace').decode('utf-8').replace('??',' :: ')
    event_date = event_datetime.split(" ")[0] + ' ' + event_datetime.split(" ")[1] + ' ' + event_datetime.split(" ")[2][0:4]
    event_time = event_datetime.split(' :: ')[1]
    if tomorrows_date == event_date:
        gmail_body += "<tr><td>" + event_name + '</td><td>' + event_time + '</td></tr>'

gmail_body += "</table>"
gmail_body += "<br>Click <a href='" + schedule_url + "'>here</a> to look at the monthly schedule."
gmail_body += "</div>"

if send_email is True:
    message = MIMEMultipart("alternative")
    message["Subject"] = gmail_subject
    message["From"] = gmail_user
    message["To"] = gmail_to 

    part1 = MIMEText(gmail_body, "html")

    message.attach(part1)

    gmail_body = msg = "\r\n".join([
        "From: michael.montuori@gmail.com",
        "Subject: " + gmail_subject,
        "",
        gmail_body
    ])

    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.ehlo()
    server.login(gmail_user, gmail_password)
    server.sendmail(gmail_user, message["To"].split(","), message.as_string())
    server.close()
else:
    print(gmail_body)
