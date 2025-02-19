```bash
Step 8/12 : RUN mkdir -p ${NLTK_DATA} && python -m textblob.download_corpora
 ---> Running in 13ab8a848eb6
Traceback (most recent call last):
  File "<frozen runpy>", line 189, in _run_module_as_main
  File "<frozen runpy>", line 112, in _get_module_details
  File "/opt/conda/lib/python3.11/site-packages/textblob/__init__.py", line 2, in <module>
    from .blob import TextBlob, Word, Sentence, Blobber, WordList
  File "/opt/conda/lib/python3.11/site-packages/textblob/blob.py", line 29, in <module>
    import nltk
  File "/opt/conda/lib/python3.11/site-packages/nltk/__init__.py", line 153, in <module>
    from nltk.translate import *
  File "/opt/conda/lib/python3.11/site-packages/nltk/translate/__init__.py", line 24, in <module>
    from nltk.translate.meteor_score import meteor_score as meteor
  File "/opt/conda/lib/python3.11/site-packages/nltk/translate/meteor_score.py", line 13, in <module>
    from nltk.corpus import WordNetCorpusReader, wordnet
  File "/opt/conda/lib/python3.11/site-packages/nltk/corpus/__init__.py", line 64, in <module>
    from nltk.corpus.reader import *
  File "/opt/conda/lib/python3.11/site-packages/nltk/corpus/reader/__init__.py", line 106, in <module>
    from nltk.corpus.reader.panlex_lite import *
  File "/opt/conda/lib/python3.11/site-packages/nltk/corpus/reader/panlex_lite.py", line 15, in <module>
    import sqlite3
  File "/opt/conda/lib/python3.11/sqlite3/__init__.py", line 57, in <module>
    from sqlite3.dbapi2 import *
  File "/opt/conda/lib/python3.11/sqlite3/dbapi2.py", line 27, in <module>
    from _sqlite3 import *
ImportError: /opt/conda/lib/python3.11/lib-dynload/_sqlite3.cpython-311-x86_64-linux-gnu.so: undefined symbol: sqlite3_deserialize
 ---> Removed intermediate container 13ab8a848eb6
The command '/bin/bash -o pipefail -c mkdir -p ${NLTK_DATA} && python -m textblob.download_corpora' returned a non-zero code: 1
```

