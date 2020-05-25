import os

import stanza


env = os.environ
LIBRARY = env.get('LIBRARY')
LANG = env.get('LANG')


def download(library=None, lang=None):
    if lang is None:
        language = 'en'
    else:
        language = lang

    if library == 'stanza':
        stanza.download(language)

    return


if __name__ == '__main__':
    download(library=LIBRARY, lang=LANG)