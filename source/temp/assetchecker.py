import hashlib
from PIL import Image
import io

BUF_SIZE = 65536

md5 = hashlib.md5()
sha1 = hashlib.sha1()

with open('test.png', 'rb') as f:
    while True:
        data = f.read(BUF_SIZE)
        if not data:
            break
        md5.update(data)
        sha1.update(data)

print("MD5: {0}".format(md5.hexdigest()))
print("SHA1: {0}".format(sha1.hexdigest()))
if md5.hexdigest() == "90d39dc13f1f7b7fd0e0ee3b15cacef7":
    print("Values match! (file has not been changed)")
else:
    print("Values do not match. (file has been changed")