import camphr
import spacy
import stanza


class Parser:
    def __init__(self, library=None, lang=None):
        if library == 'stanza':
            self.parser = StanzaParser(lang)
        elif library == 'ginza':
            self.parser = GinzaParser()
        else:
            self.parser = CamphrParser(lang)

    def parse(self, blob):
        return self.parser.parse(blob)


class CamphrParser:
    def __init__(self, lang=None):
        if lang == 'ja': 
            self.nlp = camphr.load('knp') 
        elif lang == 'en':
            self.nlp = spacy.load("en_udify")
        else:
            self.nlp = spacy.load("ja_mecab_udify")

    def parse(self, blob):
        doc = self.nlp(blob)
        return doc.to_json()


class GinzaParser:
    def __init__(self):
        self.nlp = spacy.load('ja_ginza') 

    def parse(self, blob):
        doc = self.nlp(blob)
        return doc.to_json()


class StanzaParser:
    def __init__(self, lang=None):
        if lang:
            self.nlp = stanza.Pipeline(
                lang=lang,
                processors='tokenize,mwt,pos,lemma,depparse'
            )
        else:
           self.nlp = stanza.Pipeline(
               processors='tokenize,mwt,pos,lemma,depparse'
           ) 

    def parse(self, blob):
        doc = self.nlp(blob)
        return doc.to_dict()
