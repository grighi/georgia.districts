import wget
# import html.parser  # use BeautifulSoup instead
from bs4 import BeautifulSoup 
import lxml
import urllib
import zipfile as z

url = 'http://results.enr.clarityelections.com/GA/63991/184321/en/select-county.html'
html = urllib.request.urlopen(url).read()

soup = bs(html, "html.parser")
counties = soup.findAll("li")

prefix = "http://results.enr.clarityelections.com/GA"
end = "reports/detailxml.zip"

for element in counties:
    sub = element.a["value"]
    second = BeautifulSoup(urllib.request.urlopen(prefix + sub).read(), "html.parser")
    dropind = sub.index('/index.html')
    secnum = second.findAll("script")[0]["src"]
    xmlzip = prefix + sub[0:dropind] + secnum[1:9] + end
    filename = wget.download(xmlzip)
    
    with z.ZipFile(filename, 'r') as zip:
        xmlfile = zip.open('detail.xml').read()
        
    xml = BeautifulSoup(xmlfile, "xml")
    
    # If president is always the first listed contest, this should work
    # otherwise may need some contest == 'president'
    for president in xml.ElectionResult.Contest.findAll('Choice'):
        print(president['text'])
        president.Precinct
        
        table = president.VoteType.findAll()
        
        df = pd.DataFrame(columns = columns)
                          
        for rows in table:
            rows['name']
        
        [0]['text']


     
     counties[element.a.get_text()]["Value"] = prefix +

tmp = soup.findAll("a")[3].value()

1. 10 min pandas
http://pandas.pydata.org/pandas-docs/stable/10min.html
2. parsing
http://srome.github.io/Parsing-HTML-Tables-in-Python-with-BeautifulSoup-and-pandas/
3. BS intro
https://www.crummy.com/software/BeautifulSoup/bs4/doc/#parser-installation
